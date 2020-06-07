module TimeUtil
  def new_datetime(date, time)
    (date + time.seconds_since_midnight.seconds).to_datetime 
  end
end
