<?php

if( isset($_POST['data']) ) {
  $item_data = $_POST['data'];
  addItem($item_data);
  echo "saved $item_data";
}

if( isset($_GET['all']) ) {
  allItems();
}

function connect() {
  $host="localhost";
  $username="root";
  $password="srihari";
  $db_name="todo";

  $con = mysql_connect("$host", "$username", "$password")or die("cannot connect");
  mysql_select_db("$db_name")or die("cannot select DB");
  return $con;
}

function mysql_fetch_all($result) {
  $rows = array();
  while($r = mysql_fetch_assoc($result)) {
    $rows[] = $r;
  }
  print json_encode($rows);
}

function addItem($data='') {
  $table_name="items";
  $con = connect();
  $query = "INSERT INTO $table_name (data) VALUES ('$data')";
  mysql_query($query);
  mysql_close($con);
}

function allItems() {
  $table_name="items";
  $con = connect();
  $query = "SELECT * FROM $table_name";
  $result = mysql_query($query);
  $res = mysql_fetch_all($result);
  mysql_free_result($result);
  mysql_close($con);
  return $res;
}
?>
