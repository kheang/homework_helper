class Problem < ActiveRecord::Base
  belongs_to :user
  has_many :notes

  validates :issue, presence: true
  validates :try, presence: true
  validates :user, presence: true

  after_create :send_email

  def has_chosen_note?
    notes.where(chosen: true).count > 0
  end

  def note_count
    notes.count
  end

  def send_email
    UserMailer.new_problem(self.id).deliver
  end
end
