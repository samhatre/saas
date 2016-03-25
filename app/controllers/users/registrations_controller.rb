class Users::RegistrationsController < Devise::RegistrationsController
 # use before_filter so as to avoid url updation  
   before_filter :select_plan, only: :new
   
   def create
     super do |resource|
       if params[:plan]  # checking which plan is selected
          resource.plan_id = params[:plan] #storing that value in plan_id viz created in Users table i.e storing in db which plan the user is comming with
       if resource.plan_id ==2
           resource.save_with_payment
       else
           resource.save
       end
       end
      end   
   end
  private
  def select_plan
      #checks whether plan is either 1 or 2 else redirect to home page
    unless params[:plan] && (params[:plan] == '1' || params[:plan] == '2')
      flash[:notice] = "Please select a membership plan to sign up."
      redirect_to root_url
    end
  end
end