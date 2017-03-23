class UsersController < ApplicationController

  before_action :set_user, only: [:index]
  before_action :set_disk_data, only: :index
  skip_before_action :verify_authenticity_token

  def index
  end

  def login

  end

  def action
    apply_user
    set_disk_data
    unless @access_type.include?(params[:action_e])
      log_action(@user.id, 2, "Wrong, access required: #{params[:action_e]}")
      flash[:success] = 'Not allowed action'
    else
      log_action(@user.id, 0, "Successfuly performed action: #{params[:action_e]}")
      flash[:success] = 'Action was performed successfuly'
    end
    redirect_to user_index_path
  end

  def logout
    session[:user_id] = nil
    cookies[:logging_time] = nil
    redirect_to root_path
  end

  def logout_with_error
    if session[:user_id]
      @user = User.find(session[:user_id])
      @user.error_count = !@user.error_count ? 1 : @user.error_count + 1
      log_action(@user.id, 3, 'Wrong secret answer supplied')
      if @user.error_count >= 4
        @user.destroy
      else
        @user.save!
      end
    end
    flash[:success] = 'Wrong!'
    logout
  end

  def create

  end

  def calc_function
    function
  end

  def ask_user
    if session[:user_id]
      @user = User.find(session[:user_id])
      @result = if rand > 0.5
                 @user.secret_questions.shuffle.first
               else
                 rand(10)
               end
    end
  end

  def save
    raise StandardError if !params[:id]
    record = RegistrationJournal.find(params[:id])
    user = User.create(username: record.username, password: record.password)
    record.questions.each do |qa|
      SecretQuestion.create(user_id: user.id, question: qa.first, answer: qa.second)
    end
    record.destroy
    flash[:success] = 'Done'
    redirect_to user_list_path
  rescue
    flash[:success] = 'Something went wrong'
    redirect_to user_list_path
  end

  def authenticate
    user = User.find_by(user_params)
    if user
      session[:user_id] = user.id
      cookies[:logging_time] = "#{Time.now.min}"
      redirect_to user_index_path
    else
      if user = User.find_by(username: params[:username])
        flash[:success] = 'Wrong Password'
        log_action(user.id, 1, 'Wrong password wrote')
      else
        flash[:success] = 'No user'
      end
      redirect_to root_path
    end
  end


  private

  def set_user
    if session[:user_id]
      @user = User.find(session[:user_id])
      if params['action'] != 'index' && !@user.admin
        redirect_to user_index_path
      end
    else
      redirect_to root_path
    end
  end

  def apply_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def user_params
    params.permit(:username, :password)
  end

  def set_disk_data
    @access_type = @user.admin ? %w{R E W A C O} : %w{R E}
    disk_names = @user.admin ? %w{A B C D E} : %w{C D E}
    @disks_array = Disk.where(name: disk_names)
  end
end
