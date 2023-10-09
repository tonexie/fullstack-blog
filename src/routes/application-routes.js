const express = require('express');
const router = express.Router();

const testDao = require('../models/test-dao.js');

router.get('/', async function (req, res) {
    res.locals.title = 'My route title!';
    res.locals.allTestData = await testDao.retrieveAllTestData();

    res.render('home');
});


router.get('/register', function(req, res) {
    res.render('register');
})

module.exports = router;
