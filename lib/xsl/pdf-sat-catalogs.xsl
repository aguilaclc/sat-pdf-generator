<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Catálogo de claves de forma de pago -->
  <xsl:template name="FormaDePago">
    <xsl:param name="clave" />

    <xsl:value-of select="$clave" />
  </xsl:template>

  <!-- Catálogo de claves de método de pago -->
  <xsl:template name="MetodoDePago">
    <xsl:param name="clave" />

    <xsl:value-of select="$clave" />
  </xsl:template>

  <!-- Catálogo de tipos de comprobante -->
  <xsl:template name="TipoDeComprobante">
    <xsl:param name="clave"/>

    <xsl:choose>
      <xsl:when test="contains($clave, 'I')">Ingreso</xsl:when>
      <xsl:when test="contains($clave, 'E')">Egreso</xsl:when>
      <xsl:when test="contains($clave, 'N')">Nómina</xsl:when>
      <xsl:when test="contains($clave, 'P')">Pago</xsl:when>
      <xsl:when test="contains($clave, 'T')">Traslado</xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Catálogo de tipos de impuesto -->
  <xsl:template name="TipoDeImpuesto">
    <xsl:param name="Clave" />
    <xsl:param name="Tasa" />

    <xsl:variable name="NombreImpuesto">
      <xsl:choose>
        <xsl:when test="contains($Clave, '001')">ISR</xsl:when>
        <xsl:when test="contains($Clave, '002')">IVA</xsl:when>
        <xsl:when test="contains($Clave, '003')">IEPS</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$Tasa">
        <xsl:value-of select="concat($NombreImpuesto, ' ', $Tasa)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$NombreImpuesto" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Catálogo de regimenes fiscales -->
  <xsl:template name="TipoDeRegimenFiscal">
    <xsl:param name="clave" />

    <xsl:value-of select="$clave" />
  </xsl:template>

  <!-- Catálogo de claves de tipo de relación de CFDI -->
  <xsl:template name="TipoDeRelacionCFDI">
    <xsl:param name="clave" />

    <xsl:value-of select="$clave" />
  </xsl:template>

  <!-- Catálogo de claves de uso de CFDI -->
  <xsl:template name="UsoCFDI">
    <xsl:param name="clave" />

    <xsl:value-of select="$clave" />
  </xsl:template>
</xsl:stylesheet>
