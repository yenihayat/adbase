module ConnectHelper
  # Build ad content by content type.
  def ad_content(content_type, zone_uuid, ad_target_url, ad_id, ad_file_name, ad_width, ad_height)
      content = ""
    if content_type.include?('image')
      content += "var target_url = document.createElement('a');\n"
      content += "target_url.href = '#{CONFIG["redirect_out_url"]}#{ad_id}';\n"
      content += "var ad_content = document.createElement('img');\n"
      content += "ad_content.setAttribute('class', 'ad');\n"
      content += "ad_content.src = '#{CONFIG["ad_contents_url"]}#{partitionize(ad_id)}/#{ad_file_name}';\n"
      content += "ad_content.border = '0';\n"
      content += "target_url.appendChild(ad_content);\n"
      content += "var scr = document.getElementById('#{zone_uuid}');\n"
      content += "scr.parentNode.insertBefore(target_url, scr);\n"
    elsif content_type.include?('application')
      content += "var ad_content = document.createElement('object');\n"
      content += "ad_content.setAttribute('type', 'application/x-shockwave-flash');\n"
      content += "ad_content.setAttribute('width', '" + ad_width + "');\n"
      content += "ad_content.setAttribute('height', '" + ad_height + "');\n"
      content += "ad_content.setAttribute('data', '#{CONFIG["ad_contents_url"]}#{partitionize(ad_id)}/#{ad_file_name}');\n"
      content += "var param1 = document.createElement('param');\n"
      content += "param1.setAttribute('name', 'movie');\n"
      content += "param1.setAttribute('value', '#{CONFIG["ad_contents_url"]}#{partitionize(ad_id)}/#{ad_file_name}');\n"
      content += "ad_content.appendChild(param1);\n"
      content += "var scr = document.getElementById('#{zone_uuid}');\n"
      content += "scr.parentNode.insertBefore(ad_content, scr);\n"
    else
      content += ""
    end
    return content
  end

  # Create url of content.
  def partitionize id
    ("%09d" % id).scan(/\d{3}/).join("/")
  end
end
