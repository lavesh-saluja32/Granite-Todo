# frozen_string_literal: true

class TasksController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  before_action :load_task!, only: %i[show update destroy]

  def destroy
    authorize @task
    @task.destroy!
    puts @task
    render_json
  end

  def index
    @tasks = policy_scope(Task).includes(:assigned_user)
    render
  end

  def show
    authorize @task
  end

  def create
    task = current_user.created_tasks.new(task_params)
    authorize task
    task.save!
    render_notice(t("successfully_created", entity: "Task"))
  end

  def update
    authorize @task
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
