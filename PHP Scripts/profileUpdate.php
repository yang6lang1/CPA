<?

mysql_connect('sql113.0fees.net', 'fees0_12565375', 'tract_cpa')or die(mysql_error()) ;

@mysql_select_db('fees0_12565375_tract_cpa') or die("Unable to find database");

$username = $_GET["username"];

$password = $_GET["password"];

$email = $_GET["email"];

$contactNumber = $_GET["contactNumber"];

$identityCode = $_GET["identityCode"];

$lastName = $_GET["lastName"];

$firstName = $_GET["firstName"];


$query = "UPDATE AccountTable SET password = '$password', email = '$email', contactNumber = '$contactNumber', identityCode = '$identityCode', lastName = '$lastName', firstName = '$firstName' WHERE username = '$username'";

mysql_query($query)or die(mysql_error());

echo "Profile Updated";
mysql_close();


?>