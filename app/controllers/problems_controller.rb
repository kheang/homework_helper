class ProblemsController < ApplicationController
  before_action :authenticate, only: [:new, :create, :destroy]
  before_action :set_problem, only: [:show, :edit, :update, :destroy, :close]

  def index
    @problems = Problem.where(resolved: false).order('created_at DESC')
  end

  def show
  end

  def new
    @problem = Problem.new
  end

  def edit
  end

  def create
    @problem = Problem.new(problem_params)
    @problem.user = current_user

      if @problem.save
      redirect_to root_path, notice: 'Problem was successfully created.'
      else
         render :new
      end

  end

  def update
    if @problem.update(problem_params)
     redirect_to @problem, notice: 'Problem was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @problem.destroy
      redirect_to problems_url, notice: 'Problem was successfully destroyed.'
  end

  def close
    @problem.update(resolved: true)
    redirect_to @problem, success: "Problem has been closed and removed from the open problems list."
  end

  private

  def set_problem
    @problem = Problem.find(params[:id])
  end

  def problem_params
    params.require(:problem).permit(:issue, :try, :user_id)
  end

end
