class NotesController < ApplicationController
  before_action :authenticate
  before_action :set_note, only: [:choose]
  before_action :set_problem, only: [:create]

  def index
    @notes = Note.all
  end

  def create
    @note = current_user.notes.build(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @problem, success: 'Note created.' }
        format.js { render :create, status: :created }
      else
        format.html { redirect_to @problem }
        format.js { render nothing: true, status: :bad_request }
      end
    end
  end

  def choose
    @problem = @note.problem

    if @note.update(chosen: true) && @problem.update(resolved: true)
      redirect_to @problem, success: 'Problem has been closed.'
    else
      redirect_to @problem
    end
  end

  private

  def note_params
    note_params = params.require(:note).permit(:comment, :chosen)
    note_params[:problem_id] = @problem[:id]
    note_params
  end

  def set_note
    @note = Note.find(params['id'])
  end

  def set_problem
    @problem = Problem.find(params[:problem_id])
  end
end
