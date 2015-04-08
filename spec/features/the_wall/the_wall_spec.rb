require 'rails_helper'

feature 'User views the wall' do
  scenario 'the app pushes out 1 new messages to the wall' do
    @wall = create(:wall)
  end
end

# App has to push out the new messages on a timer
# Any requests to show controller will only show those messages - not selecting any more
#  - else every time there's a request, a new bunch of messages will be pulled..
# its more like a twitter feed - everyone sees the same thing, until a certain amount of time has passed...
# then push out new messages...
# if the messages::times_shown field needs to be updated.... 

# there needs to be a batch of messages, which the timed task will construct every x mins.
#  each batch will have 1 - x messages, based on how much text is in each individual message
#  every request for the wall will show the current batch of messages, 
#  once a message is included in a batch, increment it's time_shown field
#  

# The app can push out more than one message if the first message is very short
# The time of the next push may be based on the length of the message(s) sent out...
# 