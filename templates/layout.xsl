<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="utf-8" indent="yes" />
  <xsl:include href="partials/routes.xsl"/>

  <xsl:template match="/config">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
    <html>
      <head>
        <title><xsl:value-of select="routeName"/> - <xsl:value-of select="brand"/></title>
        <style>
          .active {
            color: green;
          }
        </style>
      </head>
      <body>
        <xsl:if test="debug">
          <pre>
            <xsl:value-of select="debug"/>
          </pre>
        </xsl:if>
        <h1><xsl:value-of select="routeName"/></h1>
        <xsl:apply-templates select="routes"/>
        <xsl:call-template name="main"/>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>