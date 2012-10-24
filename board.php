<?php

if( isset($_POST['name']) && isset($_POST['id']) ) {
  addBoard($_POST['id'], $_POST['name']);
}
if( isset($_POST['delete']) && isset($_POST['id']) ) {
  deleteBoard($_POST['id']);
}
if( isset($_GET['all']) ) {
  allBoards();
}

function connect() {
  $con = mysql_connect(
  $server = getenv('MYSQL_DB_HOST'),
  $username = getenv('MYSQL_USERNAME'),
  $password = getenv('MYSQL_PASSWORD'));
  mysql_select_db(getenv('MYSQL_DB_NAME'));
  return $con;
}

function mysql_fetch_all($result) {
  $rows = array();
  while($r = mysql_fetch_assoc($result)) {
    $rows[] = $r;
  }
  print json_encode($rows);
}

function addBoard($id, $name) {
  $table_name="boards";
  $con = connect();
  $query = "INSERT INTO $table_name (id, name) VALUES ($id, '$name') ON DUPLICATE KEY UPDATE name='$name'";
  mysql_query($query);
  mysql_close($con);
}

function deleteBoard($id) {
  $table_name="boards";
  $con = connect();
  $query = "DELETE FROM $table_name WHERE id=$id";
  mysql_query($query);
  mysql_close($con);
}

function allBoards() {
  $table_name="boards";
  $con = connect();
  $query = "SELECT * FROM $table_name";
  $result = mysql_query($query);
  $res = mysql_fetch_all($result);
  mysql_free_result($result);
  mysql_close($con);
  return $res;
}
?>
