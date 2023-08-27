<?php
// Database configuration
$servername = "localhost";
$username = "root";
$password = "123456";
$dbname = "db_dentalclinic";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Generate and execute INSERT queries for 10,000 rows
for ($i = 1; $i <= 10000; $i++) {
    $Fname = "First" . $i;
    $Lname = "Last" . $i;
    $Mname = "Middle" . $i;
    $F_Address = "Address" . $i;
    $Sex = ($i % 2 == 0) ? 'Male' : 'Female';
    $Age = rand(1, 100);
    $ContactNo = '123456789';

    $sql = "INSERT INTO tblpatients (Fname, Lname, Mname, F_Address, Sex, Age, ContactNo) 
            VALUES ('$Fname', '$Lname', '$Mname', '$F_Address', '$Sex', $Age, '$ContactNo')";

    if ($conn->query($sql) === false) {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

// Close connection
$conn->close();

echo "Data inserted successfully!";
?>
