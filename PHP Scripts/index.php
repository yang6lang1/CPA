<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"

"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">



<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  

  <head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />



    <title>Accounts</title>

    <style type = "text/css">

      #top {

      

        border: 1px black solid;

        padding-top: 45px;

        padding-bottom:45px;

        padding-left:40px;

        color:#333333;

        

      }

      

      #middle {

        

        padding-top:30px;

        padding-left:40px;

        padding-bottom:30px;


      

      }

      

      body {

        background-color: #716666;

      }

      

      

      #center {

        

        background-color: #bebebe;

        margin-left:auto;

        margin-right:auto;

        width:60%;

        border: 2px black solid;

        height:900px;

        

      

      }

    

    </style>





  </head>

  

  <body>

    <div id="center">

      <div id ="top">

        <h1>Community Police Assistance</h1>

      </div>

    <div id = "middle">

      <?php

        // Create connectiong

        $con=mysqli_connect("sql113.0fees.net", "fees0_12565375", "tract_cpa", "fees0_12565375_tract_cpa");

        

        //Check connection

        if (mysqli_connect_errno($con))

          {

            echo "Failed to connect to MySQL: " . mysqli_connect_error();

          }

          

        $result = mysqli_query($con,"SELECT * FROM App_users");

        

        echo "<table border = '1'>

        <tr>

          <th>First Name</th>

          <th>Last Name</th>

          <th>User Name</th>

          <th>Password</th>

          <th>Email Address</th>

          <th>Phone Number</th>

          <th>Address</th>

          <th>Special Code</th>

        </tr>";

        

        while($row = mysqli_fetch_array($result))

          {

            echo "<tr>";

              echo "<td>" . $row['First Name'] . "</td>";

              echo "<td>" . $row['Last Name'] . "</td>";

              echo "<td>" . $row['Username'] . "</td>";

              echo "<td>" . $row['Password'] . "</td>";

              echo "<td>" . $row['Email Address'] . "</td>";

              echo "<td>" . $row['Phone Number'] . "</td>";

              echo "<td>" . $row['Address'] . "</td>";

              echo "<td>" . $row['Special Code'] . "</td>";              

            echo "</tr>";

          }

         echo "</table>";

         

         mysqli_close($con);

        

      ?>

      </div>

    </div>

  

  </body>

  

  

</html>

