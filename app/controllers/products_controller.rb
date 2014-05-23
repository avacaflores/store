class ProductsController < ApplicationController
  
  skip_before_action :authorize, only: [:index, :show, :promotion, :clear_search, :clear_tag, :clear_brand]
  
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @sections = Section.all.order(:name)
    @brands = Brand.all.order(:name)
    @products_promo = Product.promotion.paginate(page: params[:page]).order(:title)
    
    @products = Product.order(:title).paginate(page: params[:page])
    
    if params[:tag].present?
      session[:tag_filter] ||= []
      session[:tag_filter] = params[:tag]
    else
      params[:tag] = session[:tag_filter] if session[:tag_filter]
    end
    
    if params[:brand].present?
      session[:brand_filter] ||= []
      session[:brand_filter] = params[:brand]
    else
      params[:brand] = session[:brand_filter] if session[:brand_filter]
    end
    
    if params[:search].present?
      session[:search_filter] ||= []
      session[:search_filter] = params[:search]
    else
      params[:search] = session[:search_filter] if session[:search_filter]
    end
    

    
    @products = @products.tagged_with(params[:tag]).paginate(page: params[:page]) if params[:tag].present?
    @products = @products.brandname(params[:brand]).paginate(page: params[:page]) if params[:brand].present?
    @products = @products.search(params[:search]).paginate(page: params[:page]) if params[:search].present?
    
  end

  def clear_brand
    params[:brand] = nil
    session[:brand_filter] = nil
    redirect_to products_path(search: params[:search],tag: params[:tag])
  end  
  
  def clear_search
    params[:search] = nil
    session[:search_filter] = nil
    redirect_to products_path(search: params[:search],tag: params[:tag])
  end  
  
  def clear_tag
    params[:tag] = nil
    session[:tag_filter] = nil
    redirect_to products_path(search: params[:search],tag: params[:tag])
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
    params.require(:product).permit(:title, :description, :link_product, :price, :min_price, :part_number, :photo, :offer_price, :offer, :promotion, :brand_id, :section_id, :tag_list, :tag,
    :images_attributes => [:id,:url,:use,:image])
  end
end
