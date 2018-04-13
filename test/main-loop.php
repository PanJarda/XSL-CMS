<?php
/*
 * main programm philosophy
 */

add_request_params($xml);

while($xml->query) {
  replaceAllQueriesWithSQLresults($xml);
}

echo render($xml, $template);
