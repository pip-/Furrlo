<?php
	$host='mysql7.000webhost.com';
	$mysql_database = "a8897740_sitterz";
	$user='a8897740_Admin';
	$password='joker123';
	
	$connection = mysql_connect($host,$user,$password);
	
	
	$petID =(int)$_POST['a'];
    $tripID = (int)$_POST['b'];
	
	
	if(!$connection){
		die('Connection Failed');
	}
	else{
		$dbconnect = @mysql_select_db($mysql_database, $connection);
		
		if(!$dbconnect){
			die('Could not connect to Database');
		}
		else{
			$query = "SELECT * FROM `a8897740_sitterz`.`Task` WHERE PetID = $petID AND TripID = '$tripID';";
			$resultset = mysql_query($query, $connection);
			
			$records= array();
			
			while($r = mysql_fetch_assoc($resultset)){
				$records[] = $r;
			}
			
			echo json_encode($records);
		}
	}
?>