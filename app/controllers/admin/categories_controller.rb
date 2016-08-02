class Admin::CategoriesController < ApplicationController
  before_action :verify_admin
  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.per_page
  end
end
