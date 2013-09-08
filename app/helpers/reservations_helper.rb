module ReservationsHelper

  def time_to_next_quarter_hour(time)
    array = time.split(':')
    minutes = array[1].split(' ')
    quarter = ((minutes[0].to_i % 60) / 15.0).ceil
    if quarter < 4
      mins = (quarter * 15) % 60
    elsif quarter == 4
      mins = "00"
      unless array[0] == 12
        array[0] = array[0].to_i + 1
      else
        array[0] = 1
      end
    end
    time = array[0].to_s.rjust(2, '0') + ":" + mins.to_s.rjust(2, '0') + " " + minutes[1].to_s
  end

end
