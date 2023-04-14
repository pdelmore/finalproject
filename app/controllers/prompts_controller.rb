class PromptsController < ApplicationController


  def index
    matching_prompts = Prompt.all
    list_of_prompts = matching_prompts.order({ :created_at => :desc })
    @user_prompts = list_of_prompts.where({ :user_id => @current_user.id })

    render({ :template => "prompts/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_prompts = Prompt.where({ :id => the_id })

    @prompt = matching_prompts.at(0)

    render({ :template => "prompts/show.html.erb" })
  end

  def create
    a_prompt = Prompt.new
    a_prompt.topic = params.fetch("query_topic")
    a_prompt.user_id = @current_user.id

    if a_prompt.valid?
      a_prompt.save

      system_message = Chat.new
      system_message.prompt_id = a_prompt.id
      system_message.role = "system"
      system_message.content = "You are a licensed massage therapist with a lot of experience that helps the user come up with a basic massage session plan for their patient. Ask any follow up questions that you may need. Make sure that there are no contraindications to perform the massage, such as medication taken, conditions or ilnesses (list them) and create a plan for the massage session today and a long-term plan. Also include any take-home exercises or self-care tips that you think are needed. Make sure to tell the user that you're only giving general recommendations and that you're not giving a medical advice or treatment. Keep your advice shorter than 500 words."
      system_message.save

      user_message = Chat.new
      user_message.prompt_id = a_prompt.id
      user_message.role = "user"
      user_message.content = "Can you help me create a massage session plan for my patient? This all the information about them: #{a_prompt.topic}"
      user_message.save

      client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

      api_messages_array = Array.new

      prompt_messages = Chat.where({ :prompt_id => a_prompt.id }).order(:created_at)

      prompt_messages.each do |the_message|
        message_hash = { :role => the_message.role, :content => the_message.content }

        api_messages_array.push(message_hash)
      end

      response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo",
            messages: api_messages_array,
            temperature: 1.0,
        }
      )

      assistant_message = Chat.new
      assistant_message.prompt_id = a_prompt.id
      assistant_message.role = "assistant"
      assistant_message.content = response.fetch("choices").at(0).fetch("message").fetch("content")
      assistant_message.save

      redirect_to("/prompts/#{a_prompt.id}", { :notice => "Prompt created successfully." })
    else
      redirect_to("/prompts", { :alert => a_prompt.errors.full_messages.to_sentence })
    end
  end






end
