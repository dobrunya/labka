class ActionJournal < ActiveRecord::Base

  belongs_to :user

  def self.perform_analyze(id)
    where(user_id: id).group_by {|action| action.danger_level }
  end

end
