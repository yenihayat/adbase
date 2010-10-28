module ConnectHelper
  def partitionize id
    ("%09d" % id).scan(/\d{3}/).join("/")
  end

  # def classy_name(name)
  #   separator = '-'
  #   name.gsub("'", separator)
  #   classy_name = name.gsub("ş", "s").gsub("ğ", "g").gsub("ı", "i").gsub("ü", "u").gsub("ç", "c").gsub("ö", "o").gsub("İ", "i").gsub("Ö", "o").gsub("Ç", "c").gsub("Ş", "s").gsub("Ü", "u")
  #   classy_name = classy_name.downcase!
  #   classy_name.gsub!(/[^a-z0-9]+/, separator)
  #   return classy_name.gsub(/^\\#{separator}+|\\#{separator}+$/, '')
  # end
end
