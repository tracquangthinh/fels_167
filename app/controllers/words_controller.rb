class WordsController < ApplicationController
  include WordsHelper

  def index
    @category = Category.find_by id: params[:category_id]
    if @category.nil?
      flash[:danger] = t :empty_category
      redirect_to categories_path
    else
      @previous_category = previous_category @category.id
      @next_category = next_category @category.id
      @words = length_part_list @category 
    end
  end
end
