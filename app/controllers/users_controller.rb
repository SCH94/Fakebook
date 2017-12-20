class UsersController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @users = User.all
    end
    
    def search
        @q = "#{params[:q]}"
        @results = User.all.where("name ILIKE ? or email ILIKE ?", @q, @q)
        render :search
    end
    
    def show
        @user = User.find(params[:id])
        @friends_list = @user.friends.map { |friend| User.find(friend_id(@user, friend)) }
        @feed = @user.posts
    end
    
    def friends_list
        @user = User.find(params[:user_id])
    end
    
    def friend_id(user, friend)
        friend.requestee_id == user.id ? friend.requested_id : friend.requestee_id
    end
end