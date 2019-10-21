class Message < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :message,presence: true, unless: 'image.present?'

  belongs_to :user
  belongs_to :group

end
