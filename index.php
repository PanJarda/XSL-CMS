<?php
$config = '
<xml>
  <sqlprovider connection="fsf">
    <headers>
      <cookies>
        <cookie fsfs="fsf" />
      </cookies>
    </headers>
    <router>
      <route path="/ahoj">
        <BioPage />
      </route>
      <route path="about">
        <AboutContainer />
      </route>
    </router>
  </sqlprovider>
</xml>';

$xml = simplexml_load_string($config);

print_r($xml);

?>
<app>
  <sqlprovider connection="fsf">
    <headers>
      <cookies>
        <cookie fsfs="fsf" />
      </cookies>
    </headers>
    <router>
      <route path="/ahoj">
        <BioPage>
          <headers>
            <cookies>
              <cookie fsfs="fsfrr1r3r2r32r" />
            </cookies>
          </headers>
          <data>
            <articles limit="10" orderby="published">
              <tag contains="research" hide />
              <title />
              <content />
              <published />
              <user match="users:id">
              <users:nickname />
            </articles>
            <user>
              <id equals="1" hide />
              <username />
              <last-logged />
            </user>
          </data>
          <template>
            <html>
              <head>
                <title>Ahoj</title>
              </head>
              <body>
              </body>
            </html>
          </template>
        </BioPage>
      </route>
      <route path="about">
        <AboutContainer />
      </route>
    </router>
  </sqlprovider>
</app>';