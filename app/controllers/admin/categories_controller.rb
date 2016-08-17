class Admin::CategoriesController < ApplicationController
  include Admin::CategoriesHelper
  before_action :verify_admin

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.per_page
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    respond_to do |format|
      if @category.save
        format.json {render json: to_json(@category)}
      end
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
