module ConnectHelper
  def ad_content(content_type, zone_uuid, ad_target_url, ad_id, ad_file_name)
    if content_type.include?('image')
      content = "// AdBase##{zone_uuid} Content\n"
      content += "var target_url = document.createElement('a');\n"
      content += "target_url.href = 'http://connect.lvh.me:3000/redirect/#{ad_id}';\n"
      content += "var ad_content = document.createElement('img');\n"
      content += "ad_content.setAttribute('class', 'ad');\n"
      content += "ad_content.src = 'http://static.adbase.local/system/ads/#{partitionize(ad_id)}/#{ad_file_name}';\n"
      content += "ad_content.border = '0';\n"
      content += "target_url.appendChild(ad_content);\n"
      content += "var scr = document.getElementById('#{zone_uuid}');\n"
      content += "scr.parentNode.insertBefore(target_url, scr);\n"
    elsif content_type.include?(flash)
      content = "Flash Content Test"
    end
    return content
  end

  def partitionize id
    ("%09d" % id).scan(/\d{3}/).join("/")
  end

  def encode_target_url(url)
    URI.escape(url, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  end
end
