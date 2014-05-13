class Product < ActiveRecord::Base

  validates :title, :brand_id, :section_id, presence: true
  validates :title, uniqueness: true
  
  belongs_to :brand
  belongs_to :section
  
  accepts_nested_attributes_for :brand
  accepts_nested_attributes_for :section
  
  scope :promotion, lambda { where(promotion: true) }
  scope :brand, lambda { |term| where(brand_id: term) }
     
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "no-image.jpg"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
     
end
