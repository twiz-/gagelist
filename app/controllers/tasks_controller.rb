class TasksController < ApplicationController
  before_filter :find_list, :except => [:sort]
  respond_to :html, :js

  def create
    @task = @list.tasks.new(params[:task])
    @task.save
       
=begin    
    if @task.save
      flash[:notice] = "Task Created"
    else
      flash[:error] = "It just didn't happen for you"
    end

    respond_with @list
=end    
  end
  
  def complete
    @task = @list.tasks.find(params[:id])
    
    @task.update_attributes({ 
      completed: true
    })
 
    @task.create_activity :complete, recipient: @list
  end
  
  def incomplete
    @task = @list.tasks.find(params[:id])
    @task.update_attributes({
      completed: false
    })
    respond_with @list
    @task.create_activity :uncomplete, recipient: @list
  end
  
  def destroy
    task = @list.tasks.find(params[:id])
    @task_id = task.id
    task.destroy
    
  end
  
  def sort
    logger = Logger.new('log/debug.log')
    logger.info('-----------Log for sort-----------')
    logger.info(params[:task].length)
    params[:task].each_with_index do |id, index|
      logger.info('id: ' + id.to_s + ' ' + index.to_s)
      Task.update_all(['position=?', index+1], ['id=?', id])
    end
  end

  private

  def find_list
    @list = List.find(params[:list_id])
  end
end
