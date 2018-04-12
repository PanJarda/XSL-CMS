<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" indent="no"/>
  <xsl:param name="drop"/>
  <xsl:key name="name" match="table" use="@name"/>

  <xsl:template match="many-to-many">
    CREATE table <xsl:value-of select="../@name"/>_x_<xsl:value-of select="@table"/> (
      `<xsl:value-of select="../@name"/>_id` int(10) unsigned NOT NULL,
      `<xsl:value-of select="@table"/>_id` int(10) unsigned NOT NULL,
      FOREIGN KEY (`<xsl:value-of select="../@name"/>_id`)
      REFERENCES `<xsl:value-of select="../@name"/>`(`id`),
      FOREIGN KEY (`<xsl:value-of select="@table"/>_id`)
      REFERENCES `<xsl:value-of select="@table"/>`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  </xsl:template>

  <xsl:template match="many-to-one">
    `<xsl:value-of select="@table"/>_id` int(10) unsigned NOT NULL,
    FOREIGN KEY (`<xsl:value-of select="@table"/>_id`)
    REFERENCES `<xsl:value-of select="@table"/>`(`id`)
    <xsl:if test="key('name', .)/@on-delete">
      ON DELETE <xsl:value-of select="key('name', .)/@on-delete"/>
    </xsl:if>
    ,
  </xsl:template>

  <xsl:template match="col">
    `<xsl:value-of select="."/>`
    <xsl:value-of select="@type"/>
    <xsl:if test="not(@type) and not(@many-to-one)">
      VARCHAR(255)
    </xsl:if>
    <xsl:if test="@many-to-one">
      int(10) unsigned
    </xsl:if>
    <xsl:if test="not(@nullable)">
      NOT NULL
    </xsl:if>
    ,
    <xsl:apply-templates select="@many-to-one"/>

  </xsl:template>

  <xsl:template match="table">
    <xsl:if test="$drop">
      DROP TABLE IF EXISTS `<xsl:value-of select="@name"/>`;
    </xsl:if>
    CREATE TABLE `<xsl:value-of select="@name"/>` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      <xsl:apply-templates select="col"/>
      <xsl:apply-templates select="many-to-one"/>
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  </xsl:template>

  <xsl:template match="db">
    <xsl:if test="$drop">
      DROP DATABASE IF EXISTS `<xsl:value-of select="@name"/>`;
    </xsl:if>
    CREATE DATABASE `<xsl:value-of select="@name"/>`;
    USE `<xsl:value-of select="@name"/>`;
    <xsl:apply-templates select="table"/>
    <xsl:apply-templates select="table/many-to-many"/>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="//db"/>
  </xsl:template>

</xsl:stylesheet>