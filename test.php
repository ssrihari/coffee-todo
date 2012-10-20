<?php
  $data = $_POST['data'];
  $host="localhost";
  $username="root";
  $password="srihari";
  $db_name="todo";
  $table_name="items";

  $con = mysql_connect("$host", "$username", "$password")or die("cannot connect");
  mysql_select_db("$db_name")or die("cannot select DB");
  $query = "INSERT INTO $table_name (data) VALUES ('$data')";
  mysql_query($query);
  mysql_close($con);
  echo "saved $data!";
?>
