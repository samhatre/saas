class ContactsController < ApplicationController
    def new
       @contact = Contact.new 
    end
    
    def create
        @contact =Contact.new(contact_params)
        
        if @contact.save
            name = params[:contact][:name] #"contact"=>{"name"=>"test1","email"=>"","comments"=>""}
            email = params[:contact][:email]
            body = params[:contact][:comments]
#calling ContactMailer file and contact_email method inside the mailer file and passing the arguments as we are passing to the action#            
            ContactMailer.contact_email(name,email,body).deliver
            flash[:success] = "Message Sent"
           redirect_to new_contact_path
       else
           flash[:notice] = "Error occoured"
           redirect_to new_contact_path
        end
    end
    
    private
    def contact_params
       params.require(:contact).permit(:name, :email,:comment) 
    end
    
end
