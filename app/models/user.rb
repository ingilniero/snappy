class User < ActiveRecord::Base

  has_secure_password

  has_many :questions

  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { in: 4..12 },
                       format: { with: /[a-z][a-z0-9]*/, message: 'can only contain lowecase letters and numbers' }
  validates :password, length: { in: 4..8 }
  validates :password_confirmation, length: { in: 4..8 }

  def your_questions(page = 1)
    questions.order('created_at DESC').page(page).per(3)
  end
end
