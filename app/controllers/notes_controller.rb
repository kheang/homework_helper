class NotesController < ApplicationController
  before_action :authenticate
  before_action :set_note, only: [:destroy, :update]

  def index
    @notes = Note.all
  end
  def new
    @note = Note.new
  end
  def show
  end

  def create
    @problem = Problem.find(params[:problem_id])
    @note = @problem.notes.build(note_params)
    @note.user = current_user
    @note.save
    redirect_to problem_path(@problem)
  end

  def destroy
    if @note.destroy
      redirect_to @note.problem
    end
  end

  def update
    @note.toggle(:chosen)
    @note.save
    redirect_to @note.problem
  end

  private
    def note_params
      params.require(:note).permit(:user, :comment, :chosen, :name)
    end
  def set_note
		@note = Note.find(params["id"])
  end

end
