-- 1 Query to delete michael
DROP USER IF EXISTS michael;

-- 2 Creating user michael
CREATE USER michael ENCRYPTED PASSWORD 'stonebreaker';

-- 3 Drops database named todo_app
DROP DATABASE IF EXISTS todo_app;

-- 4 Creates a new database named todo_app
CREATE DATABASE todo_app;

-- 5 Connect to the newly created database
\c todo_app;

-- 6 Create a new table named tasks
CREATE TABLE tasks(
  id serial,
  title character varying(255),
  description text null,
  created_at timestamp without time zone,
  updated_at timestamp without time zone null,
  completed boolean
);

-- 7 Define column id as the table's primary key
ALTER TABLE tasks
ADD PRIMARY KEY (id);

-- 8 Queries to accomplish the following
-- i. remove the column name completed
ALTER TABLE tasks
DROP COLUMN IF EXISTS completed;
-- ii. add a column to tasks named completed_at: timestamp,
-- that may be NULL, and has a default value of NULL
ALTER TABLE tasks
ADD COLUMN completed_at timestamp NULL default NULL;
-- iii. change the updated_at column to not allow NULL values,
-- and have a default value of now()
ALTER TABLE tasks
  ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE tasks
  ALTER COLUMN updated_at SET DEFAULT NOW();
-- iv. create a new task, only by setting values
-- (not defining which columns)
INSERT INTO tasks
VALUES (DEFAULT, 'Study SQL', 'Complete this exercise', now(), now(), NULL);
-- v create a new task
INSERT INTO tasks (title, description)
VALUES ('Study PostgreSQL', 'Read all the documentation');
-- vi select all the titles of tasks that are not yet completed
SELECT title FROM tasks
Where completed_at IS NULL;
-- vii update the task with a title of 'Study SQL' to be completed as of now
UPDATE tasks SET completed_at = NOW()
WHERE title='Study SQL';
-- viii select all titles and descriptions of tasks that are
-- not yet completed
SELECT title, description FROM tasks
Where completed_at IS NULL;
-- ix select all fields of every task sorted by creation
-- date in descending order
SELECT * FROM tasks
ORDER BY created_at DESC;
-- x create a new task
INSERT INTO tasks (title, description)
VALUES ('mistake 1', 'a test entry');
-- xi create a new task
INSERT INTO tasks (title, description)
VALUES ('mistake 2', 'another test entry');
-- xii create a new task
INSERT INTO tasks (title, description)
VALUES ('third mistake', 'another test entry');
-- xiii select title fields of all tasks with a tile that includes the word 'mistake'
SELECT title FROM tasks
WHERE title LIKE '%mistake%';
-- xiv delete the task that has a title of mistake 1
DELETE FROM tasks
WHERE title= 'mistake 1';