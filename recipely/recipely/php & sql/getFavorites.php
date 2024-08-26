<?php
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

$con = mysqli_connect("fdb1030.awardspace.net", "4508960_recipely", "sajed10.s", "4508960_recipely");
// Check connection
if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$user_id = $_GET['user_id'];

$sql = "select * from favorites where user_id=$user_id";
if ($result = mysqli_query($con, $sql)) {
    $emparray = array();
    while ($row = mysqli_fetch_assoc($result))
        $emparray[] = $row;

    echo (json_encode($emparray));
    // Free result set
    mysqli_free_result($result);
    mysqli_close($con);
}
