class VotesController < ApplicationController
  before_action :authenticate_user

  def create
    @vote = Vote.new(user_id: params[:user_id], article_id: params[:article_id])
    if @vote.save
      redirect_to category_path(Article.find(params[:article_id]).category_id)
    end
  end

  def destroy
    @vote = Vote.find_by(user_id: params[:user_id], article_id: params[:article_id])
    @vote.destroy
    redirect_to category_path(Article.find(params[:article_id]).category_id)
  end
end
