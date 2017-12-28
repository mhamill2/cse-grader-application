Rails.application.routes.draw do


  # Login, Logout, & Signup routes
  root 'sessions#index'
  get 'login' => 'sessions#index'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'signup' => 'users#new'

  # User routes
  get 'home' => 'users#home'
  get 'user_list' => 'users#user_list'
  get 'manage_semesters' => 'semesters#manage_semesters'
  get 'access_denied' => 'users#access_denied'
  delete 'user' => 'users#destroy'
  get 'user' => 'users#show'
  get 'request' => 'requests#show'
  get 'recommendation' => 'recommendations#new'
  get 'view_recommendation' => 'recommendations#show'
  get 'add_grader' => 'grades_fors#new'
  get 'add_admin' => 'users#add_admin'
  post 'add_admin' => 'users#create_admin'
  delete 'grades_for' => 'grades_fors#destroy'
  post 'user_list' => 'users#user_list'
  post 'course_list' => 'courses#course_list'
  get 'view_recommendations' => 'recommendations#view_recommendations'
  get 'view_requests' => 'requests#view_requests'
  get 'view_applications' => 'grader_application#view_applications'
  post 'view_applications' => 'grader_application#view_applications'
  get 'account_settings' => 'users#edit'
  patch 'user.:id' => 'users#update'
  get 'submit_evaluation' => 'users#grader_evaluation'
  get 'view_application' => 'grader_application#view_application'
  get 'view_lab_time' => 'lab_times#view_lab_times'

  #Course routes
  get 'course_list' => 'courses#course_list'
  get 'add_course' => 'courses#new'
  get 'courses' => 'courses#new'
  get 'add_lab_time' => 'lab_times#new'

  #Request routes
  get 'request_grader' => 'requests#new'

  #Recommendation routes
  get 'recommendations' => 'recommendations#new'
  
  # Grader Application routes
  get 'grader_application' => 'grader_application#new'
  get 'grader_application_2' => 'grader_application#new2'
  get 'new2' => 'grader_application#new2'
  post 'schedule' => 'grader_application#create'
  post 'new2' => 'grader_application#new2'

  #Semester routes
  post 'semester' => 'semesters#create' 
  delete 'semester' => 'semesters#destroy'


  resources :users, except: 'edit'
  resources :courses
  resources :recommendations
  resources :requests
  resources :semesters
  resources :lab_times
  resources :grades_fors


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
