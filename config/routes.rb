Rails.application.routes.draw do

root "user_authentication#homepage"

get("/my_calendar", { :controller => "notes", :action => "calendar" })

get("/admin", { :controller => "user_authentication", :action => "admin" })

  # Routes for the Note resource:

  # CREATE
  post("/insert_note", { :controller => "notes", :action => "create" })
          
  # READ
  get("/notes", { :controller => "notes", :action => "index" })
  
  get("/notes/:path_id", { :controller => "notes", :action => "show" })
  
  # UPDATE
  
  post("/modify_note/:path_id", { :controller => "notes", :action => "update" })
  
  # DELETE
  get("/delete_note/:path_id", { :controller => "notes", :action => "destroy" })


  get("/new_note", { :controller => "notes", :action => "new" })

  #------------------------------

  # Routes for the Patient resource:

  # CREATE
  post("/insert_patient", { :controller => "patients", :action => "create" })
          
  # READ
  get("/patients", { :controller => "patients", :action => "index" })
  
  get("/patients/:path_id", { :controller => "patients", :action => "show" })

  get("/admin/patients", { :controller => "patients", :action => "admin" })

  get("/admin/patients/new", { :controller => "patients", :action => "admin_new" })
  
  # UPDATE
  
  post("/modify_patient/:path_id", { :controller => "patients", :action => "update" })
  
  # DELETE
  get("/delete_patient/:path_id", { :controller => "patients", :action => "destroy" })

  #------------------------------

  # Routes for the Service resource:

  # CREATE
  post("/insert_service", { :controller => "services", :action => "create" })
          
  # READ
  get("/services", { :controller => "services", :action => "index" })
  
  get("/services/:path_id", { :controller => "services", :action => "show" })
  
  # UPDATE
  
  post("/modify_service/:path_id", { :controller => "services", :action => "update" })
  
  # DELETE
  get("/delete_service/:path_id", { :controller => "services", :action => "destroy" })

  #------------------------------

  # Routes for the Message resource:

  # CREATE
  post("/insert_message", { :controller => "messages", :action => "create" })
          
  # READ
  get("/messages", { :controller => "messages", :action => "index" })
  
  get("/messages/:path_id", { :controller => "messages", :action => "show" })
  
  # UPDATE
  
  post("/modify_message/:path_id", { :controller => "messages", :action => "update" })
  
  # DELETE
  get("/delete_message/:path_id", { :controller => "messages", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  get("/delete_user", { :controller => "user_authentication", :action => "delete_user" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
