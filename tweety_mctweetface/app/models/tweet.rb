class Tweet < ApplicationRecord
	belongs_to :user

	validates :message, presence: true, length: {maximum: 280, too_long: "A tweet can only be 280 characters."}
end
