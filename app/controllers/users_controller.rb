class UsersController < ApplicationController

  def show
    #@user = User.find_by!(username: params.fetch(:id)) #! prevents passing nil forward and throwing 500 error
    @user = User.find_by!(username: params.fetch(:username))
  end

  def followers
    @user = User.find_by!(username: params.fetch(:username))
  end

end