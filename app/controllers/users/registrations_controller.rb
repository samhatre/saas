class Users::RegistrationsController < Devise::RegistrationsController
   
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
  
end