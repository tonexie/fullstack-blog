/*
 * Upon submission, this file should contain the SQL script to initialize your database.
 * It should contain all DROP TABLE and CREATE TABLE statments, and any INSERT statements
 * required.
 * 
 * It is recommened for your server automatically create & init the database
 * 
 * However this script will serve as documentation / backup for how your database is designed
 */


DROP TABLE IF EXISTS notify;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS subscription;
DROP TABLE IF EXISTS likes_comments;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS user;

CREATE TABLE user
(
    id          INTEGER     NOT NULL PRIMARY KEY,
    username    VARCHAR(28) NOT NULL,
    password    VARCHAR(28) NOT NULL,
    auth_token  VARCHAR(100),
    email       VARCHAR(28),
    fname       VARCHAR(28),
    lname       VARCHAR(28),
    DOB         DATE,
    description VARCHAR(120),
    icon_path   VARCHAR(20),
    admin       INTEGER     NOT NULL,
    CHECK (admin >= 0 AND admin <= 1)
);

INSERT INTO user
    (id, username, password, fname, lname, DOB, description, icon_path, admin)
VALUES
    (1, 'user1', '$2b$10$E3bLcihN46HGIzd9ue1SH.XWbw41Ba0Eohx2vokivFFwuBkzqVGv2', 'John', 'Doe', '1990-01-01', 'User 1', '/images/avatars/guy1.png', 0),
    (2, 'user2', '$2b$10$E3bLcihN46HGIzd9ue1SH.XWbw41Ba0Eohx2vokivFFwuBkzqVGv2', 'Jane', 'Smith', '1995-03-15', 'User 2', '/images/avatars/girl2.png', 0),
    (3, 'user3', '$2b$10$E3bLcihN46HGIzd9ue1SH.XWbw41Ba0Eohx2vokivFFwuBkzqVGv2', 'Bob', 'Johnson', '1988-07-20', 'User 3', '/images/avatars/guy2.png', 0),
    (4, 'user4', '$2b$10$E3bLcihN46HGIzd9ue1SH.XWbw41Ba0Eohx2vokivFFwuBkzqVGv2', 'Alice', 'Williams', '1992-09-10', 'User 4', '/images/avatars/girl1.png', 0),
    (5, 'user5', '$2b$10$E3bLcihN46HGIzd9ue1SH.XWbw41Ba0Eohx2vokivFFwuBkzqVGv2', 'Charlie', 'Brown', '1998-12-05', 'User 5', '/images/avatars/guy3.png', 0),
    (6, 'user6', '$2b$10$E3bLcihN46HGIzd9ue1SH.XWbw41Ba0Eohx2vokivFFwuBkzqVGv2', 'Eve', 'Anderson', '1993-04-30', 'User 6', '/images/avatars/girl3.png', 0),
    (7, 'user7', '$2b$10$E3bLcihN46HGIzd9ue1SH.XWbw41Ba0Eohx2vokivFFwuBkzqVGv2', 'David', 'Wilson', '1996-06-25', 'User 7', '/images/avatars/guy4.png', 0),
    (8, 'user8', '$2b$10$E3bLcihN46HGIzd9ue1SH.XWbw41Ba0Eohx2vokivFFwuBkzqVGv2', 'Grace', 'Miller', '1991-11-15', 'User 8', '/images/avatars/girl4.png', 0),
    (9, 'user9', '$2b$10$E3bLcihN46HGIzd9ue1SH.XWbw41Ba0Eohx2vokivFFwuBkzqVGv2', 'Frank', 'Martinez', '1987-02-08', 'User 9', '/images/avatars/guy5.png', 0),
    (10, 'user10', '$2b$10$E3bLcihN46HGIzd9ue1SH.XWbw41Ba0Eohx2vokivFFwuBkzqVGv2', 'Olivia', 'Jones', '1994-08-12', 'User 10', '/images/avatars/girl6.png', 0);

CREATE TABLE articles
(
    id              INTEGER       NOT NULL PRIMARY KEY,
    title           VARCHAR(88)   NOT NULL,
    content         VARCHAR(8000) NOT NULL,
    genre           VARCHAR(20),
    date_of_publish TIMESTAMP     NOT NULL,
    author_id       INTEGER       NOT NULL,
    FOREIGN KEY (author_id) REFERENCES user (id)
);

-- Inserting 15 rows of sample data into the articles table
-- Insert 15 articles with HTML-formatted content
INSERT INTO articles (id, title, content, genre, date_of_publish, author_id) VALUES
(1,'The Beauty of Silk', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Silk', '2023-10-13 10:00:00', 1),
(2, 'Cotton vs. Linen', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Cotton', '2023-10-13 11:00:00', 2),
(3, 'Weaving Wonders', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Loom', '2023-10-13 12:00:00', 3),
(4, 'Textiles Through the Ages', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'History', '2023-10-13 13:00:00', 4),
(5, 'Dyeing Techniques', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Dyeing', '2023-10-13 14:00:00', 5),
(6, 'Sustainable Fabrics', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Eco-Friendly', '2023-10-13 15:00:00', 6),
(7, 'Wool: The Versatile Fiber', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Wool', '2023-10-13 16:00:00', 7),
(8, 'Designing with Fabrics', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Design', '2023-10-13 17:00:00', 8),
(9, 'The Art of Knitting', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Knitting', '2023-10-13 18:00:00', 9),
(10, 'Fashion Forward', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Fashion', '2023-10-13 19:00:00', 10),
(11, 'Draping Techniques', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Draping', '2023-10-13 20:00:00', 1),
(12, 'The Art of Embroidery', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Embroidery', '2023-10-13 21:00:00', 2),
(13, 'Leather Crafting', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Leather', '2023-10-13 22:00:00', 3),
(14, 'Fiber Arts in Modern Design', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Modern', '2023-10-13 23:00:00', 4),
(15, 'The Science of Textiles', '<h1 style="text-align:center"><span style="color:#0066cc">Lorem Ipsum</span></h1><h4 style="text-align:center"><em>&quot;Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...&quot;</em></h4><h5 style="text-align:center"><span style="color:#facccc">&quot;There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...&quot;</span></h5><p style="text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sit amet augue a ex efficitur blandit quis ut augue. Integer sollicitudin lacinia tincidunt. Duis quis facilisis purus, nec feugiat augue. Fusce consectetur eros risus, quis facilisis purus facilisis sit amet. Aliquam congue porttitor elementum. Aenean sed convallis ex. Maecenas ornare, dui sed ullamcorper iaculis, mi lorem lacinia mauris, in sollicitudin nulla diam vitae risus. Proin<s> porta in mauris</s> nec aliquam.</p><p style="text-align:justify">Ut sed lobortis lorem. Proin males<span style="font-family: Monaco, Courier New, monospace">uada mollis ex, feugiat malesuada ipsum placerat nec. Vivamus lacus sapien, auctor ut porttitor vitae, luctus eget lectus. Suspendisse maximus fermentum odio. Aenean </span><em style="font-family: Monaco, Courier New, monospace">euismod,</em><span style="font-family: Monaco, Courier New, monospace"> turpis eget bibendum varius, neque leo viverra arcu, lacinia tristique enim massa quis massa. Cras quis fringilla velit. Vivamus ut accumsan leo, vel venenatis urna. Aliquam et risus vulputate, viverra turpis sed, ullamcorper ligula. Sed metus quam, efficitur ut enim id, posuere hendrerit elit. Morbi tincidunt mauris eros, ut tempor est maximus sit amet. Suspendisse consectetur, urna eget ultrices auctor, neque diam dictum sem, eu faci</span><span style="color:#006100;font-family: Monaco, Courier New, monospace">lisis ante enim id nunc. Morbi vulputate porttitor dui, vitae dictum augue. Phasellus sed vestibulum metus. Fusce in maximus risus, sed tempus ante.</span></p><p style="text-align:justify"><span style="color:#006100;font-family: Monaco, Courier New, monospace">Nunc convallis tortor accumsan, rutrum lacus iaculi</span><span style="font-family: Monaco, Courier New, monospace">s, aliq</span>uet urna. Quisque sit amet auctor sem. In fermentum consequat felis eleifend gravida. Morbi nisi tellus, aliquam luctus tincidunt in, cursus et mi. Aliquam erat volutpat. Suspendisse potenti. L</p><p><br/></p>', 'Science', '2023-10-14 00:00:00', 5);


CREATE TABLE comments
(
    id              INTEGER   NOT NULL,
    user_id         INTEGER   NOT NULL,
    article_id      INTEGER   NOT NULL,
    content         VARCHAR(1000),
    time_of_comment TIMESTAMP NOT NULL,
    comments_id     INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES user (id),
    FOREIGN KEY (article_id) REFERENCES articles (id)
);

-- Inserting 20 rows of sample data into the comments table with NULL comments_id
INSERT INTO comments (id, user_id, article_id, content, time_of_comment, comments_id)
VALUES (1, 1, 1, 'Great article!', '2023-10-10 10:15:00', NULL),
       (2, 2, 1, 'I learned a lot from this.', '2023-10-10 11:30:00', NULL),
       (3, 3, 2, 'Silk fabric is so elegant!', '2023-10-10 12:45:00', NULL),
       (4, 4, 2, 'I love wearing silk!', '2023-10-10 14:00:00', NULL),
       (5, 5, 3, 'Cotton is my favorite fabric.', '2023-10-10 15:15:00', NULL),
       (6, 1, 3, 'Polyester is versatile.', '2023-10-10 16:30:00', NULL),
       (7, 2, 4, 'Wool keeps you warm in winter.', '2023-10-10 17:45:00', NULL),
       (8, 3, 4, 'I have a wool sweater.', '2023-10-10 19:00:00', NULL),
       (9, 4, 5, 'Linen is great for summer.', '2023-10-10 20:15:00', NULL),
       (10, 5, 5, 'I need linen sheets.', '2023-10-10 21:30:00', NULL),
       (11, 1, 6, 'Satin is so luxurious!', '2023-10-10 22:45:00', NULL),
       (12, 2, 6, 'I have a satin dress.', '2023-10-10 23:59:00', NULL),
       (13, 3, 7, 'Denim jeans are classic.', '2023-10-11 10:15:00', NULL),
       (14, 4, 7, 'I like distressed denim.', '2023-10-11 11:30:00', NULL),
       (15, 5, 8, 'Velvet feels so soft.', '2023-10-11 12:45:00', NULL),
       (16, 1, 8, 'I have a velvet sofa.', '2023-10-11 14:00:00', NULL),
       (17, 2, 9, 'Polyester is easy to care for.', '2023-10-11 15:15:00', NULL),
       (18, 3, 9, 'I prefer natural fabrics.', '2023-10-11 16:30:00', NULL),
       (19, 4, 10, 'Sustainability is important.', '2023-10-11 17:45:00', NULL),
       (20, 5, 10, 'I support eco-friendly fabrics.', '2023-10-11 19:00:00', NULL);

CREATE TABLE likes
(
    id         INTEGER NOT NULL,
    user_id    INTEGER NOT NULL,
    article_id INTEGER NOT NULL,
    PRIMARY KEY (id, user_id, article_id),
    FOREIGN KEY (user_id) REFERENCES user (id),
    FOREIGN KEY (article_id) REFERENCES articles (id)
);

-- Inserting 20 rows of sample data into the likes table
INSERT INTO likes (id, user_id, article_id)
VALUES
    (1, 1, 1),
    (2, 2, 1),
    (3, 3, 2),
    (4, 4, 2),
    (5, 5, 3),
    (6, 1, 3),
    (7, 2, 4),
    (8, 3, 4),
    (9, 4, 5),
    (10, 5, 5),
    (11, 1, 6),
    (12, 2, 6),
    (13, 3, 7),
    (14, 4, 7),
    (15, 5, 8),
    (16, 1, 8),
    (17, 2, 9),
    (18, 3, 9),
    (19, 4, 10),
    (20, 5, 10);

CREATE TABLE likes_comments
(
    user_id     INTEGER NOT NULL,
    comments_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, comments_id),
    FOREIGN KEY (user_id) REFERENCES user (id),
    FOREIGN KEY (comments_id) REFERENCES comments (id)
);

-- Insert 20 rows of data into the likes_comments table
INSERT INTO likes_comments (user_id, comments_id)
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (2, 4),
       (2, 5),
       (2, 6),
       (3, 7),
       (3, 8),
       (3, 9),
       (4, 10),
       (4, 11),
       (4, 12),
       (5, 13),
       (5, 14),
       (5, 15),
       (6, 16),
       (6, 17),
       (6, 18),
       (7, 19),
       (7, 20);

CREATE TABLE subscription
(
    being_subscribed_id INTEGER NOT NULL,
    follower_id         INTEGER NOT NULL,
    PRIMARY KEY (being_subscribed_id, follower_id),
    FOREIGN KEY (being_subscribed_id) REFERENCES user (id),
    FOREIGN KEY (follower_id) REFERENCES user (id)
);

-- Inserting 20 rows of sample data into the subscription table
INSERT INTO subscription (being_subscribed_id, follower_id)
VALUES (1, 2),
       (1, 3),
       (1, 4),
       (2, 3),
       (2, 4),
       (2, 5),
       (3, 4),
       (3, 5),
       (3, 1),
       (4, 5),
       (4, 1),
       (4, 2),
       (5, 1),
       (5, 2),
       (5, 3),
       (1, 5),
       (2, 1),
       (3, 2),
       (4, 3),
       (5, 4);

CREATE TABLE notifications
(
    id      INTEGER   NOT NULL PRIMARY KEY,
    host_id INTEGER   NOT NULL,
    time    TIMESTAMP NOT NULL,
    content VARCHAR(88),
    FOREIGN KEY (host_id) REFERENCES user (id)
);

-- Inserting 20 rows of sample data into the notifications table
INSERT INTO notifications (id, host_id, time, content)
VALUES (1, 1, '2023-10-10 10:15:00', 'You have a new follower.'),
       (2, 2, '2023-10-10 11:30:00', 'New article published: "Introduction to Fabric Types"'),
       (3, 3, '2023-10-10 12:45:00', 'Someone liked your comment.'),
       (4, 4, '2023-10-10 14:00:00', 'New article published: "Silk Fabric Production"'),
       (5, 5, '2023-10-10 15:15:00', 'You have a new follower.'),
       (6, 1, '2023-10-10 16:30:00', 'Your article received a comment.'),
       (7, 2, '2023-10-10 17:45:00', 'New article published: "Cotton vs. Polyester"'),
       (8, 3, '2023-10-10 19:00:00', 'Someone liked your article.'),
       (9, 4, '2023-10-10 20:15:00', 'You have a new follower.'),
       (10, 5, '2023-10-10 21:30:00', 'New article published: "Wool Fabric Properties"'),
       (11, 1, '2023-10-10 22:45:00', 'Someone liked your comment.'),
       (12, 2, '2023-10-10 23:59:00', 'You have a new follower.'),
       (13, 3, '2023-10-11 10:15:00', 'New article published: "Linen Fabric Uses"'),
       (14, 4, '2023-10-11 11:30:00', 'Your article received a comment.'),
       (15, 5, '2023-10-11 12:45:00', 'Someone liked your article.'),
       (16, 1, '2023-10-11 14:00:00', 'You have a new follower.'),
       (17, 2, '2023-10-11 15:15:00', 'New article published: "Satin Fabric Elegance"'),
       (18, 3, '2023-10-11 16:30:00', 'Your comment was mentioned in an article.'),
       (19, 4, '2023-10-11 17:45:00', 'New article published: "Denim Fabric History"'),
       (20, 5, '2023-10-11 19:00:00', 'Your article was shared by a follower.');

CREATE TABLE notify
(
    id              INTEGER NOT NULL,
    notification_id INTEGER NOT NULL,
    follower_id     INTEGER NOT NULL,
    PRIMARY KEY (id, notification_id, follower_id),
    FOREIGN KEY (notification_id) REFERENCES notifications (id),
    FOREIGN KEY (follower_id) REFERENCES user (id)
);

-- Inserting 20 rows of sample data into the notify table
INSERT INTO notify (id, notification_id, follower_id)
VALUES (1, 1, 2),
       (2, 2, 3),
       (3, 3, 4),
       (4, 4, 5),
       (5, 5, 1),
       (6, 6, 2),
       (7, 7, 3),
       (8, 8, 4),
       (9, 9, 5),
       (10, 10, 1),
       (11, 11, 2),
       (12, 12, 3),
       (13, 13, 4),
       (14, 14, 5),
       (15, 15, 1),
       (16, 16, 2),
       (17, 17, 3),
       (18, 18, 4),
       (19, 19, 5),
       (20, 20, 1);

-- creating a view that shows articles likes, comments and popularity
DROP VIEW IF EXISTS articles_info;

create view [Articles_info]as 
select articles.author_id as user_id,articles.id as article_id,user.fname, user.lname, articles.title, count(likes.id) as like_count, comments_count, (count(likes.id) + comments_count*2) as popularity
	from articles
	left join likes on articles.id = likes.article_id
	left join (
		select article_id as comment_articles_id, count(comments.id) as comments_count
			from comments 
			group by article_id
	) on articles.id = comment_articles_id
	left join user on user.id = articles.author_id
 group by articles.id;













