<?php
	$host='mysql7.000webhost.com';
	$mysql_database = "a8897740_sitterz";
	$user='a8897740_Admin';
	$password='joker123';
	
	$connection = mysql_connect($host,$user,$password);
	
	
	$petSpecies = $_POST['a'];
	$petName = $_POST['b'];
	$petAge = $_POST['c'];
	$petBreed = $_POST['d'];	
	$petPersonality = $_POST['e'];
	$petNotes = $_POST['f'];
	$userID = $_POST['g'];
	$petFood = $_POST['h'];
	$petPicture = $_POST['i'];
	
	if(!$connection){
		die('Connection Failed');
	}
	else{
		$dbconnect = @mysql_select_db($mysql_database, $connection);
		
		if(!$dbconnect){
			die('Could not connect to Database');
		}
		else{
			$query = "INSERT INTO `a8897740_sitterz`.`Pet` (`PetType`,`PetName`,`PetAge`,`PetBreed`,`PetPersonality`,`OtherNotes`,`UserID`,`PetFood`,`petPicture`)
				VALUES ('$petSpecies','$petName','$petAge','$petBreed','$petPersonality','$petNotes','$userID','$petFood','$petPicture');";
			mysql_query($query, $connection) or die(mysql_error());
			
			
			echo 'Successfully added.';
			echo $query;
		}
	}
?>