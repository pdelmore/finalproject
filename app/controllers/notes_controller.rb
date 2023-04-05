class NotesController < ApplicationController
  NOTES_PER_PAGE = 10

  def index
    matching_notes = Note.all

    @list_of_notes = matching_notes.order({ :date => :desc })

    # set params, default to 0
    # set pagination
    # number of notes, to float because needs to divide later
    # divide page_number by notes_per_page, round, to integer

    @page = params.fetch(:page, 0).to_i

    @list_of_notes_paginated = @list_of_notes.limit(NOTES_PER_PAGE).offset(@page * NOTES_PER_PAGE)

    number_of_notes = Note.count 
    number_of_pages_float = number_of_notes.to_f
    page_number_float = number_of_pages_float / NOTES_PER_PAGE
    pg_n_rounded = page_number_float.floor.to_i
    @last_page = pg_n_rounded - 1

    render({ :template => "notes/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_notes = Note.where({ :id => the_id })

    @the_note = matching_notes.at(0)

    render({ :template => "notes/show.html.erb" })
  end

  def create
    the_note = Note.new
    the_note.body = params.fetch("query_body")
    the_note.patient_id = params.fetch("query_patient_id")
    the_note.user_id = params.fetch("query_user_id")
    the_note.service_id = params.fetch("query_service_id")
    the_note.date = params.fetch("query_date")
    the_note.time = params.fetch("query_time")

    if the_note.valid?
      the_note.save
      redirect_to("/notes", { :notice => "Note created successfully." })
    else
      redirect_to("/notes", { :alert => the_note.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_note = Note.where({ :id => the_id }).at(0)

    the_note.body = params.fetch("query_body")
    the_note.patient_id = params.fetch("query_patient_id")
    the_note.user_id = params.fetch("query_user_id")
    the_note.service_id = params.fetch("query_service_id")
    the_note.date = params.fetch("query_date")
    the_note.time = params.fetch("query_time")

    if the_note.valid?
      the_note.save
      redirect_to("/notes/#{the_note.id}", { :notice => "Note updated successfully."} )
    else
      redirect_to("/notes/#{the_note.id}", { :alert => the_note.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_note = Note.where({ :id => the_id }).at(0)

    the_note.destroy

    redirect_to("/notes", { :notice => "Note deleted successfully."} )
  end

  def calendar
    @all_monthly_patients = Note.where(
      date: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week,
    )

    @matching_calendar_patients = @all_monthly_patients.where({ :user_id => @current_user.id })

    render({ :template => "notes/my_calendar.html.erb" })
  end
end
