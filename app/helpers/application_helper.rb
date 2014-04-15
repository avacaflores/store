module ApplicationHelper
  def truncate(text, options = {}, &block)
    if text
      length  = options.fetch(:length, 30)

      content = text.truncate(length, options)
      content = options[:escape] == false ? content.html_safe : ERB::Util.html_escape(content)
      content << capture(&block) if block_given? && text.length > length
      content
    end
  end
  
  def main_image(product)
    #i = product.images.first 
    product.photo.url(:thumb) unless product.photo.blank?
  end
  
  
end
