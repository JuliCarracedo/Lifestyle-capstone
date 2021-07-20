class CategorizationController < ApplicationController
  def create
    Categorization.create(article_id: params[:article_id],
                          category_id: params[:category_id])
    flash[:notice] = "Added article to #{Category.find(params[:category_id]).name}"
    article = Article.find(params[:article_id])
    article.update(image: select_image(params[:category_id].to_i))
    redirect_to article_path(params[:article_id])
  end

  def destroy
    to_delete = Categorization.find_by(article_id: params[:article_id], category_id: params[:category_id])
    to_delete.destroy
    flash[:notice] = "Removed article from #{Category.find(params[:category_id]).name}"
    redirect_to article_path(params[:article_id])
  end

  private

  def select_image(id)
    case id
    when 1
      'entertainment_bg.jpeg'
    when 2
      'tech_bg.jpeg'
    when 3
      'daily_bg.jpeg'
    when 4
      'politics_bg.jpeg'
    when 5
      'arts_bg.jpg'
    when 6
      'sports_bg.jpg'
    end
  end
end
