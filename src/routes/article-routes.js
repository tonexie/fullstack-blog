const express = require('express');
const router = express.Router();
const articleDao = require('../models/articles-dao.js');
const commentDao = require('../models/comments-dao.js');
const searchDao = require('../models/search-dao.js');
const likeDao = require('../models/like-dao.js');


router.get('/writeArticle', function (req, res) {
    res.render('writeArticle');
});

router.get('/article/:id', async function (req, res) {
    if (res.locals.user) {
        res.locals.user_id = res.locals.user.id;
    }

    const article_id = req.params.id;

  try {

    const article = await articleDao.getArticlesByID(article_id);

    const articleId = article[0].id;

        res.locals.article = article;

        const authorName = await articleDao.getAuthorByArticle(articleId);
        res.locals.authorName = authorName;

        const likeCounts = await likeDao.getNumberOfLikesFromArticle(articleId);
        res.locals.like_count = likeCounts;

        const comments =
            await commentDao.getAllFirstLevelCommentsByArticleID(articleId);

        async function getAllComments(comments) {
            try {
                const processedComments = await Promise.all(
                    comments.map(async (comment) => {
                        try {
                            const secondLevelComments =
                                await commentDao.getAllSecondOrThirdLevelCommentsByComment_id(
                                    comment.id,
                                    article_id
                                );
                            comment['second_level_comments'] =
                                secondLevelComments;

                            const secondLevelComment =
                                comment.second_level_comments;

                            await Promise.all(
                                secondLevelComment.map(async (comment) => {
                                    try {
                                        const thirdLevelComments =
                                            await commentDao.getAllSecondOrThirdLevelCommentsByComment_id(
                                                comment.id,
                                                article_id
                                            );
                                        comment['third_level_comments'] =
                                            thirdLevelComments;
                                    } catch (e) {
                                        throw new Error(
                                            'Comments loading failed'
                                        );
                                    }
                                })
                            );

                            return comment;
                        } catch (e) {
                            throw new Error('Comments loading failed.');
                        }
                    })
                );
                return processedComments;
            } catch (e) {
                throw new Error('Comments loading failed.');
            }
        }

        const commentsForThisAriticle = await getAllComments(comments);
        res.locals.comments = commentsForThisAriticle;

        res.render('articleDemo');
    } catch (error) {
        const html = '<p>Error occured: <p>';
        res.locals.article_content = html + error;
    }
});

router.get('/editArticle/:id', async (req, res) => {
    const article_id = req.params.id;

    res.locals.article_id = article_id;

    res.render('editArticle');
});

router.get('/calendar', async function (req, res) {
    res.render('test');
});

router.get('/genre/:genreType', async function (req, res) {
  const genreType = req.params.genreType;

  const articles = await searchDao.filterArticlesByGenre(genreType)

    res.locals.articles = articles;
    res.render('searchedArticles');
});

router.get('/genre', async function (req, res) {
    res.render('searchedArticles');
});

module.exports = router;
