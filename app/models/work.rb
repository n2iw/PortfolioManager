class Work < ActiveRecord::Base
  before_validation :pre_process

  has_many :pictures, dependent: :destroy
  has_many :process_pictures, dependent: :destroy
  acts_as_list scope: [:award]

  has_attached_file :thumbnail, :styles => { :thumb => "200x200>", large: "800x800>" }
  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true,
                   uniqueness: true
  validates :thumbnail, presence: true

  scope :visible, lambda { where(visible: true) }
  scope :normal, lambda { where(award: false) }
  scope :awarded, lambda { where(award: true) }
  scope :sorted, lambda { order('position') }

  def pre_process
    self.name = name.titleize
    unless visible
      self.move_to_bottom
    end
  end
end
