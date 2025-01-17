class MessagesController < ApplicationController
  def index
    matching_messages = Message.all

    @list_of_messages = matching_messages.order({ :created_at => :desc })

    @messages = Message.where("sender_id = ? OR recipient_id = ?", @current_user.id, @current_user.id).order(:created_at)
    @threads = @messages.group_by { |message| [message.sender_id, message.recipient_id].sort }
    

    render({ :template => "messages/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_messages = Message.where({ :id => the_id })

    @the_message = matching_messages.at(0)

    render({ :template => "messages/show.html.erb" })
  end

  def create
    the_message = Message.new
    the_message.sender_id = @current_user.id
    the_message.recipient_id = params.fetch("query_recipient_id")
    the_message.body = params.fetch("query_body")

    if the_message.valid?
      the_message.save
      redirect_to("/messages", { :notice => "Message created successfully." })
    else
      redirect_to("/messages", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    the_message.sender_id = params.fetch("query_sender_id")
    the_message.recipient_id = params.fetch("query_recipient_id")
    the_message.body = params.fetch("query_body")

    if the_message.valid?
      the_message.save
      redirect_to("/messages/#{the_message.id}", { :notice => "Message updated successfully."} )
    else
      redirect_to("/messages/#{the_message.id}", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    the_message.destroy

    redirect_to("/messages", { :notice => "Message deleted successfully."} )
  end



  def contactus


render teplate: 'messages/contactus.html.erb'
  end
end
