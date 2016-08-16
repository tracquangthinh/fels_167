class UsersController < ApplicationController
  skip_before_action :logged_in_user, only: [:new, :create]
  before_action :load_user, except: [:new, :create, :index]
  before_action :authorize_user, only: [:edit, :update]
  before_action :verify_admin, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t :sign_up_successful
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @activities = @user.activities.order(created_at: :desc)
      .paginate page: params[:page]
    @type_title = Settings.profile_title.history
  end

  def index
    @users = User.paginate page: params[:page]
    @type_title = Settings.profile_title.user_all
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t :profile_updated
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t :delete_successful
    else
      flash[:danger] = t :delete_fail
    end
    redirect_to users_path
  end

  def following
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.per_page
    @type_title = Settings.profile_title.following
    render :show_follow
  end

  def followers
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.per_page
    @type_title = Settings.profile_title.follower
    render :show_follow
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :phone, :address,
      :sex, :avatar, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t :not_found_user
      redirect_to users_path
    end
  end
end
