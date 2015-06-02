class Work < ActiveRecord::Base
  before_validation :pre_process

  has_many :pictures, dependent: :destroy
  acts_as_list

  has_attached_file :thumbnail, :styles => { :thumb => "200x200>" }
  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true,
                   uniqueness: true
  validates :thumbnail, presence: true

  scope :visible, lambda { where(visible: true) }
  scope :sorted, lambda { order('position') }

  def pre_process
    self.name = name.titleize
    unless visible
      self.position = Work.count
    end
  end
end
