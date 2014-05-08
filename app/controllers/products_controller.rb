class ProductsController < ApplicationController
  
  skip_before_action :authorize, only: [:index, :show, :promotion]
  
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @sections = Section.all.order(:name)
    @brands = Brand.all.order(:name)
    @products_promo = Product.where('promotion' => true)
    
    if session[:sections_filter].nil? and session[:brands_filter].nil?
      @products = Product.all
    else 
      if session[:sections_filter].nil?
        @products = Product.joins(:brand).where( 'brands.name = ?', session[:brands_filter])
      else
        if session[:brands_filter].nil?
          @products = Product.joins(:section).where( 'sections.name = ?', session[:sections_filter])
        else
          @products = Product.joins(:section,:brand).where( 'sections.name = ? AND brands.name = ?', session[:sections_filter],session[:brands_filter])
        end
      end
    end
  end
  
  def promotion
    @products_promo = Product.where('promotion' => true)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @contact = Contact.new
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end  

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:title, :description, :price, :min_price, :part_number, :photo, :offer_price, :offer, :promotion, :brand_id, :section_id,
    :images_attributes => [:id,:url,:use,:image])
  end
end
