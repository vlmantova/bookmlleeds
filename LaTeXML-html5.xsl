<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version   = "1.0"
    xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
    xmlns:ltx = "http://dlmf.nist.gov/LaTeXML"
    exclude-result-prefixes="ltx">

  <!-- Include the standard LaTeXML html5 stylesheet -->
  <xsl:import href="urn:x-LaTeXML:XSLT:LaTeXML-html5.xsl"/>

  <!-- set SIMPLIFY_HTML to true to improve lists -->
  <xsl:param name="SIMPLIFY_HTML">true</xsl:param>

  <!-- attach modern and mobile friendly tags to <head> -->
  <xsl:template match="/" mode="head-begin">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
  </xsl:template>

  <!-- modernise the output by removing the Content-type meta tag -->
  <xsl:template match="/" mode="head-content-type"/>

</xsl:stylesheet>
