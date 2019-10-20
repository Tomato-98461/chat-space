class GroupsUser < ApplicationRecord
  validates :user, presence: :ture
  validates :group, presence: true

  belongs_to :user
  belongs_to :group
end
