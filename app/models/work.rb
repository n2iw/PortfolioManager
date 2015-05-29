class Work < ActiveRecord::Base
  has_many :pictures, dependent: :destroy
  acts_as_list

  has_attached_file :thumbnail, :styles => { :thumb => "200x200>" }
  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/

  scope :visible, lambda { where(visible: true) }
  scope :sorted, lambda { order('position') }
end
