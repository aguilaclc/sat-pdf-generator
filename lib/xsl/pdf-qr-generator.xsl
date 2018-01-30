<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <!-- Generación de código QR -->
  <xsl:template name="CodigoQR">
    <xsl:param name="folio" />
    <xsl:param name="emisor" />
    <xsl:param name="receptor" />
    <xsl:param name="total" />
    <xsl:param name="sello" />

    <xsl:variable name="cadena-sello">
      <xsl:value-of select="substring($sello, string-length($sello)-7, 8)" />
    </xsl:variable>

    <xsl:variable name="firma">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$cadena-sello" />
        <xsl:with-param name="replace" select="'+'" />
        <xsl:with-param name="by" select="'%2B'" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="cfdi-url"
      select="'https://verificacfdi.facturaelectronica.sat.gob.mx/default.aspx'" />
    <xsl:variable name="cfdi-params"
      select="concat('id=', $folio,
                     '%26re=', $emisor,
                     '%26rr=', $receptor,
                     '%26tt=', $total,
                     '%26fe=', $firma)"/>

    <xsl:variable name="qr-api-url"
      select="'https://api.qrserver.com/v1/create-qr-code/?data='" />

    <fo:external-graphic content-width="30mm" content-height="30mm"
      src="url('{$qr-api-url}{$cfdi-url}?{$cfdi-params}')" />
  </xsl:template>

  <!-- Metodo para reemplazar substrings dentro de otro string -->
  <xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />

    <xsl:choose>
      <xsl:when test="contains($text, $replace)">
        <xsl:value-of select="substring-before($text,$replace)" />
        <xsl:value-of select="$by" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="substring-after($text,$replace)" />
          <xsl:with-param name="replace" select="$replace" />
          <xsl:with-param name="by" select="$by" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
