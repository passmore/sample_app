class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.order(:created_at).page(params[:page])
  end

  def show
    @microposts = @user.microposts.page(params[:page])
  end

  def new
    redirect_to(root_url) if signed_in?
    @user = User.new
  end

  def create
    redirect_to(root_url) if signed_in?
    @user = User.new(user_params)    # Use strong parameters!
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    begin
      @user.destroy
      flash[:success] = "User #{@user.name} deleted."
      rescue StandardError => e
      flash[:notice] = e.message
    end
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
    end

    # Before actions use callbacks to share common setup or
    # constraints between actions.

    def set_user
      @user = User.find(params[:id])
    end

    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
