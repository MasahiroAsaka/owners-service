class Plan < ApplicationRecord
  has_many :captured_images
  has_many :courses
  has_many :captured_image_courses, through: :courses
  accepts_nested_attributes_for :captured_images
end
