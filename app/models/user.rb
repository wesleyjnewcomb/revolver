class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :albums, foreign_key: "uploader_id"

  enum role: [ :user, :admin ]

  validates :username,
    presence: true,
    length: { in: 3..20 },
    format: { with: /\A[a-zA-Z0-9_-]+\z/ }

  validates :role, inclusion: { in: User.roles.keys }

  def admin?
    role == 'admin'
  end

end
