create schema todo;
use todo;

create table boards(
  id INT NOT NULL AUTO_INCREMENT primary key,
  name varchar(200)
) ENGINE = INNODB;

create table lists(
  id INT NOT NULL AUTO_INCREMENT primary key,
  name varchar(200)
) ENGINE = INNODB;

create table items(
  id INT NOT NULL AUTO_INCREMENT primary key,
  data varchar(200),
  list_id INT NOT NULL,
  FOREIGN KEY (list_id) REFERENCES lists(id) ON DELETE CASCADE
) ENGINE = INNODB;
