DROP DATABASE IF EXISTS craigslist;
CREATE DATABASE craigslist;

\c craigslist;

CREATE TABLE "region" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50)
);
CREATE INDEX region_name ON region(name);

CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "username" VARCHAR(50) NOT NULL UNIQUE,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "region_id" INT REFERENCES region(id)
);
CREATE INDEX users_username ON "users"(username);
CREATE INDEX user_name ON "users"(first_name , last_name);

CREATE TABLE "category" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50)
);
CREATE INDEX category_name ON category(name);

CREATE TABLE "post" (
  "id" SERIAL PRIMARY KEY,
  "user_id" INT REFERENCES "users"(id),
  "region_id" INT REFERENCES region(id),
  "category_id" INT REFERENCES category(id),
  "title" VARCHAR(50),
  "text" TEXT,
  "location" VARCHAR(50),
  "posttime" TIMESTAMP
);

CREATE INDEX post_title ON post(title);


INSERT INTO region (name) VALUES 
  ('Boston') ,
  ('New York');

INSERT INTO "users" (username , first_name , last_name , region_id) VALUES 
    ('user1' , 'A' , 'H' , 1),
    ('user2' , 'B' , 'I' , 2),
    ('user3' , 'C' , 'J' , 1),
    ('user4' , 'D' , 'K' , 2),
    ('user5' , 'E' , 'L' , 1);


  INSERT INTO category (name) VALUES
    ('cat1') ,
    ('cat2') ,
    ('cat3') ,
    ('cat4');

  INSERT INTO post (user_id , region_id , category_id , title , text , location , posttime) VALUES
    (1 , 1 , 1 , 'post1' , 'post1 content' , 'downtown' , '2020-1-2') ,
    (2 , 2 , 2 , 'post2' , 'post2 content' , 'brooklyn' , '2020-2-2') ,
    (3 , 1 , 3 , 'post3' , 'post3 content' , 'allston' , '2020-11-2') ,
    (1 , 2 , 4 , 'post4' , 'post4 content' , 'downtown' , '2020-10-22');

SELECT * FROM region
  JOIN post on post.region_id = region.id 
  JOIN category on post.category_id = category.id
  JOIN "users" on post.user_id = "users".id;