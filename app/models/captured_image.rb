class CapturedImage < ApplicationRecord
  belongs_to :plan
  mount_uploader :content, PlanImageUploader
  enum status: %i(main sub card index)
end
