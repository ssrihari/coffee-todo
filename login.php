<?php
# Logging in with Google accounts requires setting special identity, so this example shows how to do it.
require 'openid.php';
try {
    # Change 'localhost' to your domain name.
    $openid = new LightOpenID(getenv('HOST_URI'));
    if(!$openid->mode) {
        if(isset($_GET['login'])) {
            $openid->identity = 'https://www.google.com/accounts/o8/id';
            $openid->required = array('namePerson', 'contact/email');
            // $openid->returnUrl = 'http://localhost/todo';
            header('Location: ' . $openid->authUrl());
        }
    } elseif($openid->mode == 'cancel') {
        echo 'User has canceled authentication!';
    } else {
        if ($openid->validate()) {
            // Save $openid->identity with session_id and name and email
            $host_uri = getenv('HOST_URI');
            $attrs = $openid->getAttributes();
            $email_ar = explode("@", $attrs['contact/email']);
            header("Location:  http://$host_uri");
            setcookie("TodoLoginCookie", $email_ar[0], time()+3600*2);  /* expire in 2 hours */
        }
        else {
            echo "Could not log in :( ";
        }
    }
} catch(ErrorException $e) {
    echo $e->getMessage();
}
?>
