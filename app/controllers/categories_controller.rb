class CategoriesController < ApplicationController
  before_action :header_menu,only: [:index,:show]
  add_breadcrumb 'メルカリ', :root_path
  add_breadcrumb 'カテゴリー一覧', :categories_path

  def index
    @l_categories = Category.roots
  end

  def show
    @category = Category.find(params[:id])
    @child_categories = Category.children_of(@category).order("RAND()").limit(9)
    progeny_category = Category.subtree_of(@category)
    sold_item = Deal.pluck('item_id')
    @items = Item.includes(:category).where(categories:{id:progeny_category.ids}).where.not(id:sold_item).order(id: :DESC)
    @category.ancestors.each do |category|
      add_breadcrumb category.name, :categories_path
    end
    add_breadcrumb @category.name, :category_path
  end
end
