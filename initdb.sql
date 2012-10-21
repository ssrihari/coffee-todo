create schema todo;
use todo;

create table items(
  id INT NOT NULL AUTO_INCREMENT primary key,
  data varchar(200),
  list_id INT NOT NULL
);

create table lists(
  id INT NOT NULL AUTO_INCREMENT primary key,
  name varchar(200)
);
