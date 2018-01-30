<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:cfdi="http://www.sat.gob.mx/cfd/3"
                              xmlns:fo="http://www.w3.org/1999/XSL/Format"
                              xmlns:ric="http://www.manugor.com/addenda"
                              xmlns:tfd="http://www.sat.gob.mx/TimbreFiscalDigital"
                              xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="pdf-sat-catalogs.xsl" />
  <xsl:include href="pdf-qr-generator.xsl" />

  <xsl:template match="cfdi:Comprobante">
    <fo:root font-family="Inconsolata">
      <fo:layout-master-set>
        <fo:simple-page-master page-width="8.5in" page-height="11in"
                               margin="0.375in 0.25in" master-name="Pages">
          <fo:region-body margin-top="1in"/>
          <fo:region-before extent="1in"/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="Pages">
        <fo:static-content flow-name="xsl-region-before">
          <fo:table table-layout="fixed" width="100%">
            <fo:table-column column-width="1.5in"/>
            <fo:table-column column-width="5in"/>
            <fo:table-column column-width="1.5in"/>

            <fo:table-body text-align="right" font-size="8px">
              <fo:table-row>
                <fo:table-cell number-rows-spanned="5" text-align="left">
                  <fo:block>
                    <xsl:if test="cfdi:Addenda/ric:Datos/@LogoUrl">
                      <fo:external-graphic src="url('{cfdi:Addenda/ric:Datos/@LogoUrl}')"
                                           content-width="1in"
                                           content-height="1in"/>
                    </xsl:if>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell font-size="12px" text-align="center">
                  <fo:block>
                    <xsl:value-of select="cfdi:Emisor/@Nombre"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell font-size="12px">
                  <fo:block>
                    <xsl:call-template name="TipoDeComprobante">
                      <xsl:with-param name="clave">
                        <xsl:value-of select="@TipoDeComprobante"/>
                      </xsl:with-param>
                    </xsl:call-template>
                    <fo:inline font-weight="700">
                      <xsl:value-of select="concat(' ', @Serie, @Folio)"/>
                    </fo:inline>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
              <fo:table-row>
                <fo:table-cell text-align="center">
                  <fo:block>
                    <xsl:value-of select="cfdi:Emisor/@Rfc"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block>
                    <xsl:value-of select="@Fecha"/>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
              <fo:table-row>
                <fo:table-cell text-align="center">
                  <fo:block>
                    <fo:inline>Régimen Fiscal: </fo:inline>
                    <xsl:call-template name="TipoDeRegimenFiscal">
                      <xsl:with-param name="clave">
                        <xsl:value-of select="cfdi:Emisor/@RegimenFiscal"/>
                      </xsl:with-param>
                    </xsl:call-template>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block>
                    Página <fo:page-number/> de <fo:page-number-citation ref-id="eof"/>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
              <fo:table-row>
                <fo:table-cell text-align="center">
                  <fo:block>
                    <xsl:value-of select="cfdi:Addenda/ric:Datos/@DireccionEmisor"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block/>
                </fo:table-cell>
              </fo:table-row>
              <fo:table-row>
                <fo:table-cell text-align="center">
                  <fo:block>
                    <xsl:value-of select="cfdi:Addenda/ric:Datos/@TelefonoEmisor"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block/>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body" font-size="8px">
          <fo:table table-layout="fixed" width="100%" margin="0.1in 0">
            <fo:table-column column-width="45%"/>
            <fo:table-column column-width="28%"/>
            <fo:table-column column-width="27%"/>

            <fo:table-body text-align="left">
              <fo:table-row>
                <fo:table-cell padding-right="1mm">
                  <fo:block>
                    <fo:table table-layout="fixed" width="100%">
                      <fo:table-column column-width="100%"/>

                      <fo:table-body>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <fo:inline font-weight="700">
                                <xsl:value-of select="cfdi:Receptor/@Rfc"/>
                              </fo:inline>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <fo:inline font-weight="700">
                                <xsl:value-of select="cfdi:Receptor/@Nombre"/>
                              </fo:inline>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="cfdi:Addenda/ric:Datos/@NoCliente">
                                <fo:inline font-weight="700">Número de cliente: </fo:inline>
                                <xsl:value-of select="cfdi:Addenda/ric:Datos/@NoCliente"/>
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="cfdi:Addenda/ric:Datos/@DireccionReceptor">
                                <fo:inline font-weight="700">Dirección: </fo:inline>
                                <xsl:value-of select="cfdi:Addenda/ric:Datos/@DireccionReceptor"/>
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="cfdi:Addenda/ric:Datos/@TelefonoReceptor">
                                <fo:inline font-weight="700">Teléfono: </fo:inline>
                                <xsl:value-of select="cfdi:Addenda/ric:Datos/@TelefonoReceptor"/>
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="cfdi:Receptor/@NumRegIdTrib">
                                <fo:inline font-weight="700">Registro: </fo:inline>
                                <xsl:value-of select="cfdi:Receptor/@NumRegIdTrib"/>
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="cfdi:Receptor/@NumRegIdTrib">
                                <fo:inline font-weight="700">Residencia fiscal: </fo:inline>
                                <xsl:value-of select="cfdi:Receptor/@ResidenciaFiscal"/>
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                      </fo:table-body>
                    </fo:table>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell padding-right="1mm">
                  <fo:block>
                    <fo:table table-layout="fixed" width="100%">
                      <fo:table-column column-width="100%"/>

                      <fo:table-body>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="@CondicionesDePago">
                                <fo:inline font-weight="700">Condiciones de pago: </fo:inline>
                                <xsl:value-of select="@CondicionesDePago"/>
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="@FormaPago">
                                <fo:inline font-weight="700">Forma de pago: </fo:inline>
                                <xsl:call-template name="FormaDePago">
                                  <xsl:with-param name="clave">
                                    <xsl:value-of select="@FormaPago"/>
                                  </xsl:with-param>
                                </xsl:call-template>
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="@LugarExpedicion">
                                <fo:inline font-weight="700">Lugar de expedición: </fo:inline>
                                <xsl:value-of select="@LugarExpedicion"/>
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="@Moneda">
                                <fo:inline font-weight="700">Moneda: </fo:inline>
                                <xsl:value-of select="@Moneda"/>
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="@TipoCambio">
                                <fo:inline font-weight="700">Tipo de cambio: </fo:inline>
                                <xsl:value-of select="@TipoCambio"/>
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                      </fo:table-body>
                    </fo:table>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block>
                    <fo:table table-layout="fixed" width="100%">
                      <fo:table-column column-width="100%"/>

                      <fo:table-body>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="cfdi:Receptor/@UsoCFDI">
                                <fo:inline font-weight="700">Uso de CFDI: </fo:inline>
                                <xsl:call-template name="UsoCFDI">
                                  <xsl:with-param name="clave">
                                    <xsl:value-of select="cfdi:Receptor/@UsoCFDI"/>
                                  </xsl:with-param>
                                </xsl:call-template>
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="@MetodoPago">
                                <fo:inline font-weight="700">Método de pago: </fo:inline>
                                <xsl:call-template name="MetodoDePago">
                                  <xsl:with-param name="clave">
                                    <xsl:value-of select="@MetodoPago"/>
                                  </xsl:with-param>
                                </xsl:call-template>
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="cfdi:Addenda/ric:Datos/@NoAgente">
                                <fo:inline font-weight="700">Agente: </fo:inline>
                                <xsl:value-of select="cfdi:Addenda/ric:Datos/@NoAgente" />
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="cfdi:Addenda/ric:Datos/@NoAutorizacion">
                                <fo:inline font-weight="700">Autorización: </fo:inline>
                                <xsl:value-of select="cfdi:Addenda/ric:Datos/@NoAutorizacion" />
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                          <fo:table-cell>
                            <fo:block>
                              <xsl:if test="cfdi:Addenda/ric:Datos/@NoRequisicion">
                                <fo:inline font-weight="700">Requisición: </fo:inline>
                                <xsl:value-of select="cfdi:Addenda/ric:Datos/@NoRequisicion" />
                              </xsl:if>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                      </fo:table-body>
                    </fo:table>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>

          <fo:table table-layout="fixed" width="100%" font-weight="700"
                    background-color="#cfcfcf" page-break-inside="avoid">
            <fo:table-column column-width="10%"/>
            <fo:table-column column-width="15%"/>
            <fo:table-column column-width="15%"/>
            <fo:table-column column-width="4%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="11%"/>
            <fo:table-column column-width="22%"/>
            <fo:table-column column-width="14%"/>

            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block>
                    Cantidad
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block>
                    Clave
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block text-align="center" >
                    Clave Prod/Serv
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell number-columns-spanned="2">
                  <fo:block>
                    Unidad de medida
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block text-align="right">
                    Valor unitario
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block text-align="right">
                    Impuesto
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block text-align="right">
                    Importe
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
              <fo:table-row>
                <fo:table-cell number-columns-spanned="8">
                  <fo:block>
                    Descripción
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>

          <xsl:for-each select="cfdi:Conceptos/cfdi:Concepto">
            <fo:table table-layout="fixed" width="100%"
                      xsl:use-attribute-sets="zebra-table"
                      page-break-inside="avoid">
              <fo:table-column column-width="10%"/>
              <fo:table-column column-width="15%"/>
              <fo:table-column column-width="15%"/>
              <fo:table-column column-width="3%"/>
              <fo:table-column column-width="10%"/>
              <fo:table-column column-width="11%"/>
              <fo:table-column column-width="22%"/>
              <fo:table-column column-width="14%"/>

              <fo:table-body>
                <fo:table-row>
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="@Cantidad"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="@NoIdentificacion"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block text-align="center">
                      <xsl:value-of select="@ClaveProdServ"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="@ClaveUnidad"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="@Unidad"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block text-align="right">
                      <xsl:value-of select="format-number(@ValorUnitario, $decimal-format)"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell number-rows-spanned="2">
                    <fo:block>
                      <xsl:if test="cfdi:Impuestos">
                        <fo:table table-layout="fixed" width="100%">
                          <fo:table-column column-width="50%" />
                          <fo:table-column column-width="50%" />

                          <fo:table-body>
                            <xsl:for-each select="cfdi:Impuestos/cfdi:Traslados/cfdi:Traslado">
                              <fo:table-row>
                                <fo:table-cell>
                                  <fo:block text-align="right">
                                    <xsl:choose>
                                      <xsl:when test="contains(@TipoFactor, 'Exento')">
                                        Exento
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:call-template name="TipoDeImpuesto">
                                          <xsl:with-param name="Clave">
                                            <xsl:value-of select="@Impuesto"/>
                                          </xsl:with-param>
                                          <xsl:with-param name="Tasa">
                                            <xsl:value-of select="@TasaOCuota"/>
                                          </xsl:with-param>
                                        </xsl:call-template>:
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                  <fo:block text-align="right">
                                    <xsl:choose>
                                      <xsl:when test="contains(@TipoFactor, 'Exento')" />
                                      <xsl:otherwise>
                                        <xsl:value-of select="format-number(@Importe, $decimal-format)"/>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </fo:block>
                                </fo:table-cell>
                              </fo:table-row>
                            </xsl:for-each>

                            <xsl:for-each select="cfdi:Impuestos/cfdi:Retenciones/cfdi:Retencion">
                              <fo:table-row>
                                <fo:table-cell>
                                  <fo:block text-align="right">
                                    <xsl:call-template name="TipoDeImpuesto">
                                      <xsl:with-param name="Clave">
                                        <xsl:value-of select="@Impuesto"/>
                                      </xsl:with-param>
                                      <xsl:with-param name="Tasa">Retenido</xsl:with-param>
                                    </xsl:call-template>:
                                  </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                  <fo:block text-align="right">
                                    <xsl:value-of select="format-number(@Importe, $decimal-format)" />
                                  </fo:block>
                                </fo:table-cell>
                              </fo:table-row>
                            </xsl:for-each>
                          </fo:table-body>
                        </fo:table>
                      </xsl:if>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block text-align="right">
                      <xsl:value-of select="format-number(@Importe, $decimal-format)"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell number-columns-spanned="6">
                    <fo:block>
                      <xsl:value-of select="@Descripcion"/>
                      <xsl:if test="cfdi:InformacionAduanera/@NumeroPedimento">
                        <fo:inline font-weight="700"> Pedimento </fo:inline>
                        <xsl:value-of select="cfdi:InformacionAduanera/@NumeroPedimento"/>
                      </xsl:if>
                      <xsl:if test="cfdi:CuentaPredial/@Numero">
                        <fo:inline font-weight="700"> Cuenta Predial </fo:inline>
                        <xsl:value-of select="cfdi:CuentaPredial/@Numero"/>
                      </xsl:if>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block />
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </xsl:for-each>

          <xsl:if test="cfdi:Addenda/ric:Datos/ric:Observaciones">
            <fo:block margin="0.125in 0 0 0" padding="2mm" border="1px solid #333"
                      page-break-inside="avoid">
              <fo:inline font-weight="700">OBSERVACIONES</fo:inline>
              <fo:block linefeed-treatment="preserve" text-align="justify"
                        white-space-treatment="ignore-if-surrounding-linefeed"
                        white-space-collapse="false" >
                <xsl:value-of select="cfdi:Addenda/ric:Datos/ric:Observaciones" />
              </fo:block>
            </fo:block>
          </xsl:if>

          <fo:table table-layout="fixed" width="100%" margin-top="2mm"
                    keep-with-next.within-page="always">
            <fo:table-column column-width="75%" />
            <fo:table-column column-width="25%" />

            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block>
                    <xsl:if test="cfdi:Complemento/tfd:TimbreFiscalDigital">
                      <fo:table table-layout="fixed" width="100%" font-size="8px">
                        <fo:table-column column-width="1.25in" />
                        <fo:table-column column-width="4.75in" />

                        <fo:table-body text-align="left">
                          <fo:table-row>
                            <fo:table-cell number-rows-spanned="9">
                              <fo:block>
                                <xsl:call-template name="CodigoQR">
                                  <xsl:with-param name="folio">
                                    <xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@UUID" />
                                  </xsl:with-param>
                                  <xsl:with-param name="emisor">
                                    <xsl:value-of select="cfdi:Emisor/@Rfc" />
                                  </xsl:with-param>
                                  <xsl:with-param name="receptor">
                                    <xsl:value-of select="cfdi:Receptor/@Rfc" />
                                  </xsl:with-param>
                                  <xsl:with-param name="total">
                                    <xsl:value-of select="@Total" />
                                  </xsl:with-param>
                                  <xsl:with-param name="sello">
                                    <xsl:value-of select="@Sello" />
                                  </xsl:with-param>
                                </xsl:call-template>
                              </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                              <fo:block font-weight="700">
                                Este documento es una representación impresa de un CFDI
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                          <fo:table-row>
                            <fo:table-cell>
                              <fo:block>
                                <fo:inline font-weight="700">Folio fiscal: </fo:inline>
                                <xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@UUID"/>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                          <fo:table-row>
                            <fo:table-cell>
                              <fo:block>
                                <fo:inline font-weight="700">Número de certificado: </fo:inline>
                                <xsl:value-of select="@NoCertificado"/>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                          <fo:table-row>
                            <fo:table-cell>
                              <fo:block>
                                <fo:inline font-weight="700">Número de certificado del SAT: </fo:inline>
                                <xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@NoCertificadoSAT"/>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                          <fo:table-row>
                            <fo:table-cell>
                              <fo:block>
                                <fo:inline font-weight="700">RFC de proveedor de certificación: </fo:inline>
                                <xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@RfcProvCertif"/>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                          <fo:table-row>
                            <fo:table-cell>
                              <fo:block>
                                <fo:inline font-weight="700">Fecha de timbrado: </fo:inline>
                                <xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@FechaTimbrado"/>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                          <fo:table-row>
                            <fo:table-cell>
                              <fo:block>
                                <xsl:if test="cfdi:CfdiRelacionados">
                                  <fo:inline font-weight="700">CFDIs relacionados: </fo:inline>
                                  <xsl:for-each select="cfdi:CfdiRelacionados/cfdi:CfdiRelacionado">
                                    <xsl:value-of select="@UUID" />
                                    <xsl:if test="position() != last()">, </xsl:if>
                                  </xsl:for-each>
                                </xsl:if>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                          <fo:table-row>
                            <fo:table-cell>
                              <fo:block>
                                <xsl:if test="cfdi:CfdiRelacionados">
                                  <fo:inline font-weight="700">Tipo de relación: </fo:inline>
                                  <xsl:call-template name="TipoDeRelacionCFDI">
                                    <xsl:with-param name="clave">
                                      <xsl:value-of select="cfdi:CfdiRelacionados/@TipoRelacion"/>
                                    </xsl:with-param>
                                  </xsl:call-template>
                                </xsl:if>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                          <fo:table-row>
                            <fo:table-cell>
                              <fo:block>
                                <xsl:if test="cfdi:Addenda/ric:Datos/@ImporteLetra">
                                  <fo:inline font-weight="700">Cantidad con letra: </fo:inline>
                                  <xsl:value-of select="cfdi:Addenda/ric:Datos/@ImporteLetra"/>
                                </xsl:if>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                        </fo:table-body>
                      </fo:table>
                    </xsl:if>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block>
                    <fo:table table-layout="fixed" width="100%" font-size="8px">
                      <fo:table-column column-width="46%"/>
                      <fo:table-column column-width="54%"/>

                      <fo:table-body text-align="left">
                        <fo:table-row>
                          <fo:table-cell text-align="right">
                            <fo:block font-weight="700">
                              Subtotal:
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell text-align="right">
                            <fo:block>
                              <xsl:value-of select="format-number(@SubTotal, $decimal-format)"/>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>

                        <xsl:for-each select="cfdi:Impuestos/cfdi:Traslados/cfdi:Traslado">
                          <fo:table-row>
                            <fo:table-cell text-align="right">
                              <fo:block font-weight="700">
                                <xsl:call-template name="TipoDeImpuesto">
                                  <xsl:with-param name="Clave">
                                    <xsl:value-of select="@Impuesto"/>
                                  </xsl:with-param>
                                  <xsl:with-param name="Tasa">
                                    <xsl:value-of select="@TasaOCuota"/>
                                  </xsl:with-param>
                                </xsl:call-template>:
                              </fo:block>
                            </fo:table-cell>
                            <fo:table-cell text-align="right">
                              <fo:block>
                                <xsl:value-of select="format-number(@Importe, $decimal-format)"/>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                        </xsl:for-each>

                        <xsl:for-each select="cfdi:Impuestos/cfdi:Retenciones/cfdi:Retencion">
                          <fo:table-row>
                            <fo:table-cell text-align="right">
                              <fo:block font-weight="700">
                                <xsl:call-template name="TipoDeImpuesto">
                                  <xsl:with-param name="Clave">
                                    <xsl:value-of select="@Impuesto"/>
                                  </xsl:with-param>

                                  <xsl:with-param name="Tasa">Retenido</xsl:with-param>
                                </xsl:call-template>:
                              </fo:block>
                            </fo:table-cell>
                            <fo:table-cell text-align="right">
                              <fo:block>
                                <xsl:value-of select="format-number(@Importe, $decimal-format)"/>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                        </xsl:for-each>

                        <xsl:if test="(@Descuento) and (@Descuento != '0')">
                          <fo:table-row>
                            <fo:table-cell text-align="right">
                              <fo:block font-weight="700">
                                Descuento:
                              </fo:block>
                            </fo:table-cell>
                            <fo:table-cell text-align="right">
                              <fo:block>
                                <xsl:value-of select="format-number(@Descuento, $decimal-format)"/>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                        </xsl:if>

                        <fo:table-row>
                          <fo:table-cell text-align="right">
                            <fo:block font-weight="700">
                              Total:
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell text-align="right">
                            <fo:block>
                              <xsl:value-of select="format-number(@Total, $decimal-format)"/>
                            </fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                      </fo:table-body>
                    </fo:table>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>

          <xsl:if test="cfdi:Complemento/tfd:TimbreFiscalDigital">
            <fo:table font-size="4px" margin-top="1mm" width="100%"
                      table-layout="fixed" page-break-inside="avoid">
              <fo:table-column column-width="50%" />
              <fo:table-column column-width="50%" />

              <fo:table-body>
                <fo:table-row>
                  <fo:table-cell>
                    <fo:block>
                      <xsl:call-template name="formatted-string">
                        <xsl:with-param name="count">143</xsl:with-param>
                        <xsl:with-param name="label">Sello CFD</xsl:with-param>
                        <xsl:with-param name="string">
                          <xsl:value-of select="@Sello"/>
                        </xsl:with-param>
                      </xsl:call-template>
                    </fo:block>
                  </fo:table-cell>

                  <fo:table-cell>
                    <fo:block>
                      <xsl:call-template name="formatted-string">
                        <xsl:with-param name="count">144</xsl:with-param>
                        <xsl:with-param name="label">Sello SAT</xsl:with-param>
                        <xsl:with-param name="string">
                          <xsl:value-of select="cfdi:Complemento/tfd:TimbreFiscalDigital/@SelloSAT"/>
                        </xsl:with-param>
                      </xsl:call-template>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>

                <fo:table-row>
                  <fo:table-cell number-columns-spanned="2">
                    <fo:block>
                      <xsl:call-template name="formatted-string">
                        <xsl:with-param name="count">288</xsl:with-param>
                        <xsl:with-param name="label">Cadena original de complemento de certificación digital del SAT</xsl:with-param>
                        <xsl:with-param name="string">
                          <xsl:choose>
                            <xsl:when test="cfdi:Complemento/tfd:TimbreFiscalDigital/@Leyenda">
                              <xsl:value-of select="concat(
                                '||',
                                cfdi:Complemento/tfd:TimbreFiscalDigital/@Version, '|',
                                cfdi:Complemento/tfd:TimbreFiscalDigital/@UUID, '|',
                                cfdi:Complemento/tfd:TimbreFiscalDigital/@FechaTimbrado, '|',
                                cfdi:Complemento/tfd:TimbreFiscalDigital/@RfcProvCertif, '|',
                                cfdi:Complemento/tfd:TimbreFiscalDigital/@Leyenda, '|',
                                @Sello, '|',
                                cfdi:Complemento/tfd:TimbreFiscalDigital/@NoCertificadoSAT, '||'
                              )"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="concat(
                                '||',
                                cfdi:Complemento/tfd:TimbreFiscalDigital/@Version, '|',
                                cfdi:Complemento/tfd:TimbreFiscalDigital/@UUID, '|',
                                cfdi:Complemento/tfd:TimbreFiscalDigital/@FechaTimbrado, '|',
                                cfdi:Complemento/tfd:TimbreFiscalDigital/@RfcProvCertif, '|',
                                @Sello, '|',
                                cfdi:Complemento/tfd:TimbreFiscalDigital/@NoCertificadoSAT, '||'
                              )"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:with-param>
                      </xsl:call-template>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </xsl:if>

          <xsl:if test="cfdi:Addenda/ric:Datos/ric:Pagare">
            <fo:block margin="2mm 0 0 0" padding="2mm" border="1px solid #333"
                      page-break-inside="avoid">
              <fo:inline font-weight="700">PAGARÉ</fo:inline>
              <fo:block linefeed-treatment="preserve" text-align="justify"
                        white-space-treatment="ignore-if-surrounding-linefeed"
                        white-space-collapse="false" >
                <xsl:value-of select="cfdi:Addenda/ric:Datos/ric:Pagare" />
              </fo:block>
            </fo:block>
          </xsl:if>

          <fo:block id="eof"/>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:attribute-set name="zebra-table">
    <xsl:attribute name='background-color'>
      <xsl:choose>
        <xsl:when test="position() mod 2 = 0">#ffffff</xsl:when>
        <xsl:otherwise>#f0f0f0</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <!-- Formato para cadenas de texto grandes -->
  <xsl:template name="formatted-string">
    <xsl:param name="count"/>
    <xsl:param name="label"/>
    <xsl:param name="string"/>

    <fo:block font-weight="700">
      <xsl:value-of select="$label"/>:
    </fo:block>

    <fo:block>
      <xsl:value-of select="substring($string, 1, $count)"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="substring($string, $count + 1, $count)"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="substring($string, 2*$count + 1, $count)"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="substring($string, 3*$count + 1, $count)"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="substring($string, 4*$count + 1, $count)"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="substring($string, 5*$count + 1, $count)"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="substring($string, 6*$count + 1, $count)"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="substring($string, 7*$count + 1, $count)"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="substring($string, 8*$count + 1, $count)"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="substring($string, 9*$count + 1, $count)"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="substring($string, 10*$count + 1, $count)"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="substring($string, 11*$count + 1, $count)"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="substring($string, 12*$count + 1, $count)"/>
    </fo:block>
  </xsl:template>

  <xsl:variable name="decimal-format" select="'#,##0.00'"/>
</xsl:stylesheet>
