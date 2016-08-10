class Admin::WordsController < ApplicationController
  include Admin::WordsHelper
  include WordsHelper
  before_action :load_category, only: [:index, :create]

  def index
    @words = @category.words.order(created_at: :desc).paginate page: 
      params[:page], per_page: Settings.per_page
    @previous_category = previous_category @category.id
    @next_category = next_category @category.id
    @word = Word.new
  end

  def create

    @word = @category.words.build word_params
    unless correct_answer.nil?
      @word.word_answers[correct_answer].is_correct = true
      if @word.save
        new_word = to_json @word, correct_answer
        respond_to do |format|      
          format.json {render json: new_word}
        end
      end
    end
  end

  private
  def word_params
    params.require(:word).permit :content,
      word_answers_attributes: [:content, :is_correct]
  end

  def load_category
    @category = Category.find_by id: params[:category_id]
    if @category.nil?
      flash[:danger] = t :not_exist_category
      redirect_to admin_categories_path
    end
  end

  def correct_answer
    params.require(:is_correct).to_i
  end
end
