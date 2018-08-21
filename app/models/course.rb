class Course < ApplicationRecord
  belongs_to  :plan
  has_many    :course_descriptions
  has_many    :captured_image_courses
end
