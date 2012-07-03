class TablesController < ApplicationController
  before_filter :signed_in_user
  
  def new
    @table = Table.new
  end
  
  def create
  end
  
  def display_form
  end
  
  def addtables
    @classroom = Classroom.find(params[:id])
    (1..@classroom.num_tables).each do |t|
      params_max_students = Integer(params["table #{t}"][:max_students])
      puts "Table #{t}: #{params_max_students}"
      @classroom.tables.build(name:t, max_students:params_max_students)
    end
    if @classroom.save
      redirect_to students_display_form_path(@classroom.id)
    else
      render 'new'
    end
  end
end

