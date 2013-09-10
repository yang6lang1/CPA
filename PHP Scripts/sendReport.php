<?php

    mysql_connect('sql113.0fees.net', 'fees0_12565375', 'tract_cpa')or die(mysql_error()) ;
    
    @mysql_select_db('fees0_12565375_tract_cpa') or die("Unable to find database");

$date = $_GET["date1"];

$category = $_GET["category1"];

$time = $_GET["time1"];

$location = $_GET["location1"];

$comments = $_GET["comments1"];


$imageURL = $_GET["imageURL1"];


$latitude = $_GET["latitude1"];


$longitude = $_GET["longitude1"];

$username =  $_GET["username1"];

$query = "INSERT INTO report VALUES ('','$date','$category', '$time', '$location', '$comments', '$imageURL','$latitude','$longitude','$username')";

mysql_query($query);

mysql_close();

?>