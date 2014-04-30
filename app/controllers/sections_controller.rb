class SectionsController < ApplicationController
  
  skip_before_action :authorize, only: [:add_filter, :remove_filter, :remove_all_filters]
  
  before_action :set_section, only: [:show, :edit, :update, :destroy, :add_filter]

  # GET /sections
  # GET /sections.json
  def index
    @sections = Section.all.order(:name)
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(section_params)

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: 'Section was successfully created.' }
        format.json { render action: 'show', status: :created, location: @section }
      else
        format.html { render action: 'new' }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1
  # PATCH/PUT /sections/1.json
  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to @section, notice: 'Section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section.destroy
    respond_to do |format|
      format.html { redirect_to sections_url }
      format.json { head :no_content }
    end
  end
  
  def add_filter
    session[:sections_filter] ||= []
    session[:sections_filter] << @section.name unless session[:sections_filter].include?(@section.name)
    redirect_to products_path 
  end
  
  def remove_filter
    @section = Section.find_by(name: params[:name])
    session[:sections_filter].delete(@section.name)
    session[:sections_filter] = nil unless session[:sections_filter].count > 0
    redirect_to products_path
  end
  
  def remove_all_filters
    session[:sections_filter] = nil
    redirect_to products_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      params.require(:section).permit(:name, :product_id)
    end
end
