class Picture < ActiveRecord::Base
  belongs_to :work
  acts_as_list scope: :work

  has_attached_file :file, :styles => { large: "800x", thumb: "200x" }
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  validates :file, presence: true
  validates :work_id, presence: true

  scope :sorted, lambda { order('position') }

end
