class LabTimesController < ApplicationController

  def new
  end


  #Shows the lab times. 
  def view_lab_times
    id = params[:format]
    @labs = LabTime.where(course_id: id)
  end

  #Creates lab times for a given section and stores them in the LabTime table.  
  #Because of the way the html was written this was the nicest way to write this function.
  #Not very complicated, but a bit long. 
  def create
    #Get everything from the view
    @course_id = params[:new_lab_time][:course_id]
  	@monday_start_time_hour = params[:new_lab_time][:monday_start_time_hour]
    @monday_start_time_minute = params[:new_lab_time][:monday_start_time_minute]
    @monday_start_time_period = params[:new_lab_time][:monday_start_time_period]
    @monday_end_time_hour = params[:new_lab_time][:monday_end_time_hour]
    @monday_end_time_minute = params[:new_lab_time][:monday_end_time_minute]
    @monday_end_time_period = params[:new_lab_time][:monday_end_time_period]

  	@tuesday_start_time_hour = params[:new_lab_time][:tuesday_start_time_hour]
    @tuesday_start_time_minute = params[:new_lab_time][:tuesday_start_time_minute]
    @tuesday_start_time_period = params[:new_lab_time][:tuesday_start_time_period]
    @tuesday_end_time_hour = params[:new_lab_time][:tuesday_end_time_hour]
    @tuesday_end_time_minute = params[:new_lab_time][:tuesday_end_time_minute]
    @tuesday_end_time_period = params[:new_lab_time][:tuesday_end_time_period]

    @wednesday_start_time_hour = params[:new_lab_time][:wednesday_start_time_hour]
    @wednesday_start_time_minute = params[:new_lab_time][:wednesday_start_time_minute]
    @wednesday_start_time_period = params[:new_lab_time][:wednesday_start_time_period]
    @wednesday_end_time_hour = params[:new_lab_time][:wednesday_end_time_hour]
    @wednesday_end_time_minute = params[:new_lab_time][:wednesday_end_time_minute]
    @wednesday_end_time_period = params[:new_lab_time][:wednesday_end_time_period]

    @thursday_start_time_hour = params[:new_lab_time][:thursday_start_time_hour]
    @thursday_start_time_minute = params[:new_lab_time][:thursday_start_time_minute]
    @thuerday_start_time_period = params[:new_lab_time][:thursday_start_time_period]
    @thursday_end_time_hour = params[:new_lab_time][:thursday_end_time_hour]
    @thursday_end_time_minute = params[:new_lab_time][:thursday_end_time_minute]
    @thuerday_end_time_period = params[:new_lab_time][:thursday_end_time_period]

    @friday_start_time_hour = params[:new_lab_time][:friday_start_time_hour]
    @friday_start_time_minute = params[:new_lab_time][:friday_start_time_minute]
    @friday_start_time_period = params[:new_lab_time][:friday_start_time_period]
    @friday_end_time_hour = params[:new_lab_time][:friday_end_time_hour]
    @friday_end_time_minute = params[:new_lab_time][:friday_end_time_minute]
    @friday_end_time_period = params[:new_lab_time][:friday_end_time_period]

    #Monday interval
    if(@monday_start_time_hour != nil)
      if(@monday_start_time_period == 'pm')
        @monday_start_time_hour = @monday_start_time_hour.to_i + 12
        @monday_start_time_hour = @monday_start_time_hour.to_s
      end
      if(@monday_end_time_period == 'pm')
        @monday_end_time_hour = @monday_end_time_hour.to_i + 12
        @monday_end_time_hour = @monday_end_time_hour.to_s
      end

      start_time = @monday_start_time_hour + ":" + @monday_start_time_minute + ":00"
      end_time = @monday_end_time_hour + ":" + @monday_end_time_minute + ":00"
      LabTime.create(course_id: @course_id, start_time: start_time, end_time: end_time, day: "monday")
    end

    #Tuesday interval
    if(@tuesday_start_time_hour != nil)
      if(@tuesday_start_time_period == 'pm')
        @tuesday_start_time_hour = @tuesday_start_time_hour.to_i + 12
        @tuesday_start_time_hour = @tuesday_start_time_hour.to_s
      end
      if(@tuesday_end_time_period == 'pm')
        @tuesday_end_time_hour = @tuesday_end_time_hour.to_i + 12
        @tuesday_end_time_hour = @tuesday_end_time_hour.to_s
      end

      start_time = @tuesday_start_time_hour + ":" + @tuesday_start_time_minute + ":00"
      end_time = @tuesday_end_time_hour + ":" + @tuesday_end_time_minute + ":00"
      LabTime.create(course_id: @course_id, start_time: start_time, end_time: end_time, day: "tuesday")
    end

    #Wednesday interval
    if(@wednesday_start_time_hour != nil)
      if(@wednesday_start_time_period == 'pm')
        @wednesday_start_time_hour = @wednesday_start_time_hour.to_i + 12
        @wednesday_start_time_hour = @wednesday_start_time_hour.to_s
      end
      if(@wednesday_end_time_period == 'pm')
        @wednesday_end_time_hour = @wednesday_end_time_hour.to_i + 12
        @wednesday_end_time_hour = @wednesday_end_time_hour.to_s
      end

      start_time = @wednesday_start_time_hour + ":" + @wednesday_start_time_minute + ":00"
      end_time = @wednesday_end_time_hour + ":" + @wednesday_end_time_minute + ":00"
      LabTime.create(course_id: @course_id, start_time: start_time, end_time: end_time, day: "wednesday")
    end

    #Thursday interval
    if(@thursday_start_time_hour != nil)
      if(@thursday_start_time_period == 'pm')
        @thursday_start_time_hour = @thursday_start_time_hour.to_i + 12
        @thursday_start_time_hour = @thursday_start_time_hour.to_s
      end
      if(@thursday_end_time_period == 'pm')
        @thursday_end_time_hour = @thursday_end_time_hour.to_i + 12
        @thursday_end_time_hour = @thursday_end_time_hour.to_s
      end

      start_time = @thursday_start_time_hour + ":" + @thursday_start_time_minute + ":00"
      end_time = @thursday_end_time_hour + ":" + @thursday_end_time_minute + ":00"
      LabTime.create(course_id: @course_id, start_time: start_time, end_time: end_time, day: "thursday")
    end

    #Friday interval
    if(@friday_start_time_hour != nil)
      if(@friday_start_time_period == 'pm')
        @friday_start_time_hour = @friday_start_time_hour.to_i + 12
        @friday_start_time_hour = @friday_start_time_hour.to_s
      end
      if(@friday_end_time_period == 'pm')
        @friday_end_time_hour = @friday_end_time_hour.to_i + 12
        @friday_end_time_hour = @friday_end_time_hour.to_s
      end

      start_time = @friday_start_time_hour + ":" + @friday_start_time_minute + ":00"
      end_time = @friday_end_time_hour + ":" + @friday_end_time_minute + ":00"
      LabTime.create(course_id: @course_id, start_time: start_time, end_time: end_time, day: "friday")
    end


  	redirect_to home_url
  end
end
