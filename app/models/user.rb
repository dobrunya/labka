class User < ActiveRecord::Base

  has_many :secret_questions
  has_many :action_journals


  validates :password, length: {minimum: 7}

  before_create :check_count_of_users

  def check_count_of_users
    !(User.all.size >= 12)
  end

  def self.analyze_all_users
    all.map do |user|
      ActionJournal.perform_analyze(user.id)
    end
  end

end
