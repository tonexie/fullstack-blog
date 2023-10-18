const express = require('express');
const router = express.Router();

const articleDao = require('../../models/articles-dao.js');

const QuillDeltaToHtmlConverter =
  require('quill-delta-to-html').QuillDeltaToHtmlConverter;
const uploadTempFolder = require("../../middleware/multer-uploader.js");
const fs = require("fs");
const jimp = require("jimp");

router.post("/api/postNewArticle", uploadTempFolder.single("imageKey"), async function (req, res) {
    const newArticle = req.body;
    console.log(newArticle);
  
    const user_id = res.locals.user.id;
    const title = newArticle.titleKey;
    const genre = newArticle.genreKey;
    const content = newArticle.contentKey;
  
    try {
      const contentArray = convertDeltaToHtml(content);
      const html = contentArray[0];
      const delta_obj_string = contentArray[1];
  
      //Get article image
      const fileInfo = req.file;
      let done = undefined;
      let imagePath;
  
      if (fileInfo) {
        imagePath = "user" + user_id + "-" + fileInfo.originalname;
        processAndStoreImage(fileInfo, imagePath);
        done = await articleDao.insertNewArticleToArticleTable(user_id, title, genre, html, delta_obj_string, imagePath);
      } else {
        done = await articleDao.insertNewArticleToArticleTableWithoutImage(user_id, title, genre, html, delta_obj_string)
      }
  
      if (done) {
        res.status(200).send("New Article Created!");
      }
    } catch (e) {
      res.status(404).send("Publishing error, try again!" + e);
    }
  
  });

  router.get('/api/currentEditArticleDelta', async (req, res) => {
    const article_id = req.query.article_id;
    const article = await articleDao.getArticlesByID(article_id);
  
    if (article) {
      res.status(200).json(article);
    } else {
      res.status(404).send("Article loading error, please try again");
    }
  });
  
  router.post("/api/updateArticle", uploadTempFolder.single("imageKey"), async function (req, res) {
    const updateArticle = req.body;
    const user_id = res.locals.user.id;
  
    const article_id = updateArticle.article_id_key;
    const title = updateArticle.titleKey;
    const genre = updateArticle.genreKey;
    const content = updateArticle.contentKey;
  
    try {
      const contentArray = convertDeltaToHtml(content);
      const html = contentArray[0];
      const delta_obj_string = contentArray[1];
  
      //Get article image
      const fileInfo = req.file;
      let done = undefined;
      let imagePath;
  
      if (fileInfo) {
        imagePath = "user" + user_id + "-" + fileInfo.originalname;
        processAndStoreImage(fileInfo, imagePath);
        done = await articleDao.updateArticleToArticleTable(article_id, title, genre, html, delta_obj_string, imagePath);
      } else {
        done = await articleDao.updateArticleToArticleTableWithoutImage(user_id, title, genre, html, delta_obj_string)
      }
  
      if (done) {
        res.status(200).send("Article updated");
      }
  
    } catch (e) {
      res.status(404).send("Publishing error, try again!");
    }
  
  });


async function processAndStoreImage(fileInfo, imagePath) {
    const oldFileName = fileInfo.path;
    const newFileName = `./public/images/article-images/${imagePath}`;
    fs.renameSync(oldFileName, newFileName);
  
    //Create and save thumbnail
    const image = await jimp.read(newFileName);
    image.resize(320, jimp.AUTO);
    const font = await jimp.loadFont(jimp.FONT_SANS_32_WHITE);
    let name = fileInfo.originalname.substring(0, fileInfo.originalname.lastIndexOf("."));
    name = name.substring(0, 1).toUpperCase() + name.substring(1).toLowerCase();
    image.print(font, 10, 10, name);
  
    await image.write(`./public/images/article-images/thumbnails/${imagePath}`);
  }
  
  function convertDeltaToHtml(content) {
    let contentArray = [];
  
    const content_obj = JSON.parse(content);
    const delta_obj = content_obj.ops;
    const delta_obj_string = JSON.stringify(delta_obj);
  
    const cfg = {
      inlineStyles: true,
      multiLineBlockquote: true,
      multiLineHeader: true
    };
  
    const converter = new QuillDeltaToHtmlConverter(delta_obj, cfg);
  
    const html = converter.convert();
  
    contentArray = [html, delta_obj_string];
  
    return contentArray;
  }

module.exports = router;