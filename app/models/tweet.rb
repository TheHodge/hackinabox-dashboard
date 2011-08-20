# == Schema Information
# Schema version: 20110731131045
#
# Table name: tweets
#
#  id         :integer         not null, primary key
#  username   :string(255)
#  body       :string(255)
#  avatar_url :string(255)
#  status_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  tweeted_at :datetime
#

class Tweet < ActiveRecord::Base
  
  validates :status_id, :uniqueness => true 
  
  def self.get_tweets
    
    lastresult = Tweet.order(:status_id).last
    search = Twitter::Search.new
    
    if !lastresult.nil?
      lastid = lastresult.status_id
    else
      lastid = 0
    end
    
    puts "Staring at id -- #{lastid}"
    
    tweets = Array.new
    
    #Get the first page and any following pages of tweets
    search.containing("leedshack").since_id(lastid).result_type("mixed").each do |t|
      tweets << t
    end
    while search.next_page? 
      search.fetch_next_page.each do |t|
        tweets << t
      end
    end
    
    if tweets.any?
      #Add tweets to the database
      tweets.each do |tweet|
        puts "Processing Tweet - #{tweet.id}"
        params = {
          :username    => tweet['from_user'].to_s,
          :avatar_url  => tweet['profile_image_url'].to_s,
          :body        => sanitize(tweet['text'].to_s),
          :status_id   => tweet['id'],
          :tweeted_at  => Time.parse(tweet['created_at'])
        }
        # Insert the record, then hackily update the coords. We're fucked if anyone returns an SQL injection via the coordinates field on twitter.
        @tweet = Tweet.new(params)
        @tweet.save
        @pusher = YAML::load(File.open("#{RAILS_ROOT}/config/pusher.yml"))

        Pusher.app_id = @pusher['app_id']
        Pusher.key = @pusher['key']
        Pusher.secret = @pusher['secret']       

       Pusher['main'].trigger!('tweet', {:username => tweet['from_user'].to_s,:tweet => CGI.escapeHTML(tweet['text'].to_s),:avatar_url => tweet['profile_image_url'].to_s})
      end
    else
      puts "No new tweets"
    end
      
  end
    
end
