<?php
	$host='mysql7.000webhost.com';
	$mysql_database = "a8897740_sitterz";
	$user='a8897740_Admin';
	$password='joker123';
	
	$connection = mysql_connect($host,$user,$password);
	
	
	$petID = $_POST['a'];
	$petName = $_POST['b'];
	$taskName = $_POST['c'];
	$detail = $_POST['d'];	
	$tripID = $_POST['e'];
	
		if(!$connection){
		die('Connection Failed');
	}
	else{
		$dbconnect = @mysql_select_db($mysql_database, $connection);
		
		if(!$dbconnect){
			die('Could not connect to Database');
		}
		else{
			$query = "INSERT INTO `a8897740_sitterz`.`Task` (`PetID`,`PetName`,`TaskName`,`Detail`, `TripID`,`Complete`)
				VALUES ('$petID','$petName','$taskName','$detail', '$tripID', 0);";
			mysql_query($query, $connection) or die(mysql_error());
			
			echo 'Successfully added.';
			echo $query;
			
			$query2= "SELECT TaskID FROM `a8897740_sitterz`.`Task` WHERE PetID = $petID;";
			$resultset = mysql_query($query2, $connection);
			
			$records= array();
			
			while($r = mysql_fetch_assoc($resultset)){
				$records[] = $r;
			}
			
			echo json_encode($records);
			
		}
	}
?>