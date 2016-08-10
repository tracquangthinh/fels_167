class LessonsController < ApplicationController
  before_action :load_category, except: [:show, :index]

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
    @category = @lesson.category
    @results = @lesson.results
    if @lesson.nil?
      flash[:danger] = t :lesson_invalid
      redirect_to root_path
    end
  end

  def index
    @category = Category.find_by id: params[:category_id]
    if @category.nil?
      flash[:danger] = t :not_exist_category
      redirect_to root_path
    else
      @total_lessons = current_user.lesson.select{
        |x| x.category_id == @category.id}
      @num_lesson = @total_lessons.size()
      @lessons = @total_lessons.paginate page: params[:page],
        per_page: Settings.per_page
    end
  end

  def update
    if params[:commit] == Settings.check_finish
      @lesson = Lesson.find_by id: params[:id]
      unless @lesson.nil?
        @lesson.update is_completed: true,
          results_attributes: results_attributes(@lesson)
        flash[:success] = t :lesson
        redirect_to result_path(@lesson.id)
      end
    else
      redirect_to category_lessons_path category_id: @category.id
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

  def results_attributes lesson
    results = lesson.results
    attribute = []
    results.each do |r|
      value = {id: r.id, word_answer_id: params[r.id.to_s].to_i}
      attribute.push value
    end
    return attribute
  end
end
