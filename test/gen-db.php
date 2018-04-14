<?php
$proc = new XSLTProcessor();

$config = simplexml_load_file("../config.xml");
$servername = $config->db['server'];
$username = $config->db['username'];
$password = $config->db['password'];
$conn = new mysqli($servername, $username, $password);
$GLOBALS['connection'] = $conn;

if ($GLOBALS['connection']->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$proc->importStylesheet(
  simplexml_load_file("../lib/gen-db.xsl"));
if ($argv[1] == '--drop') {
  $proc->setParameter('', 'drop', '1');
}

$query = $proc->transformToXML($config);
$result = $GLOBALS['connection']->multi_query($query);
echo $GLOBALS['connection']->error;