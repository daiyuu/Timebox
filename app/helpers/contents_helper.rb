module ContentsHelper
  def thumbnail_for(content)
    if content.thumbnail
      image_tag(content.thumbnail, {:width => "100", :height => "80"})
    else
      image_tag("6151yzyTXlL._SX355_.jpg", {:width => "100", :height => "80"})
    end
  end
end
