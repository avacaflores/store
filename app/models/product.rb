class Product < ActiveRecord::Base

  validates :title, presence: true
  validates :title, uniqueness: true
  
  has_many :images, -> { order('created_at ASC') }, :dependent => :destroy
  has_and_belongs_to_many :categories
  
  accepts_nested_attributes_for :images, allow_destroy: true
  
  scope :title, lambda { |term| where("products.title LIKE ?", "%#{term}%") }
  scope :no_price, lambda { where("products.price IS NULL") }
     
     
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "uno.jpg"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
     
     
     
  # No important   
     
  def after_create
    puts "We will notify the author"
  end
  
  def long_title
    "#{title} - #{description}"
  end
end
