class JournalsController < ApplicationController

  before_action :set_user, only: [:index, :action_journal]
  skip_before_action :verify_authenticity_token

  def index
    @journal = RegistrationJournal.all
  end

  def action_journal
    @journal = ActionJournal.all
  end

  def create

  end

  def delete
    RegistrationJournal.find(params[:id]).destroy if params[:id]
    redirect_to user_list_path
  end

  def save
    qa = params[:question].map.with_index{ |el, index| [el, params[:answer][index]] }
    RegistrationJournal.create(username: params[:username], password: params[:password], questions: qa)
    flash[:success] = params[:password].size >= 7 ? 'Succesfuly saved' : 'Password was less than 7, but we still save it'
    redirect_to create_user_path
  end

  private

  def set_user
    if session[:user_id]
      @user = User.find(session[:user_id])
      if !@user.admin
        redirect_to user_index_path
      end
    else
      redirect_to root_path
    end
  end
end
