class CategoriesController < ApplicationController
  before_action :authenticate_user

  # GET /categories/1 or /categories/1.json
  def show
    @categories = Category.order(:priority)
    @category = Category.find(params[:id])
    @articles = @category.articles.order('created_at DESC')
  end

  private

  def category_params
    params.require(:category).permit(:name, :priority)
  end
end
