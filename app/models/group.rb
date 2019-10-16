class Group < ApplicationRecord
  validates :name, uniqueness: :true
  validates :name, presence: :true

  has_many :groups_users
  has_many :users, through: :groups_users
end
