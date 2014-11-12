class ProblemsController < ApplicationController
  before_action :authenticate, only: [:new, :create, :close]
  before_action :set_problem, only: [:show, :close]

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

  def close
    respond_to do |format|
      return unless @problem.update(resolved: true)
      format.html { redirect_to @problem, success: 'Problem was closed.' }
      format.js { render :resolve }
    end
  end

  private

  def set_problem
    @problem = Problem.find(params[:id])
  end

  def problem_params
    params.require(:problem).permit(:issue, :try, :screen)
  end
end
