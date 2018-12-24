class TasksController < ApplicationController
  # create new instance of the task
  def index
    @task = Task.order("position")
  end

  def new
    @task = Task.new
  end

  def create
    #create a new instance
    @task = Task.new(task_params)
    @task.save

    #redirect to url
    redirect_to @task
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

end

private
 def task_params
   params.require(:task).permit(:title, :description, :status)
 end

 def find_task
   @task  = Task.find(params[:id])
   return @task
 end
