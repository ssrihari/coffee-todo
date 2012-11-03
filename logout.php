<?php
session_destroy();
$host_uri = getenv('HOST_URI');
header("Location:  http://$host_uri");
?>
