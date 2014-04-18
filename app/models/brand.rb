class Brand < ActiveRecord::Base

  has_many :products
  
  validates :name, presence: true
  validates :name, uniqueness: true

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "uno.jpg"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
end
