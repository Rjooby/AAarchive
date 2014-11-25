CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);


CREATE TABLE replies (
  id INTEGER PRIMARY KEY,

  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  author_id INTEGER NOT NULL,

  body VARCHAR(255) NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id)
);


CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,

  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO
users(fname, lname)
VALUES
('Ronald', 'Joo'), ('Ed', 'Jinotti');


INSERT INTO
questions(title, body, author_id)
VALUES
(
  'Where?',
  'What planet is this?',
  (SELECT id FROM users WHERE fname = 'Ronald')
),
(
  'HUH?',
  'ARAHRHGAHRGHRGGAHRGHRGAHRGR? HUH?',
  (SELECT id FROM users WHERE fname = 'Ronald')
),
(
  'Q3',
  'three',
  (SELECT id FROM users WHERE fname = 'Ronald')
),
(
  'What time?',
  'Is it noon yet?',
  (SELECT id FROM users WHERE fname = 'Ed')
);


INSERT INTO
question_followers(user_id, question_id)
VALUES
(
  (SELECT id FROM users WHERE fname = 'Ronald'),
  (SELECT id FROM questions WHERE title = 'What time?')
),
(
  (SELECT id FROM users WHERE fname = 'Ed'),
  (SELECT id FROM questions WHERE title = 'Where?')
),
(
  (SELECT id FROM users WHERE fname = 'Ronald'),
  (SELECT id FROM questions WHERE title = 'Where?')
);


INSERT INTO
replies(question_id, parent_id, author_id, body)
VALUES
(
  (SELECT id FROM questions WHERE title = 'Where?'),
  NULL,
  (SELECT id FROM users WHERE fname = 'Ed'),
  'This is Earth'
);

INSERT INTO
replies(question_id, parent_id, author_id, body)
VALUES
(
  (SELECT id FROM questions WHERE title = 'Where?'),
  (SELECT id FROM replies WHERE body ='This is Earth'),
  (SELECT id FROM users WHERE fname = 'Ronald'),
  'No it isnt this is Mars'
);


INSERT INTO
question_likes(user_id, question_id)
VALUES
(
  (SELECT id FROM users WHERE fname = 'Ed'),
  (SELECT id FROM questions WHERE title = 'Where?')
);
