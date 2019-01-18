<?php

foreach($_REQUEST as $var => $value) { unset($GLOBALS[$var]); }

$domain = 'mynetworkdomain';
$domain_user = 'Администратор';
$domain_password = 'very-craZY-p@ssWord';

$filename = './datetime_dt.txt';
$data = time();

if (isset($_GET["pw"])) {
	if($_GET["pw"] === "sECRETphrase") {
		file_put_contents($filename, $data . PHP_EOL);
		exit(1);
	} else {
		exit(1);
	}
}

if (file_exists($filename)) {
	$prev_data = file_get_contents($filename);
	$diff = $data - $prev_data;
	if ($diff > 60) {
		Json('NULL','NULL','NULL');
		exit(1);
		}
	Json($domain, $domain_user, $domain_password);
	file_put_contents($filename, '1' . PHP_EOL);
} else {
	file_put_contents($filename, $data . PHP_EOL);
}

function Json($a, $b, $c)
{
	$arr = array('a' => $a, 'b' => $b, 'c' => $c);
	echo json_encode($arr);
}

?>
