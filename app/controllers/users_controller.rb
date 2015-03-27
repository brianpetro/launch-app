class UsersController < ApplicationController
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path(msg: 'Confirm your email to complete request.') }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to root_path(msg: 'Unable to complete request.') }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
  end

  private
    def user_params
      params.require(:user).permit(:email, :tracker)
    end
end
