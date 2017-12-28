class GraderApplicationController < ApplicationController

  #Creates new entries in both the schedule table (which saves a bunch of intervals based on check boxes)
  # and in the application table. 
  def create
    if logged_in?
      if current_user.role != "instructor"
        @semester =  params[:schedule][:semester]
        # We have all of the new entries we want to add, we can literally just dump any row in the 
        #table cooresponding to the user and semester.  This is what the below two lines do:
        Schedule.where(user_id: @id_good, semester_id: @semester).destroy_all
        Application.where(user_id: current_user, semester_id: @semester).destroy_all
        #Adds selected courses to application (now that we cleared out the old entries)
        @course_names = params[:schedule][:course_names]
        @course_selected = params[:schedule][:course_selected]
        @course_names = match_box_to_title!(@course_selected, @course_names)
        save_course_to_application(@course_names)
        #Intervals to schedule
        #The maximum possible number of intervals that can be in db for a user is 120 given current setup.
        @monday =  params[:schedule][:monday_time]
      	@monday = compute_times!(@monday, 15)
      	save_intervals_to_schedule(@monday, 0)

      	@tuesday =  params[:schedule][:tuesday_time]
      	@tuesday = compute_times!(@tuesday, 15)
        save_intervals_to_schedule(@tuesday, 1)

      	@wednesday =  params[:schedule][:wednesday_time]
      	@wednesday = compute_times!(@wednesday, 15)
        save_intervals_to_schedule(@wednesday, 2)

      	@thursday =  params[:schedule][:thursday_time]
      	@thursday = compute_times!(@thursday, 15)
        save_intervals_to_schedule(@thursday, 3)

      	@friday =  params[:schedule][:friday_time]
      	@friday = compute_times!(@friday, 15)
        save_intervals_to_schedule(@friday, 4)
        redirect_to home_url
      else
        redirect_to access_denied_url
      end
    else
      redirect_to root_url
    end
  end

  #Used generating the correct courses and schedule intervals.
  #The tricky part about this method is how semester is handled.  We pass semester from the view
  #generated by new, get it to the point where it is only a semester ID and then pass it in a hidden
  #field to create, this serves two purposes.  Semester allows us to generate the correct courses
  # here at new2, and also when passed on as a semester_id, can be used to create the correct entries
  # in the table.
  def new2
    #Take semester and get the correct ID
    @semester = params[:new2][:semester]
    arr = @semester.split
    @semester = Semester.find_by_semester_and_year(arr[0], arr[1]).id
    #Now that we have that... (by the way, instructors cannot grade for courses, sorry prof.)
    if logged_in?
      if current_user.role != "instructor"
        #Get the application the user has already applied for.  This will allow us to generate
        #the correct boxes to go back into the form.  
        @app_list = Application.where(user_id: current_user, semester_id: @semester)
        @id_good = current_user
        #Like above, but for schedule.  We do these queries for the sole purpose of repopulating
        #the check boxes in the view.  This means they can add things or edit them in a single form.
        @ready_intervals_pre = Schedule.where(user_id: current_user, semester_id: @semester)
        #The below method is kind of where the magic happens.  This gets us an array or arrays
        #for each day that determines the tmes the user already checked.
        @ready_intervals = convert_intervals_to_booleans_by_day(@ready_intervals_pre, 15)
        #For mapping t othe correct intervals:
        @hour = 8                 #hour in military time
        @minute = 0
        @minute_interval_length = 15    #must be < 60
        @number_of_hours = 12
        @number_of_minute_intervals = @number_of_hours * (60/@minute_interval_length)
        render 'grader_application/new2'
      else
      redirect_to access_denied_url
      end
    else
    redirect_to root_url
    end
  end

  def new
  end

  #Used by the admin to see all of the users who have submitted an application for a given semester.
  def view_applications
    if(params[:application_viewer] != nil)
      @semester = params[:application_viewer][:semester]
      arr = @semester.split
      @semester = Semester.find_by_semester_and_year(arr[0], arr[1])
    end
    if(@semester == nil)
      @semester = Semester.first
    end
    @users_with_apps = []
    users = User.all
    users.each do |user|
      if(Application.find_by(user_id: user.id, semester_id: @semester) != nil)
        @users_with_apps << user
      end
    end
  end

  #See a specific application for one user.  (selected from view_applications view)
  def view_application
    @user = User.find(params[:format])
    @applications = Application.where(user_id: @user.id)
    @schedules = Schedule.where(user_id: @user.id)
    end
  end

  #The useful functions for this class.
  private
  #Where the intervals from the database go to become a 2d array of booleans to repopulate
  #the checkboxes on the new 2 view.
  def convert_intervals_to_booleans_by_day(intervals, delta)
    #The nice thing about having a delta value is that we can change the interval times. 
    total_interval_number = (20 - 8)*(60/delta)
    #This just "flips" an array around, that is, transpose[0] = 8:00, transpose[1] = 8:15...
    transpose = convert_delta_to_transpose(total_interval_number, delta)
    #Make a bunch of empty arrays, one for each day since that is how they are laid out in the view.
    monday_bools = []
    tuesday_bools = []
    wednesday_bools = []
    thursday_bools = []
    friday_bools = []
    #For each check box we assume false by default i.e. no check boxes are selected.
    total_interval_number.times do |i|
      monday_bools[i] = false
      tuesday_bools[i] = false
      wednesday_bools[i] = false
      thursday_bools[i] = false
      friday_bools[i] = false
  end
    #We go through the intervals, and where ever we have a run we modify the array 
    #to make the booleans go from false to true. See below for better explanation. 
    intervals.each do |interval|
      if(interval.day == 'monday')
        convert_interval_add_to_bool_array!(interval, transpose, monday_bools, delta)
      end
      if(interval.day == 'tuesday')
        convert_interval_add_to_bool_array!(interval, transpose, tuesday_bools, delta)
      end
      if(interval.day == 'wednesday')
        convert_interval_add_to_bool_array!(interval, transpose, wednesday_bools, delta)
      end
      if(interval.day == 'thursday')
        convert_interval_add_to_bool_array!(interval, transpose, thursday_bools, delta)
      end
      if(interval.day == 'friday')
        convert_interval_add_to_bool_array!(interval, transpose, friday_bools, delta)
      end
    end
    return [monday_bools, tuesday_bools, wednesday_bools, thursday_bools, friday_bools]
  end

  #Just flips the array, as  Imentioned earlier.  Returns an array of times going up by the delta
  #Bascially ensures a bijection between each check box and an interval.  
  def convert_delta_to_transpose(total_interval_number, delta)
    transpose = []
    bools = []
    breaker = 0
    total_interval_number.times do |i|
      val = i*delta
      if val >= 60
        val = val % 60
      end
      if i % (60/delta) == 0 && i != 0
        breaker += 100
      end
      transpose[i] = 800+val+breaker
    end
    return transpose
  end

  #We can use the transpose to determine where an interval starts and which box it correspondes to
  #This could have also been done doing a map, but I prefer arrays.  I think they would have been
  #equally unclear.  
  def convert_interval_add_to_bool_array!(interval, transpose, bools, delta)
    #Takes intervals that are stored in ways beyond my understanding and turns them into easy to use ints.
    start_time = (interval.start_time.to_s.split(' '))[1]
    start_time.slice!(2)
    start_time = (start_time.split(':'))[0]
    start_time = start_time.to_i
    end_time = (interval.end_time.to_s.split(' '))[1]
    end_time.slice!(2)
    end_time = (end_time.split(':'))[0]
    end_time = end_time.to_i
    end_time = end_time - delta
    #Need to deal with the fact that hours do not have 100 minutes, but 60.  Cruel world.
    if((end_time % 100) >= 60)
      end_time = end_time - 40
    end

    #Where we determine if there is a "Run" of booleans from the interval
    #One nice thing about checking true, writing then checking false is that this deals with
    #single 15 minute blocks.  I hope nobody ever selects a single 15 minute block, that would
    #be useless, but you never know.
    found_range = false
    transpose.each_with_index do |value, index|
      if(start_time == value)
        found_range = true
      end
      if(found_range)
        bools[index] = true
      end
      if(end_time == value)
        found_range = false
      end
    end
    return bools
  end

  # Saves an application.
  def save_course_to_application(course_names)
    id = current_user.id
    course_names.each do |course_name|
      Application.create(user_id: id, semester_id: @semester, course_number: course_name)
    end
  end

  #Used for figuring out which checked boxes correpsonde to which courses.
  #Because they are both generated, we need a function like this one. 
  def match_box_to_title!(selected, titles)
    titles_of_selected = []
    selected.each_with_index do |checked, index|
      if(checked.to_i == 1)
        selected.delete_at(index - 1)
      end
    end
    selected.each_index do |i|
      selected[i] = selected[i].to_i
    end

    selected.each_with_index do |select, index|
      if(select == 1)
        titles_of_selected << titles[index]
      end
    end

    return titles_of_selected
  end

  #Saves an interval for a user to the schedule.
  def save_intervals_to_schedule(intervals, day_of_week)
    id = current_user.id
  	intervals.each do |interval|
  		Schedule.create(user_id: id, day: day_of_week, start_time: interval[0], end_time: interval[1], semester_id: @semester)
  	end
  end

  #To avoid errors, check boxes with a value of checked pass a 0,1.  Not a 1. 
  #To fix this, we just delete the o before each 1.  This gets everything realigned.
  def adjust_time_array!(day)
  	day.each_with_index do |checked, index|
  		if(checked.to_i == 1)
  			day.delete_at(index - 1)
  		end
  	end
  	day.each_index do |i|
  		day[i] = day[i].to_i
  	end
  end

  #Goes from a bunch of check boxes to intervals that can be stored in the database.  Maybe
  #a bit difficult to understand due to delta, which allows for different time intervals.
  #Note that delta is always minutes.
  def compute_times!(day, delta)
  	adjust_time_array!(day)
  	intervals = []
  	adjusted_time = []
  	creating_interval = false
  	start_time = ''

  	(day.length+1).times do |i|
  		if(i == 0)
        #We always start at 8:00am by convention.
  			adjusted_time[i] = '08:00'
  		else
  			temp_time = (adjusted_time[i-1].tr(':','').to_i)+delta
  			if(temp_time % 100 >= 60)
  				temp_time+=40
  			end
  			temp_str = temp_time.to_s
  			if(temp_time < 1000)
  				temp_str = '0' + temp_str
  			end
  			adjusted_time[i] = temp_str.insert(2, ':')
  		end
  	end

  	day.each_with_index do |checked, i|
  		if(checked == 1)
  			if(!creating_interval)
  				start_time = adjusted_time[i]
  				creating_interval = true
  				if(i == day.length-1)
  					intervals.append([adjusted_time[i], adjusted_time[i+1]])
  				end
  			else
  				if(i == day.length-1)
  					end_time = adjusted_time[i+1]
  					interval = [start_time, end_time]
  					intervals.append(interval)
  				end
  			end
  		else
  			if(creating_interval)
  				end_time = adjusted_time[i]
  				interval = [start_time, end_time]
  				intervals.append(interval)
  				creating_interval = false
  			end
  		end
  	end

  	return intervals
  end

