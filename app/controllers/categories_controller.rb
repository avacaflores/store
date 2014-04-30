class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /Categories
  # GET /Categories.json
  def index
    @categories = Category.all
  end

  # GET /Categories/1
  # GET /Categories/1.json
  def show
  end

  # GET /Categories/new
  def new
    @Category = Category.new
  end

  # GET /Categories/1/edit
  def edit
  end

  # POST /Categories
  # POST /Categories.json
  def create
    @Category = Category.new(Category_params)

    respond_to do |format|
      if @Category.save
        format.html { redirect_to @Category, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @Category }
      else
        format.html { render action: 'new' }
        format.json { render json: @Category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Categories/1
  # PATCH/PUT /Categories/1.json
  def update
    respond_to do |format|
      if @Category.update(Category_params)
        format.html { redirect_to @Category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @Category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Categories/1
  # DELETE /Categories/1.json
  def destroy
    @Category.destroy
    respond_to do |format|
      format.html { redirect_to Categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_Category
      @Category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def Category_params
      params.require(:Category).permit(:name)
    end
end
