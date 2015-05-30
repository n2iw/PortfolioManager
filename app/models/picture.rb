class Picture < ActiveRecord::Base
  belongs_to :work
  acts_as_list scope: :work

  has_attached_file :file, :styles => { large: "800x800>", thumb: "200x200>" }
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  scope :visible, lambda { where(visible: true) }
  scope :sorted, lambda { order('position') }
end
