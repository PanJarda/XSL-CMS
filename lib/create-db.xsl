<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" indent="no"/>

  <xsl:template match="@many-to-many">
    <!-- todo create junction table -->
  </xsl:template>

  <xsl:template match="@many-to-one">
    FOREIGN KEY (`<xsl:value-of select=".."/>`)
    REFERENCES `<xsl:value-of select="."/>`(`id`),
  </xsl:template>

  <xsl:template match="col">
    `<xsl:value-of select="."/>`
    <xsl:value-of select="@type"/>
    <xsl:if test="not(@type)">
      VARCHAR(255)
    </xsl:if>
    <xsl:if test="not(@nullable)">
      NOT NULL
    </xsl:if>
    ,
    <xsl:apply-templates select="@many-to-one"/>

  </xsl:template>

  <xsl:template match="table">
    DROP TABLE IF EXISTS `<xsl:value-of select="@name"/>`;
    CREATE TABLE `<xsl:value-of select="@name"/>` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      <xsl:apply-templates select="col"/>
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  </xsl:template>

  <xsl:template match="db">
    DROP DATABASE IF EXISTS `<xsl:value-of select="@name"/>`;
    CREATE DATABASE `<xsl:value-of select="@name"/>`;
    USE `<xsl:value-of select="@name"/>`;
    <xsl:apply-templates select="table"/>
    <xsl:apply-templates select="table/col/@many-to-many"/>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="//db"/>
  </xsl:template>

</xsl:stylesheet>