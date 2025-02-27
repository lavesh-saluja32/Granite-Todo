# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    tasks = Task.all
    render status: :ok, json: { tasks: }
  end

  def show
    task = Task.find_by(slug: params[:slug])
    render status: :ok, json: { task: }
  end
end
