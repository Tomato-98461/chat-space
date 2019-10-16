class GroupsUser < ApplicationRecord
  validates :user, presence: :ture

  belongs_to :user
  belongs_to :group
end
