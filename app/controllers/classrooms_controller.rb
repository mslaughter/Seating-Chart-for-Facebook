class ClassroomsController < ApplicationController 
  before_filter :signed_in_user
  
  def new
    @classroom = Classroom.new
  end
  
  def create
    @classroom = current_user.classrooms.build(params[:classroom])
    if @classroom.save
      redirect_to tables_display_form_path(@classroom.id)
    else
      render 'new'
    end
  end
  
  def index
  end
  
  def destroy
    Classroom.find(params[:id]).destroy
    flash[:success] = "Classroom destroyed."
    redirect_to classrooms_path
  end
  
  def results
    @classroom = Classroom.find(params[:id])
    puts "Parameters: #{params}\n"
    @classroom.results = {}
    (1..@classroom.iterations).each do |i|
#      @classroom.results += "!#{i}!"
      table_hash = {}
      available_students = []
      for t in @classroom.tables
        table_hash[t.name] = []
      end
      for s in @classroom.students
        available_students.push(s.name)
      end
      
      for student in @classroom.students
        if student.pin
          table_hash[student.pinned_table] = [student.name]
          available_students.delete(student.name)
        end
      end
      
      available_students.shuffle!
      for t in table_hash.keys()
        if table_hash[t].length < 1
          table_hash[t] = [available_students[0]]
          available_students.delete(available_students[0])
        end
      end
      
      for t in table_hash.keys()
        while (@classroom.tables.find_by_name(t).max_students > table_hash[t].length)
          if (available_students.length <= 0)
            break
            
          else
            for s in available_students
              random_num = rand
              prob = 1.0
              for student in table_hash[t]
                x = 1.0
                people_sat_next_to = @classroom.students.find_by_name(s).students_sat_next_to.split(" ")
                for person in people_sat_next_to
                  if person == student
                    x *= 2
                  end
                end
                prob *= (1/(10**x))
              end
              
              if (random_num <= prob)
                table_hash[t].push(s)
                available_students.delete(s)
                break
              end
            end
          end
          
          for student in table_hash[t]
            for s in table_hash[t]
              if student != s
                @classroom.students.find_by_name(student).students_sat_next_to += "#{s} "
              end
            end
            @classroom.students.find_by_name(student).save
          end
        end
      end
      
      
#      temp_str = ""
#      for t in table_hash.keys()
#        temp_str += ":#{t}:"
#        for s in table_hash[t]
#          temp_str += "#{s}."
#        end
#        temp_str.slice!(-1)
#      end
#      temp_str.slice!(0)
#      @classroom.results += temp_str
      @classroom.results[i] = table_hash
    end
#    @classroom.results.slice!(0)
#    puts "\n\n#{@classroom.results}\n"
#    if @classroom.save
#      redirect_to display_classroom_path(@classroom.id)
#    end
    if @classroom.save
      puts "\nResults:\n#{@classroom.results}\n"
      redirect_to display_classroom_path(@classroom.id)
    end
  end
  
  def show
    @classroom = Classroom.find(params[:id])
#    @results_hash = convert_string_to_hash(@classroom.results)
  end
  
  private
    
    def convert_string_to_hash(string)
      final_hash = {}
      temp_array = string.split("!")
      temp_hash = {}
      for i in (0..(temp_array.length - 1))
        if i%2 != 0
          temp_array[i] = temp_array[i].split(":")
          for j in (0..(temp_array[i].length - 1))
            if j%2 != 0
              temp_array[i][j] = temp_array[i][j].split(".")
              temp_hash[temp_array[i][j-1]] = temp_array[i][j]
            end
          end
          final_hash[temp_array[i-1]] = temp_hash
          temp_hash = {}
        end
      end
      return final_hash
    end
end