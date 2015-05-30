class Picture < ActiveRecord::Base
  before_save :pre_process

  belongs_to :work
  acts_as_list scope: :work

  has_attached_file :file, :styles => { large: "800x800>", thumb: "200x200>" }
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  scope :visible, lambda { where(visible: true) }
  scope :sorted, lambda { order('position') }

  def pre_process
    unless visible
      self.position = self.work.pictures.count
    end
  end
end
