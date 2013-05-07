class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :body, presence: true, length: { in: 10..255 }
  validates :solved, inclusion: { in: [true, false] }

  scope :unsolved, lambda { |page = 1| where(solved: false).order('created_at DESC').page(page).per(3) }

  def self.search(params)
    where('body LIKE ?', "%#{params[:keyword]}%").order('created_at DESC').page(params[:page]).per(3)
  end
end
