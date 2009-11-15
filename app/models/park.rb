class Park < ActiveRecord::Base
  has_many :park_amenities
  has_many :links
  accepts_nested_attributes_for :park_amenities, :reject_if => lambda{|attrs| attrs['amenity_id'].blank? }, :allow_destroy => true

  validates_presence_of :name, :latitude, :longitude, :address

  default_scope :order => 'name'

  SECTIONS = %w{Northeast Northwest Southeast Southwest}

  def section
    SECTIONS[section_id || 0]
  end

  def section=(section)
    self.section_id = SECTIONS.index(section)
  end

end
