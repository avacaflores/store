class BrandsController < ApplicationController
  
  skip_before_action :authorize, only: [:add_filter, :remove_filter, :remove_all_filters]
  
  before_action :set_brand, only: [:show, :edit, :update, :destroy, :add_filter]

  # GET /brands
  # GET /brands.json
  def index
    @brands = Brand.all
  end

  # GET /brands/1
  # GET /brands/1.json
  def show
  end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit
  end

  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html { redirect_to @brand, notice: t('.message') }
        format.json { render action: 'show', status: :created, location: @brand }
      else
        format.html { render action: 'new' }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1
  # PATCH/PUT /brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand, notice: t('.message') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    linked_count = Product.where(brand_id: @brand.id).count
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to brands_url, flash: { warning: "#{linked_count} product(s) not linked to a brand." }}
      format.json { head :no_content }
    end
  end
  
  def add_filter
    session[:brands_filter] ||= []
    session[:brands_filter] << @brand.name unless session[:brands_filter].include?(@brand.name)
    redirect_to products_path 
  end
  
  def remove_filter
    @brand = Brand.find_by(name: params[:name])
    session[:brands_filter].delete(@brand.name)
    session[:brands_filter] = nil unless session[:brands_filter].count > 0
    redirect_to products_path
  end
  
  def remove_all_filters
    session[:brands_filter] = nil
    redirect_to products_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brand_params
      params.require(:brand).permit(:name, :product_id, :photo)
    end
end
