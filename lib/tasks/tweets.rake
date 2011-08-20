namespace 'tweets' do
  desc ' Updates the latest leedshack tweets'
  task 'get_tweets' => 'environment' do 
    Tweet.get_tweets
  end
end
