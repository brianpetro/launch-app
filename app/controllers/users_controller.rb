class UsersController < ApplicationController
  def create
    render json: {}.to_json, status: 200
  end
  def confirm
  end
end
