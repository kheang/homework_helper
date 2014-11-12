class Problem < ActiveRecord::Base
  belongs_to :user
  delegate :name, to: :user, prefix: true
  has_many :notes

  has_attached_file :screen
  validates_attachment_content_type :screen, :content_type => /\Aimage\/.*\Z/

  validates :issue, presence: true
  validates :try, presence: true
  validates :user, presence: true

  after_create :send_email

  def note_count
    notes.count
  end

  def send_email
    UserMailer.new_problem(id).deliver
  end
end
