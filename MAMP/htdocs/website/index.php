<?php

$link = mysqli_connect('localhost:8889', 'root', 'root');  
if (!$link)  
{  
  $ouput = 'Unable to connect to the database server.';  
  include 'output.php';  
  exit();  
}  
  
if (!mysqli_set_charset($link, 'utf8'))  
{  
  $output = 'Unable to set database connection encoding.';  
  include 'output.php';  
  exit();  
}  
  
if (!mysqli_select_db($link, 'nbadata'))  
{  
  $output = 'Unable to locate database.';  
  include 'output.php';  
  exit();  
}  
  
$query = "SELECT 
    T.teamIdAway,
    T.teamIdHome,
    T.predictedWinner,
    M.gameDate,
    M.gameTime,
    N.teamLogo,
    N.teamName
    
FROM
    TeamMatch T,
    Matched M,
    NbaTeams N
  
WHERE
    M.groupId = T.groupId
        AND M.gameDate = (SELECT CAST(CURDATE() AS DATE))
        AND (M.teamId=N.teamId);";

$result = mysqli_query($link, $query);

?>

<html>
	<head>
		<title>NBA_Games</title>
		<h1>Ballmetrics</h1>
	</head>
	<style>
	<link rel="stylesheet" type="text/css" href="/css/style.css"/>
</style>

 <body>
	
  
 <?php
	echo "<table>";
	echo "<tr>
	<th>Prediction</th>
	<th></th>
    <th>Home Team</th>
    <th>Time</th>
	<th>Away Team</th>
	<th></th>
    <th>Prediction</th>
  	</tr>";
	
	 while($row = mysqli_fetch_array($result)) {
		 
		$sqlForAway = "SELECT
			N.teamLogo as 'awaylogo',
			N.teamName as 'awayname'

		FROM
			NbaTeams N

		WHERE
			N.teamId='".$row['teamIdAway']."'";
		 $awayResult = mysqli_query($link, $sqlForAway);
		 $awayRowRes = mysqli_fetch_assoc($awayResult);
		echo '<tr>
		<td>'.$row['predictedWinner'].'</td>
		<td><img src="'.$row['teamLogo'].'"/></td>
		<td>'.$row['teamName'].'</td>
		<td>'.$row['gameTime'].'</td>
		<td>'.$awayRowRes['awayname'].'</td>
		<td><img src="'.$awayRowRes['awaylogo'].'"/></td>
		<td>'.$row['predictedWinner'].'</td>
		</tr>';
	  
		}
	 echo "</table>";
		?>
			
	</body>
</html>

