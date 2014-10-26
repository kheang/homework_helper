class Problem < ActiveRecord::Base

  belongs_to :user
  has_many :notes
  validates :issue, presence: true
  validates :try, presence: true
  # validates :user, presence: true

  def has_chosen_note?
    notes.where(chosen: true).count > 0
  end
  def note_count
    notes.count
  end
  def name
    @current_user
  end
end
