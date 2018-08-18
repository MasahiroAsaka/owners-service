class CapturedImageCourse < ApplicationRecord
  belongs_to :course
  belongs_to :plan
  mount_uploader :content, CourseImageUploader
end
