class LessonsController < ApplicationController
  before_action :load_category, except: [:show]

  def create
    check_finish = false
    Lesson.transaction do
      @lesson = Lesson.new lesson_params
      @lesson.save
      if @lesson.results.size() < Settings.take_num_lesson
        raise ActiveRecord::Rollback
      else
        check_finish = true
      end
    end
    unless check_finish
      flash[:danger] = t :problem_create_lesson
      redirect_to root_path
    else
      redirect_to @lesson
    end
  end

  def show
    @lesson = Lesson.find_by id: params[:id]
    @results = @lesson.results
    if @lesson.nil?
      flash[:danger] = t :lesson_invalid
      redirect_to root_path
    end
  end

  private
  def load_category
    @category = Category.find_by id: lesson_params[:category_id]
    if @category.nil?
      flash[:danger] = t :not_exist_category
      redirect_to categories_path
    end
  end

  def lesson_params
    params.require(:lesson).permit :category_id, :is_completed, :user_id
  end
end
