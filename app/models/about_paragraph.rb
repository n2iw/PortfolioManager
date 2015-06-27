class AboutParagraph < ActiveRecord::Base
  acts_as_list

  scope :sorted, lambda { order('position') }
end
