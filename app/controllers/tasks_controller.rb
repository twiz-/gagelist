class TasksController < ApplicationController
  before_filter :find_list
  respond_to :html, :js

  def create
    @task = @list.tasks.new(params[:task])
    if @task.save
      flash[:notice] = "Task Created"
    else
      flash[:error] = "It just didn't happen for you"
    end

    respond_with @list
  end
  
  def complete
    @task = @list.tasks.find(params[:id])
    
    @task.update_attributes({ 
      completed: true
    })
        
    respond_with @list
  end
  
  def incomplete
    @task = @list.tasks.find(params[:id])
    @task.update_attributes({
      completed: false
    })
    respond_with @list
  end
  
  def destroy
    task = @list.tasks.find(params[:id])
    @task_id = task.id
    task.destroy
    
  end

  private

  def find_list
    @list = List.find(params[:list_id])
  end

end
