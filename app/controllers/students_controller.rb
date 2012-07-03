class StudentsController < ApplicationController
  before_filter :signed_in_user
  
  def new
    @student = Student.new
  end
  
  def create
  end
  
  def display_form
  end
  
  def addstudents
    @classroom = Classroom.find(params[:id])
    (1..@classroom.num_students).each do |t|
      @classroom.students.build(params["student #{t}"])
    end
    if @classroom.save
      is_pin_path = false
      for student in @classroom.students
        if student.pin
          is_pin_path = true
          break
        end
      end
      if is_pin_path
        redirect_to display_form_pin_path(@classroom.id)
      else
        redirect_to results_path(@classroom.id)
      end
    else
      render 'new'
    end
  end
  
  def add_pin_table
    @classroom = Classroom.find(params[:id])
    for student in @classroom.students
      if student.pin
        pin_table = Integer(params["#{student.name}"])
        student[:pinned_table] = pin_table
        student.save
      end
    end
    if @classroom.save
      redirect_to results_path(@classroom.id)
    else
      render 'new'
    end
  end
end
