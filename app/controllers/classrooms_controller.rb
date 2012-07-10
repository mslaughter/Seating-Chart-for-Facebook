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
    @classroom.results = {}
    puts "students: #{@classroom.students}"
    (1..@classroom.iterations).each do |i|
      available_students = []
      for s in @classroom.students
        available_students.push(s.name)
      end
      
      puts "Available students: #{available_students}"
      
      for student in @classroom.students
        if student.pin
          @classroom.tables.find_by_name(student.pinned_table).students = "#{student.name} "
          puts "Table #{@classroom.tables.find_by_name(student.pinned_table).name} - #{@classroom.tables.find_by_name(student.pinned_table).students}"
          available_students.delete(student.name)
        end
      end
      
      available_students.shuffle!
      for t in @classroom.tables
        puts "students of table #{t.name}: #{t.students}"
        if t.students.blank?
          t.students = "#{available_students[0]} "
          available_students.delete(available_students[0])
          puts "Table: #{t.name}, student: #{t.students}"
        end
      end
      
      
      for t in @classroom.tables
        while (t.max_students > t.students.count(" "))
          if (available_students.length <= 0)
            break
            
          else
            for s in available_students
              random_num = rand
              prob = 1.0
              for student in t.students.split(" ")
                x = 1.0
                people_sat_next_to = @classroom.students.find_by_name(s).students_sat_next_to.split(" ")
                for person in people_sat_next_to
                  if person == student
                    x *= 2
                  end
                end
                prob *= (1/(2**x))
              end
              
              if (random_num <= prob)
                t.students += "#{s} "
                available_students.delete(s)
                break
              end
            end
          end
          
          for student in t.students.split(" ")
            for s in t.students.split(" ")
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
#      @classroom.results[i] = table_hash

      @rotation = @classroom.rotations.create(name:i)

      for table in @classroom.tables
        new_table = table.dup()
        new_table.classroom_id = nil
        new_table.rotation_id = @rotation.id
        new_table.save
        table.students = ""
        table.save
      end

      @rotation.save
#      puts "Rotation: #{@rotation.name}"
#      puts "Rotation tables: #{@rotation.tables}"
      
    end
    
#    @classroom.results.slice!(0)
    
    if @classroom.save
#      puts "\nResults:\n#{@classroom.results}\n"
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