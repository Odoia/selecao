class Lecture

  def initialize
    $left_speeches = get_speeches(get_txt) 
  end

  def get_txt
    path  = File.expand_path("proposals.txt", 'speeches/')
    file  = File.open(path)
    txt_array = []

    while ! file.eof?
      txt_array << file.gets.chomp
    end
    
    file.close
    txt_array
  end

  def get_speeches(txt_array)
    speeches_array = []
    
    txt_array.each do |lecture|
      lecture_time = get_lecture_time(lecture)
      lecture_time.cycle(1) do |minutes| 
        speeches_array.push([lecture, minutes.to_i])   
      end        
    end
    speeches_array
  end

  def get_lecture_time(lecture)
    lecture.scan(/[0-9][0-9]/) == [] ? ["05"] : lecture.scan(/[0-9][0-9]/)
  end

  def organize_lectures
    turn_a_start = 540
    turn_b_start = 780
    duration_turn_morning   = 180
    duration_turn_afternoon = 240

    track_a_morning   = organize_speeches(duration_turn_morning)
    track_b_morning   = organize_speeches(duration_turn_morning)
    track_a_afternoon = organize_speeches(duration_turn_afternoon)
    track_b_afternoon = organize_speeches(duration_turn_afternoon)
   

    puts 'Track A'
    get_lunch(print_track(track_a_morning, turn_a_start))
    get_networking(print_track(track_a_afternoon, turn_b_start))
    puts 'Track B'
    get_lunch(print_track(track_b_morning, turn_a_start))
    get_networking(print_track(track_b_afternoon, turn_b_start))
  end

  def organize_speeches(duration)
    speeches_to_organize = []
    total_minutes        = 0
    current_speeches     = $left_speeches
    $left_speeches       = []

    current_speeches.each do |l|
      minutes_after_speeche = total_minutes + l[1]
      conditional = minutes_after_speeche <= duration   

      if duration == 180
        conditional = conditional && l[1] != 5
      end

      if conditional
        speeches_to_organize.push(l)
        total_minutes += l[1] 
      else
        $left_speeches.push(l)
      end
    end
    
    speeches_to_organize
  end

  def print_track(track, turn)
    current_time_in_minutes = turn
    track.each do |a|
      puts "#{conference_hour(current_time_in_minutes)} -> #{a[0]}"  
      current_time_in_minutes += a[1]
    end 
    current_time_in_minutes
  end

  def get_lunch(total_minutes)
    puts "#{conference_hour(total_minutes)} -> Lunch Time !!"
  end

  def get_networking(total_minutes)
    puts "#{conference_hour(total_minutes)} -> Networking Time !!"
  end

  def conference_hour(time)
    hour   = time/60
    minute = time.remainder 60

    "#{hour.to_s.rjust(2, '0')}:#{minute.to_s.rjust(2, '0')}" 
  end
end

l = Lecture.new
l.organize_lectures