module ApplicationHelper
  
  def main_image(product)
    #i = product.images.first 
    product.photo.url(:thumb) unless product.photo.blank?
  end
  
  def list_item(label,data)

    #content_tag(:dt, :strong, label)
    # return content_tag(:dd, data)
    

    # return  content_tag(:dt, label)
    #    content_tag(:dd, data)
     # line2(data)   
     # line1(label)
      
       content_tag(:dt, label+":")
       
       # content_tag(:dt) do
       #   content_tag(:dd, "aa")
       # end
       # 
       # content_tag(:dd, data)

  end
  
  def row_title(label)
    tag(:strong)
    content_tag(:dt, label+":")
  end
  
  
  def row_content(data)
    content_tag(:dd, data)
  end
  
  
end
