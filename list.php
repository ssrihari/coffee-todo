<?php

if( isset($_POST['name']) && isset($_POST['id']) ) {
  addList($_POST['id'], $_POST['name']);
}
if( isset($_POST['delete']) && isset($_POST['id']) ) {
  deleteList($_POST['id']);
}
if( isset($_GET['all']) ) {
  $board_id = $_GET['board_id'];
  listsForBoard($board_id);
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

function addList($id, $name) {
  $table_name="lists";
  $con = connect();
  $query = "INSERT INTO $table_name (id, name) VALUES ($id, '$name') ON DUPLICATE KEY UPDATE name='$name'";
  mysql_query($query);
  mysql_close($con);
}

function deleteList($id) {
  $table_name="lists";
  $con = connect();
  $query = "DELETE FROM $table_name WHERE id=$id";
  mysql_query($query);
  mysql_close($con);
}

function listsForBoard($board_id) {
  $table_name="lists";
  $con = connect();
  $query = "SELECT * FROM $table_name where board_id=$board_id";
  $result = mysql_query($query);
  $res = mysql_fetch_all($result);
  mysql_free_result($result);
  mysql_close($con);
  return $res;
}
?>
