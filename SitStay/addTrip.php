<?php
	$host='mysql7.000webhost.com';
	$mysql_database = "a8897740_sitterz";
	$user='a8897740_Admin';
	$password='joker123';
	
	$connection = mysql_connect($host,$user,$password);
	
	
	$userID = $_POST['a'];
	$startDate = $_POST['b'];
	$endDate = $_POST['c'];
	$Address1 = $_POST['d'];
	$Address2 = $_POST['e'];
	$ZipCode = $_POST['f'];
	$City = $_POST['g'];
	$tripName = $_POST['h'];
	$userPhone = $_POST['i'];
	$userEmail = $_POST['j'];

	
	
	
	if(!$connection){
		die('Connection Failed');
	}
	else{
		$dbconnect = @mysql_select_db($mysql_database, $connection);
		
		if(!$dbconnect){
			die('Could not connect to Database');
		}
		else{
			$query = "INSERT INTO `a8897740_sitterz`.`User` (`UserID`,`UserAddress`,`UserAddress2`,`Zipcode`,`City`,`IsSitting`,`TripStartDate`,`TripEndDate`,`tripName`, `userPhone`,`UserEmail`)
				VALUES ('$userID','$Address1','$Address2','$ZipCode','$City',0,'$startDate','$endDate','$tripName','$userPhone','$userEmail');";
			mysql_query($query, $connection) or die(mysql_error());
			echo 'Successfully added.';
			echo $query;
			$query2 = "SELECT TripID FROM `a8897740_sitterz`.`User` WHERE tripName = '$tripName' AND UserID = '$userID' AND TripStartDate = '$startDate';";
			$resultset = mysql_query($query2, $connection);
			
			$records= array();
			
			while($r = mysql_fetch_assoc($resultset)){
				$records[] = $r;
			}
			
			echo json_encode($records);
			
		}
	}
?>