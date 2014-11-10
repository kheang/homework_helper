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
      format.js do
        if @problem.save
          if request.referrer == problems_url
            render :create, status: :created
          else
            redirect_to @problem, notice: 'Problem was successfully created.'
          end
        else
          render :new
        end
      end

      format.html do
        if @problem.save
          if request.referrer == problems_url
            redirect_to problems_path, notice: 'Problem was successfully created.'
          else
            redirect_to @problem, notice: 'Problem was successfully created.'
          end
        else
          render :new
        end
      end
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
    if @problem.destroy
      redirect_to problems_url, notice: 'Problem was successfully destroyed.'
    end
  end

  def close
    respond_to do |format|

      format.html do
        if @problem.update(resolved: true)
          redirect_to @problem, success: 'Problem has been closed and removed from the open problems list.'
        end
      end

      format.js do
        if @problem.update(resolved: true)
          render :resolve
        end
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
