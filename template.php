<?php

$template = '<template xmlns:n="fsf">
  <html>
    <Header />
    <body>
      <Menu />
      <ul>
        <li n:foreach="articles">
          {{ title }}
        </li>
      </ul>
      <Footer />
    </body>
  </html>
</template>';



function expand($template, $data) {
  $contextStack = [];
  $ptr;

  if (count($template->attributes())) {
    foreach ($template->attributes() as $attr => $value) {
      print_r($attr);
    }
  }
  return $template->asXML();
}

$queryTree = simplexml_load_string($template);
echo expand($queryTree, []);