<?php
// Retrieve the raw POST data
$jsonData = file_get_contents('php://input');
// Decode the JSON data into a PHP associative array
$data = json_decode($jsonData, true);

// Check if decoding was successful
if ($data !== null) {
    $user_id = addslashes(strip_tags($data['user_id']));
    $recipe_id = addslashes(strip_tags($data['recipe_id']));
    
    // Connect to the database
    $con = mysqli_connect("fdb1030.awardspace.net", "4508960_recipely", "sajed10.s", "4508960_recipely");

    // Check connection
    if (mysqli_connect_errno()) {
        echo "Failed to connect to MySQL: " . mysqli_connect_error();
    } else {
        try {
            // Delete the data from the favorites table
            $sql = "DELETE FROM favorites WHERE user_id='$user_id' AND recipe_id='$recipe_id'";
            if (mysqli_query($con, $sql)) {
                if (mysqli_affected_rows($con) > 0) {
                    echo "Record Deleted";
                } else {
                    echo "No matching record found";
                }
            } else {
                echo "Error: " . $sql . "<br>" . mysqli_error($con);
            }
        } catch (Exception $e) {
            die($e->getMessage());
        }

        // Close the database connection
        mysqli_close($con);
    }
} else {
    echo "Invalid JSON data";
}
?>
