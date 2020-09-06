<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version   = "1.0"
    xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
    xmlns:ltx = "http://dlmf.nist.gov/LaTeXML"
    exclude-result-prefixes="ltx">

  <!-- include the standard LaTeXML html5 stylesheet -->
  <xsl:import href="urn:x-LaTeXML:XSLT:LaTeXML-html5.xsl"/>

  <!-- set SIMPLIFY_HTML to true to improve lists -->
  <xsl:param name="SIMPLIFY_HTML">true</xsl:param>

  <!-- attach modern and mobile friendly tags to <head> -->
  <xsl:template match="/" mode="head-begin">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
  </xsl:template>

  <!-- include the latest version of MathJax 3 -->
  <xsl:template match="/" mode="head-end">
    <!-- a polyfill for IE11 -->
    <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
    <!-- maths is already converted to MathML, no need for the tex component -->
    <script id="MathJax-script" async="" src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/mml-chtml.js"></script>
  </xsl:template>

  <!-- modernise the output by removing the Content-type meta tag -->
  <xsl:template match="/" mode="head-content-type" />

</xsl:stylesheet>
