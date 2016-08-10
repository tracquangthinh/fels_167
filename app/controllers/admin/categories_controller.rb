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

  def destroy
    ids = params[:category_ids].nil? ? params[:id] : params[:category_ids]
    @categories = Category.find ids
    if @categories.nil?
      flash[:danger] = t :must_select
    else
      if Category.destroy @categories
        flash[:success] = t :delete_success
      else
        flash[:danger] = t :not_delete
      end
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
