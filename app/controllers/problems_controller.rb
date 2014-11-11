class ProblemsController < ApplicationController
  before_action :authenticate, only: [:new, :create, :destroy, :close, :update]
  before_action :set_problem, only: [:show, :update, :destroy, :close]

  def index
    @problems = Problem.where(resolved: false).order('created_at DESC')
    @problem = Problem.new
  end

  def show
    @notes = @problem.notes
    @note = Note.new
  end

  def new
    @problem = Problem.new
  end

  def create
    @problem = current_user.problems.build(problem_params)

    respond_to do |format|
      if @problem.save
        format.html { redirect_to @problem, notice: 'Problem was created.' }
        format.js { render :create, status: :created }
      else
        format.all { render :new }
      end
    end
  end

  def update
    if @problem.update(problem_params)
      redirect_to @problem, notice: 'Problem was updated.'
    else
      render :edit
    end
  end

  def destroy
    return unless @problem.destroy
    redirect_to problems_url, notice: 'Problem was destroyed.'
  end

  def close
    respond_to do |format|
      if @problem.update(resolved: true)
        format.html { redirect_to @problem, success: 'Problem was closed.' }
        format.js { render :resolve }
      end
    end
  end

  private

  def set_problem
    @problem = Problem.find(params[:id])
  end

  def problem_params
    params.require(:problem).permit(:issue, :try)
  end
end
