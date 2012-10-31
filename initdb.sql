create schema todo;
use todo;

create table boards(
  id INT NOT NULL AUTO_INCREMENT primary key,
  name varchar(200)
) ENGINE = INNODB;

create table lists(
  id INT NOT NULL AUTO_INCREMENT primary key,
  name varchar(200),
  board_id INT NOT NULL,
  FOREIGN KEY (board_id) REFERENCES boards(id) ON DELETE CASCADE

) ENGINE = INNODB;

create table items(
  id INT NOT NULL AUTO_INCREMENT primary key,
  data varchar(200),
  list_id INT NOT NULL,
  FOREIGN KEY (list_id) REFERENCES lists(id) ON DELETE CASCADE
) ENGINE = INNODB;

create table users(
  id INT NOT NULL AUTO_INCREMENT primary key,
  identity varchar(100) NOT NULL,
  email varchar(100)
) ENGINE = INNODB;
