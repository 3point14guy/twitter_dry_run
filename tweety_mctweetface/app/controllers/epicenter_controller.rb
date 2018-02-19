class EpicenterController < ApplicationController
  def feed
    # feed looks for a current user in the do block.  If logging out, page errors because the root path is set to epicenter#feed and no current_user exists on logout. This if statement redirects to the login screen if there is no current_user.
    if current_user != nil
      # initiate an empty array and assign it to the instance variable @following_tweets
      @following_tweets = []
      # get all the Tweets and iterate through them
      Tweet.all.each do |tweet|
        # if in the current iteration, the tweet.user_id is in the current_user's following attribute column OR if the current_user id equates to the tweet.user_id
        if (current_user.following.include?(tweet.user_id) || current_user.id == tweet.user_id)
          # add that tweet to the following_tweets array
          @following_tweets.push(tweet)
        end
      end
    else
      redirect_to new_user_session_url
    end
  end

  def all_users
    # assign all users, orderd by username, to the instance variable @users
    @users = User.order(:username)
  end

  def tag_tweets
    # assign the tag with the specified id to the instance variable @tag
    @tag = Tag.find(params[:id])
  end

  def show_user
    # assign the user with the specified id to the instance variable @user
  	@user = User.find(params[:id])
  end

  def following
    # assign the user with the specified id to the instance variable @user
    @user = User.find(params[:id])
    # initiate an empty array and assign it to the instance variable @users
    @users = []

    # get all users and iterate through them
    User.all.each do |user|
      # if the itereated user.id is included in this instance of the user's following attribute
      if @user.following.include?(user.id)
        #push this user into the @users array
        @users.push(user)
      end
    end
  end
  
  def followers
    # same as above for following
    @user = User.find(params[:id])
    @users = []

    # same as above for following
    User.all.each do |user|
      # if this instance of user.id is included in the the following column of the iterated user
      if user.following.include?(@user.id)
        # push this user into the @users array
        @users.push(user)
      end
    end
  end

  def now_following
    # push the selected user_id into the array that is in the following attribute for the current_user
  	current_user.following.push(params[:id].to_i)
    # save this updated array (current_user is given to us by Devise and follows it's own syntax)
  	current_user.save
    # do not go to the now_following view. go to the show_user view for the selected id.
  	redirect_to show_user_path(id: params[:id])
  end

  def unfollow
    # remove the selected user_id from the array that is in the following column for the current_user
  	current_user.following.delete(params[:id].to_i)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])
  end
end
