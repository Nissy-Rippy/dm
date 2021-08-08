class Room < ApplicationRecord
  has_many :chats,dependent: :destroy
  has_many :users_room,dependent: :destroy
end
