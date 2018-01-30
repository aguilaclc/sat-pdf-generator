class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def pdf
    xml = params[:xml]

    if xml && xml.content_type == 'text/xml'
      make_pdf xml.read
    else
      redirect_back(fallback_location: root_url)
    end
  end

  def make_pdf xml
    tmp_xml = Tempfile.new 'upload', encoding: 'ascii-8bit'
    tmp_xml.write(xml)
    tmp_xml.close

    path = "#{Rails.root}/lib/xsl"
    xsl_path = "#{path}/pdf.xsl"
    config_path = "#{path}/fop_config.xml"
    data = `fop -c #{config_path} -xml #{tmp_xml.path} -xsl #{xsl_path} -`

    timestamp = Time.now.strftime "%Y%m%d%H%M"

    send_data data, filename: "file_#{timestamp}.pdf", type: :pdf, disposition: :inline
  end
end
