<?php

function connect() {
  $con = mysql_connect(
    $server = getenv('MYSQL_DB_HOST'),
    $username = getenv('MYSQL_USERNAME'),
    $password = getenv('MYSQL_PASSWORD'));
  mysql_select_db(getenv('MYSQL_DB_NAME'));
  return $con;
}

function getUser($identity)
{
  $table_name="users";
  $con = connect();
  $query = "SELECT * FROM $table_name WHERE identity='$identity'";
  $result = mysql_query($query);
  $user_row = mysql_fetch_row($result);
  mysql_free_result($result);
  mysql_close($con);
  return $user_row;
}
function createUser($identity, $email) {
  $table_name="users";
  $con = connect();
  $query = "INSERT INTO $table_name (identity, email) VALUES ('$identity', '$email')";
  mysql_query($query);
  mysql_close($con);
}

function deleteUser($id) {
  $table_name="users";
  $con = connect();
  $query = "DELETE FROM $table_name WHERE id=$id";
  mysql_query($query);
  mysql_close($con);
}

?>
