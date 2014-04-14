class ImagesController < ApplicationController
  before_action :load_product
  def create
    @image = @product.images.new(image_params)
    if @image.save
      redirect_to @product, notice: 'Image added'
    else
      redirect_to @product, alert: 'Unable to add image'
    end
end
  def destroy
    @image = @product.images.find(params[:id])
    @image.destroy
    redirect_to @product, notice: 'Image deleted'
end
  private
  def load_product
    @product = Product.find(params[:product_id])
  end
  def image_params
    params.require(:image).permit(:url, :use, :image)
end
end
