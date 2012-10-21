<?php

if( isset($_POST['data']) && isset($_POST['id']) && isset($_POST['list_id']) ) {
  $item_data = $_POST['data'];
  $item_id = $_POST['id'];
  $list_id = $_POST['list_id'];
  echo "saved $item_id - $item_data";
  ($item_data == "") ? deleteItem($item_id) : addItem($item_id, $item_data, $list_id);
}

if( isset($_GET['list_id']) ) {
  $list_id = $_GET['list_id'];
  itemsForList($list_id);
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

function addItem($id, $data, $list_id) {
  $table_name="items";
  $con = connect();
  $query = "INSERT INTO $table_name (id, data, list_id) VALUES ($id, '$data', $list_id) ON DUPLICATE KEY UPDATE data='$data', list_id=$list_id";
  mysql_query($query);
  mysql_close($con);
}

function deleteItem($id) {
  $table_name="items";
  $con = connect();
  $query = "DELETE FROM $table_name WHERE id=$id";
  mysql_query($query);
  mysql_close($con);
}

function itemsForList($list_id) {
  $table_name="items";
  $con = connect();
  $query = "SELECT * FROM $table_name WHERE list_id=$list_id";
  $result = mysql_query($query);
  $res = mysql_fetch_all($result);
  mysql_free_result($result);
  mysql_close($con);
  return $res;
}
?>
