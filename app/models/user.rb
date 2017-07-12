class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, uniqueness: true, length: { in: 1..30}
  validates :email, presence: true, uniqueness: true






end
