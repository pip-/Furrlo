<?php
	$host='mysql7.000webhost.com';
	$mysql_database = "a8897740_sitterz";
	$user='a8897740_Admin';
	$password='joker123';
	
	$connection = mysql_connect($host,$user,$password);
	
	
	$userID = $_POST['a'];
	//$petName = $_POST['b'];
	$tripID = $_POST['b'];
	
	
	
	if(!$connection){
		die('Connection Failed');
	}
	else{
		$dbconnect = @mysql_select_db($mysql_database, $connection);
		
		if(!$dbconnect){
			die('Could not connect to Database');
		}
		else{
			$query = "DELETE FROM `a8897740_sitterz`.`User` WHERE UserID = '$userID' AND TripID = '$tripID';";
			mysql_query($query, $connection) or die(mysql_error());
			echo 'Successfully deleted.';
			echo $query;
			
		}
	}
?>