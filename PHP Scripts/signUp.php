<?php
    
    $dbname = "fees0_12565375_tract_cpa";
    
    mysql_connect('sql113.0fees.net', 'fees0_12565375', 'tract_cpa');

    //  @mysql_select_db('fees0_12565375_testing') or die("Unable to find database");

    @mysql_select_db('fees0_12565375_tract_cpa') or die(mysql_error());
    
    $username = $_GET["username"];
    
    $password = $_GET["password"];
    
    $email = $_GET["email"];
    
    $contactNumber = $_GET["contactNumber"];
    
    $identityCode = $_GET["identityCode"];
    
    $lastName = $_GET["lastName"];
    
    $firstName = $_GET["firstName"];
    
    $check = "SELECT username FROM AccountTable WHERE username='$username'";
    
    $checkExistence = mysql_query($check) or die(mysql_error());
    
    if (mysql_num_rows($checkExistence) != 0) {
        
        echo 'Account exist';
        exit;
        
        mysql_close();
    }
	echo 'Usable username';
    
    $query = "INSERT INTO AccountTable VALUES
    (' ','$username','$password', '$email', '$contactNumber', '$identityCode', 					'$lastName', '$firstName')";
    
    mysql_query($query);
    
	exit;
    
    
    mysql_close();
    
?>