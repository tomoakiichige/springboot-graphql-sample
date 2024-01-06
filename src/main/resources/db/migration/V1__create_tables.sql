CREATE TABLE `user`
(
    id         INT          NOT NULL AUTO_INCREMENT,
    email      VARCHAR(255) NOT NULL,
    password   VARCHAR(255) NOT NULL,
    username   VARCHAR(255) NOT NULL,
    bio        VARCHAR(255) NOT NULL,
    image      VARCHAR(255),
    created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY (email),
    UNIQUE KEY (username)
);

CREATE TABLE article
(
    id           INT          NOT NULL AUTO_INCREMENT,
    slug         VARCHAR(255) NOT NULL,
    title        VARCHAR(255) NOT NULL,
    description  VARCHAR(255) NOT NULL,
    body         VARCHAR(255) NOT NULL,
    author_id    INT          NOT NULL,
    is_published BOOLEAN      NOT NULL,
    created_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY (slug),
    FOREIGN KEY (author_id) REFERENCES `user` (id)
);


CREATE TABLE comment
(
    id         INT          NOT NULL AUTO_INCREMENT,
    body       VARCHAR(255) NOT NULL,
    author_id  INT          NOT NULL,
    article_id INT          NOT NULL,
    created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) REFERENCES `user` (id),
    FOREIGN KEY (article_id) REFERENCES article (id)
);

CREATE TABLE tag
(
    id         INT          NOT NULL AUTO_INCREMENT,
    name       VARCHAR(255) NOT NULL,
    created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY (name)
);

CREATE TABLE article_tag
(
    article_id INT      NOT NULL,
    tag_id     INT      NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (article_id, tag_id),
    FOREIGN KEY (article_id) REFERENCES article (id),
    FOREIGN KEY (tag_id) REFERENCES tag (id)
);

CREATE TABLE article_favorite
(
    article_id INT      NOT NULL,
    user_id    INT      NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (article_id, user_id),
    FOREIGN KEY (article_id) REFERENCES article (id),
    FOREIGN KEY (user_id) REFERENCES `user` (id)
);

CREATE TABLE follow
(
    follower_id INT      NOT NULL,
    followed_id INT      NOT NULL,
    created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, followed_id),
    FOREIGN KEY (follower_id) REFERENCES `user` (id),
    FOREIGN KEY (followed_id) REFERENCES `user` (id)
);
