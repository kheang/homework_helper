class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem

  after_create :send_email

  validates :comment, presence: true
  validates :problem, presence: true
  validates :user, presence: true

  validate :check_single_choice

  def check_single_choice
    return unless problem.present? && problem.resolved && self.chosen?
    errors.add(:chosen, 'cannot be chosen because problem already closed')
  end

  def send_email
    UserMailer.new_note(id).deliver if user != problem.user
  end
end
