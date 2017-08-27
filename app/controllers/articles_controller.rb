require 'amazon/ecs'

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit update destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    res = Amazon::Ecs.item_lookup(params[:article][:asin], country: 'de')
    item = res.get_element('Item')
    item_attributes = item&.get_element('ItemAttributes')
    title = item_attributes&.get('Title')

    if title.present? && Article.create(asin: params[:article][:asin], name: title)
      flash[:success] = 'Artikel erstellt.'
      redirect_to articles_path
    else
      flash[:danger] = 'Fehler beim Erstellen.'
      @article = Article.new
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @article.destroy

    redirect_to articles_path
  end

  def search
    res = Amazon::Ecs.item_search(params[:str], country: 'de')

    @results = res.total_results
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:asin)
  end
end
