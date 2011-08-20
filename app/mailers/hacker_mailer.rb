class HackerMailer < ActionMailer::Base
  default :from => "LeedsHack Hackerboard <heather@hodgetastic.com>"
  
  def password_reset_instructions(hacker)
    @hacker = hacker
    @reset_password_link = reset_password_url(hacker.perishable_token)
    mail(:to => hacker.email, :subject => "HackInABox - Password Reset Instructions")
  end
end
