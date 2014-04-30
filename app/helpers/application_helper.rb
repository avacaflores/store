module ApplicationHelper
  
  def main_image(product)
    #i = product.images.first 
    product.photo.url(:thumb) unless product.photo.blank?
  end
  
  
  def row_title(label)
    tag(:strong)
    content_tag(:dt, label+":")
  end
  
  
  def row_content(data)
    content_tag(:dd, data)
  end
  
  
  def click_section
    
    render products_path
  end
  
  
end
