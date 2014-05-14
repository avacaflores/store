class ProductsController < ApplicationController
  
  skip_before_action :authorize, only: [:index, :show, :promotion]
  
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @sections = Section.all.order(:name)
    @brands = Brand.all.order(:id)
    @products_promo = Product.promotion.paginate(page: params[:page]).order(:title)
    
    if params[:tag]
      session[:brands_filter] = nil
      @products = Product.tagged_with(params[:tag]).paginate(page: params[:page]).order(:title)
    else
      if session[:brands_filter]
        @products = Product.brand(session[:brands_filter]).paginate(page: params[:page]).order(:title)
      else
        @products = Product.all.paginate(page: params[:page]).order(:title)
      end
    end
  end
    
  
  def promotion
    @products_promo = Product.promotion.paginate(page: params[:page]).order('title')
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
        format.html { redirect_to @product, notice: t('.message') }
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
        format.html { redirect_to @product, notice: t('.message') }
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
      format.html { redirect_to products_url, notice: t('.message') }
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
    params.require(:product).permit(:title, :description, :price, :min_price, :part_number, :photo, :offer_price, :offer, :promotion, :brand_id, :section_id, :tag_list, :tag,
    :images_attributes => [:id,:url,:use,:image])
  end
end
