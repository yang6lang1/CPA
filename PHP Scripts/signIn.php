<?
session_start();
//require("signUp.php");

$u = $_GET['username'];
$pw = $_GET['password'];

$dbname = "fees0_12565375_tract_cpa";
    
$connect = mysql_connect('sql113.0fees.net', 'fees0_12565375', 'tract_cpa')or die(mysql_error()) ;

@mysql_select_db('fees0_12565375_tract_cpa') or die(mysql_error());

$check = "SELECT username, password FROM AccountTable WHERE username='$u' AND password= '$pw'";

$login = mysql_query($check, $connect) or die(mysql_error());

if (mysql_num_rows($login) == 1) {

	//$row = mysql_fetch_assoc($login);
	echo 'Yes';
	exit;
	
} else {
	echo 'No';
	exit;
}

mysql_close($connect);


?>
