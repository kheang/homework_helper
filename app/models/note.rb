class Note < ActiveRecord::Base
  belongs_to :user
	belongs_to :problem

  validates :comment, presence: true
  validates :user, presence: true
  validates :problem, presence: true

  validate :check_one_chosen_note_per_question




  def check_one_chosen_note_per_problem
    return unless problem.present?

    if problem.has_chosen_note? && self.chosen?
      errors.add(:chosen, "cannot be chosen because there is already a chosen note for that problem")
    end
  end

end
