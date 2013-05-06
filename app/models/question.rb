class Question < ActiveRecord::Base
  belongs_to :user

  validates :body, presence: true, length: { in: 10..255 }
  validates :solved, inclusion: { in: [true, false] }

  scope :unsolved, lambda { |page = 1| where(solved: false).order('created_at DESC').page(page).per(3) }
end
