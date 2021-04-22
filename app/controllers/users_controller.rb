class UsersController < ApplicationController

  def show
    @user = User.find_by!(username: params.fetch(:id)) #! prevents passing nil forward and throwing 500 error
  end

end