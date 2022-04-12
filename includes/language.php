<?php

$language = "DE";

// Check for translations
if( isset($_GET["lang"]) && !empty($_GET["lang"]) ) {
	$language = $_GET["lang"];
}    
    
// Check for language file
if ( file_exists("lang/$language.php") ) {
    include("lang/$language.php");
}
else {
    include("lang/de.php"); // default language
}

?>
