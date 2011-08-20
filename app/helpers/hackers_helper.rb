module HackersHelper
  
  def gravatar_for(hacker, options = { :size => 50})
    gravatar_image_tag(hacker.email.downcase, :alt => hacker.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
  
end
