// General queries with the database
const SQL = require('sql-template-strings');
const { getDatabase } = require('../db/database.js');

async function getArticlesByTitleForSearch(title){
    console.log(title) 
    if(title == ""){
        return undefined
    }
    const db = await getDatabase();
    const titleSearch = `%${title}%`

    const articles = await db.all(SQL`
        select * from Articles_info
        where title like ${titleSearch}
    `)
    return articles
}

async function getArticlesByAuthorNameForSearch(author){

    console.log(author)
    if(author == ""){
        return undefined
    }
    const db = await getDatabase();
    const authorSearch = `%${author}%`;

    const articles = await db.all(SQL`
        select * from user
        where fname like ${authorSearch} or lname like ${authorSearch}
    `)
    return articles
}

async function getArticlesBySingleDate(date){
    const db = await getDatabase();
    const dateS = `${date}`
    const articles = await db.all(SQL`
        SELECT articles.title, comments_count, date(articles.date_of_publish) as date from Articles_info left join articles on Articles_info.article_id = articles.id
        where date = ${dateS}
    `)
    return articles
}

async function filterArticlesByGenre(genre) {
    const db = await getDatabase();
    const genre1 = `${genre}`

    const articles = await db.all(SQL `
    select articles.*, user.*
    from articles
    inner join user on articles.author_id = user.id
    where genre like ${genre1}
    `)

    return articles;
}

async function filterArticlesBySelectedDates(startDate, endDate) {
    const db = await getDatabase();

    const articles = await db.all(SQL `
        select articles.*, user.*
        from articles 
        inner join user on articles.author_id = user.id
        where date_of_publish >= ${startDate} and date_of_publish <= ${endDate}
    `)
    return articles;
}


module.exports = {
    getArticlesByTitleForSearch,
    getArticlesByAuthorNameForSearch,
    getArticlesBySingleDate,
    filterArticlesByGenre,
    filterArticlesBySelectedDates
}