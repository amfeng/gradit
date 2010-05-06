class FacebookController < ApplicationController
  ensure_authenticated_to_facebook
  filter_parameter_logging :fb_sig_friends
  def canvas
  	count_friends
  end
  
  def count_friends
	  @count = 0
	  #this session variable is set automatically by the facebooker plugin
	  fbsession = session[:facebook_session]
	  #iterate thru your friends.  fbsession.user grabs your user account and then .friends pulls in all your friends
	  fbsession.user.friends.each do |user|
	    @count += 1
	  end
  end


end
