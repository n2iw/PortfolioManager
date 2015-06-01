module ApplicationHelper
  def error_messages_for(obj) 
    render(partial: 'application/error_messages', locals: {object: obj})
  end  
end
