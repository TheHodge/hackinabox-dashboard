# == Schema Information
# Schema version: 20110715143653
#
# Table name: ircs
#
#  id         :integer         not null, primary key
#  by         :string(255)
#  message    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Irc < ActiveRecord::Base
  
  def self.start_bot
    bot = Isaac::Bot.new do
       configure do |c|
         c.nick    = "LeedsHackBot"
         c.server  = "irc.freenode.net"
         c.port    = 6667
       end

       on :connect do
         join "#leedshack"
       end

       on :channel, /\A(.*)\z/ do |body|
          params = {
             :by      => nick.to_s,
             :message => body
           }
          puts params
          @pusher = YAML::load(File.open("#{RAILS_ROOT}/config/pusher.yml"))

          Pusher.app_id = @pusher['app_id']
          Pusher.key = @pusher['key']
          Pusher.secret = @pusher['secret']
              Pusher['main'].trigger!('irc', {:by => nick.to_s,:message => CGI.escapeHTML(body)})

          message = Irc.new(params)
          puts "saved to the database" if message.save

       end 
     end

     EventMachine.run {bot.start}
  end
  
  
end
