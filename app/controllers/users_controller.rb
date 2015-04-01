class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path(msg: 'Confirm your email to complete request.') }
        format.json { render json: {email: @user.email}.to_json }
      else
        format.html { render 'home/index' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    if user = User.read_access_token(params[:signature])
      user.update! confirmed: true
      redirect_to root_path(msg: "Confirmed #{user.email}! Request complete.")
    else
      render text: "Invalid Link"
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :tracker)
    end
end
