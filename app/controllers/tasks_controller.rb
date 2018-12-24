class TasksController < ApplicationController
  # create new instance of the task

  def index
    # @task.order("position")
    @task = custom_order

  end

  def completed
    @task = Task.where(status:"Completed").order("position")
  end

  def active
    @task_inprogress = find_task_status("In Progress")
    @task_awaitingreply = find_task_status("Awaiting Reply")
    @task_pending = find_task_status("Pending")
  end

  def new
    @task = Task.new
  end

  def create
    #create a new instance
    @task = Task.new(task_params)
    @task.save

      redirect_to @task
  end

  def complete_task
    @task = find_task
    if @task.status == "Completed"
      redirect_to request.referrer, :alert => "Task already completed!"
    else
      @task.status = "Completed"
      @task.save
      redirect_to request.referrer
    end
  end

  def show
    find_task
  end

  def edit
    find_task
  end

  def update
    find_task
    @task.update(task_params)


    redirect_to @task
  end

  def destroy
    find_task.destroy

    redirect_to tasks_path
  end

  def sort
    params[:task].each_with_index do |id, index|
      Task.where(id: id).update_all({position:index + 1})
    end

    head :ok

  end

  def delete_multiple

    Task.destroy(params[:tasks])

    redirect_to tasks_path

  end

  def update_status
    @task = find_task
    if @task.status == "In Progress"

      @task.update(:status => "Awaiting Reply")
      redirect_to request.referrer
    elsif @task.status == "Awaiting Reply"
      @task.update(:status => "Pending")
      redirect_to request.referrer
    elsif @task.status == "Pending"
      @task.update(:status => "Completed")
      redirect_to request.referrer
    else
      redirect_to request.referrer, :alert => "Task already completed!"
    end
  end

private
 def task_params
   params.require(:task).permit(:title, :description, :status)
 end

 def find_task
   @task  = Task.find(params[:id])
   return @task
 end

 def find_task_status(s)
   return Task.where(status: s).order("position")
 end

 def custom_order
   @arr = []
   @arr_with_status = ["In Progress", "Awaiting Reply", "Pending", "Completed"]

   def push_into_array(v)
     v.each do |p|
       @arr.push(p)
    end
  end

   @arr_with_status.map{|a| push_into_array(find_task_status(a))}

   return @arr
 end
end
