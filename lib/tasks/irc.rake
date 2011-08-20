namespace 'irc' do
  desc ' Updates the latest leedshack irc messages'
  task 'get_irc' => 'environment' do 
    Irc.start_bot
  end
end
