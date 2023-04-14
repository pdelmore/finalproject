class ChatsController < ApplicationController

  def create
    the_message = Chat.new
    the_message.prompt_id = params.fetch("query_prompt_id")
    the_message.role = params.fetch("query_role")
    the_message.content = params.fetch("query_content")

    if the_message.valid?
      the_message.save

      the_prompt = Prompt.where({ :id => the_message.prompt_id }).at(0)

      client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

      api_messages_array = Array.new

      prompt_messages = Chat.where({ :prompt_id => the_prompt.id }).order(:created_at)

      prompt_messages.each do |the_message|
        message_hash = { :role => the_message.role, :content => the_message.content }

        api_messages_array.push(message_hash)
      end

      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: api_messages_array,
          temperature: 1.0,
        },
      )

      assistant_message = Chat.new
      assistant_message.prompt_id = the_message.prompt_id
      assistant_message.role = "assistant"
      assistant_message.content = response.fetch("choices").at(0).fetch("message").fetch("content")
      assistant_message.save

      redirect_to("/prompts/#{the_message.prompt_id}", { :notice => "Message created successfully." })
    else
      redirect_to("/prompts/#{the_message.prompt_id}", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end


end
