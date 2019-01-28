class TasksController < ApplicationController
  before_action :update_time, only: [:index, :time_remaining]
  # create new instance of the task
#==================================== INDEX / GET ==============================
  def index
    active_task
    completed_task
  end

  def delete_tasks
    active_task
    completed_task
    @error = false
  end

  def active
    active_task
  end

  def completed
    completed_task
  end

  def time_remaining
    @task_today = Task.where("status != ? AND due_date == ?", "Completed", Date.today)
    @task_tomorrow = Task.where("status != ? AND due_date == ?", "Completed", Date.today + 1)
    @task_week = Task.where("status != ? AND due_date <= ? AND due_Date > ?", "Completed", Date.today + 1.week, Date.today + 1)
    @task_month = Task.where("status != ? AND due_date <= ? AND due_date > ? ", "Completed", Date.today + 1.month, Date.today + 1.week)
    @task_upcoming = Task.where("status != ? AND due_date > ?", "Completed", Date.today + 1.month)
    @task_overdue = Task.where("status != ? AND due_date < ?", "Completed", Date.today)
    @no_deadlines = Task.where("status != ? AND (due_date IS NULL)", "Completed")
  end


#=============================== GET / POST / CREATE ===========================

  def new
    @task = Task.new
  end

  def create
    #create a new instance
    @task = Task.new(task_params)
    update_position(@task)
    update_time_left(@task)
    validate_params(@task, @task, "new")

    #redirect_to @task
  end

#=============================== PATCH / EDIT / UPDATE =========================

  def show
    find_task
  end

  def edit
    find_task
  end

  def update
    find_task

    if @task.update(task_params)
      update_position(@task)
      update_time_left(@task)
      redirect_to @task
    else
      render 'edit'
    end
  end

  def update_status
    find_task
    if @task.status == "In Progress"
      @task.update(:status => "Awaiting Reply", :position => 1)
    elsif @task.status == "Awaiting Reply"
      @task.update(:status => "Pending", :position => 1)
    elsif @task.status == "Pending"
      @task.update(:status => "Completed", :position => 1)
    end
    # respond_to do |format|
    #   format.js
    # end
  end

  def update_time
    Task.all.each do |t|
      unless t.due_date.blank?
        t.time_left = (t.due_date - Date.today).numerator
        t.save
      end
    end
  end

  def complete_task
    find_task
    if @task.status != "Completed"
      update_status_to_completed(@task)
    respond_to do |format|
      format.js
    end
  end
  end

  def bookmark_task
    find_task
    if @task.color.empty?
      @task.update(:color => "#FFD662")
    else
      @task.update(:color => "")
    end
  end

  def sort
    params[:task].each_with_index do |id, index|
      Task.where(id: id).update_all({position:index + 1})
    end
    head :ok
  end

#================================= DESTROY / DELETE ============================

  def destroy
    find_task
    @task.destroy
  end

  def destroy_multiple
    if params[:t].blank?
      active_task
      completed_task
      if Task.all.blank?
      else
        @error = true
      end
      render 'delete_tasks'
    else
      Task.destroy(params[:t])
      respond_to do |format|
        format.html { redirect_to delete_tasks_tasks_path }
        format.json { head :no_content }
      end
    end
  end

#====================================== HELPER =================================

private

#------------------------------------ VALIDATIONS ------------------------------
  def task_params
    params.require(:task).permit(:title, :description, :status, :color, :due_date)
  end

  def validate_params(task, url, form)
    if task.save
      redirect_to url
    else
      render form
    end
  end


  #--------------------------------------- FIND ----------------------------------

  def find_task
   @task  = Task.find(params[:id])
  end

  def find_task_status(s)
    return Task.where(status: s).order("position","updated_at DESC")
  end

  def active_task
   @task_inprogress = find_task_status("In Progress")
   @task_awaitingreply = find_task_status("Awaiting Reply")
   @task_pending = find_task_status("Pending")
  end

  def completed_task
     @task_completed = find_task_status("Completed")
  end

#-------------------------------------- UPDATE ---------------------------------
  def update_position(task)
    task.update(:position => 1)
  end

  def update_time_left(task)
    unless task.due_date.blank?
      task.update(:time_left => (task.due_date - Date.today).numerator)
    end
  end

  def update_status_to_completed(task)
    task.update(:status => "Completed")
  end
end
