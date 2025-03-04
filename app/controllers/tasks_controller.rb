# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :load_task!, only: %i[show update destroy]

  def destroy
    @task.destroy!
    puts @task
    render_json
  end

  def index
    @tasks = Task.includes(:assigned_user).all
    render
  end

  def show
    render
  end

  def create
    task = Task.new(task_params)
    task.save!
    render_notice(t("successfully_created", entity: "Task"))
  end

  def update
    @task.update!(task_params)
    render_notice(t("successfully_updated"), entity: "Task")
  end

  private

    def load_task!
      @task = Task.find_by!(slug: params[:slug])
    end

    def task_params
      params.require(:task).permit(:title, :assigned_user_id)
    end
end
