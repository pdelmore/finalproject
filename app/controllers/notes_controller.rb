class NotesController < ApplicationController
  # NOTES_PER_PAGE = 10


  def index
    matching_notes = Note.all

    @list_of_notes = matching_notes.order({ :date => :desc })

    
    @notes = @list_of_notes.paginate(page: params[:page], per_page: 20)

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
    the_note.user_id = @current_user.id
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
    # the_id = params.fetch("path_id")
    # the_note = Note.where({ :id => the_id }).at(0)

    # the_note.body = params.fetch("query_body")
    # the_note.patient_id = params.fetch("query_patient_id")
    # the_note.user_id = @current_user.id
    # the_note.service_id = params.fetch("query_service_id")
    # the_note.date = params.fetch("query_date")
    # the_note.time = params.fetch("query_time")

    the_id = params.fetch("path_id")

    the_note = Note.where({ :id => the_id }).at(0)

    body = params.fetch("query_body")
    the_note.body = body

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


def chatbot

render({ :template => "notes/chatbot.html.erb" })
end



def gpt
  Rails.logger.debug("gpt action called")
  conversation_history = params[:prompt]


  require "openai"
  

  # The fun part

  client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

  openai_client = OpenAI::Client.new(
    access_token: ENV.fetch("OPENAI_KEY"),
  )

  response = openai_client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: [
        { role: "system", content: "You are a licensed massage therapist with a lot of experience that helps the user, less experienced massage therapist, to come up with a basic massage session plan for their massage sessions.
        Make sure that there are no contraindications to perform the massage, such as medication taken or conditions (list them) and create a plan for the massage session today and a long-term plan. Also include any take-home exercises or self-care tips that you think are needed. Make sure to tell the user that you're only giving general recommendations and that you're not giving a medical advice or treatment. Keep your advice shorter than 500 words. The user's patient is the one getting a massage, not the user themselves." },
        { role: "user", content: conversation_history },
      ],
      temperature: 0.8,
    },
  )


  if response.respond_to?(:choices) && response.choices.present?
    @result = response.choices[0].text.strip
  else
    @result = "Sorry, I could not generate a response. Please try again."
    Rails.logger.error("OpenAI API error: #{response.inspect}")
  end



  @result = response.fetch("choices").at(0).fetch("message").fetch("content")

  render({ :template => "notes/chatbot_response.html.erb" })
end

end
