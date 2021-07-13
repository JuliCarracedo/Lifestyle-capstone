class CategoriesController < ApplicationController
  before_action :authenticate_user

  # GET /categories or /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1 or /categories/1.json
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @articles = @category.articles.order('created_at DESC')
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update

  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

  end

  private
    def category_params
      params.require(:category).permit(:name, :priority)
    end
end
