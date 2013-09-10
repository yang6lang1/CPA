<?

mysql_connect('sql113.0fees.net', 'fees0_12565375', 'tract_cpa')or die("Unable to connect database") ;
@mysql_select_db('fees0_12565375_tract_cpa') or die("Unable to find database");

$username = $_GET["username"];

$query = "SELECT * FROM AccountTable WHERE username='$username'";

$result=mysql_query($query);
$num=mysql_numrows($result);

mysql_close();

$i=0;
while ($i < $num) {

$username=mysql_result($result,$i,"username");
$password=mysql_result($result,$i,"password");
$email=mysql_result($result,$i,"email");
$contactNumber=mysql_result($result,$i,"contactNumber");
$identityCode=mysql_result($result,$i,"identityCode");
$lastName=mysql_result($result,$i,"lastName");
$firstName=mysql_result($result,$i,"firstName");

echo "$username/StringSeperator/$password/StringSeperator/$email/StringSeperator/$contactNumber/StringSeperator/$identityCode/StringSeperator/$lastName/StringSeperator/$firstName";

$i++;
}
?>