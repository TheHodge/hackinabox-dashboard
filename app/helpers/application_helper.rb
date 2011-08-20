module ApplicationHelper
  
  def logo
    image_tag("logo.png", :alt => "Logo", :class => "png_bg", :width => "400", :height => "100")
  end
  
  def icon(icon_name, alt)
    image_tag("icons/#{icon_name}.png", :alt => alt, :class => "png_bg", :width => "32", :height => "32")
  end
  
  def timer
    now = Time.now
    if now < Time.local(2011,"aug",6,12,00,00) 
      endtime = Time.local(2011,"aug",6,12,00,00)
      endtext = " until Hacking begins!"
    else
      endtext = " of Hacking Left..."
      endtime = Time.local(2011,"aug",7,12,00,00)
    end 
    distance_of_time_in_words(now, endtime, true) + endtext
  end
  
end
