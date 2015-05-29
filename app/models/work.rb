class Work < ActiveRecord::Base
  acts_as_list

  has_attached_file :thumbnail, :styles => { :thumb => "200x200>" }
  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/

  scope :visible, lambda { where(visible: true) }
  scope :sorted, lambda { order('position desc') }
end
