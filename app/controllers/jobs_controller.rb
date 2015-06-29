class JobsController < ApplicationController

	before_action :set_job, only: [:show, :edit, :update, :destroy]

	def index
		if params[:category]
			category_id = Category.where(name: params[:category])
			@jobs = Job.where(category_id: category_id)
		else
			@jobs = Job.all
		end
	end

	def new
		@job = Job.new
	end

	def show

	end

	def edit
		
	end

	def create
		@job = Job.new(job_params)
		respond_to do |format|
			if @job.save
				format.html {redirect_to @job, notice: 'Job posted'}
			else
				format.html {render 'new', alert: "Sorry something unexpected happened"}
			end
		end
	end

	def update
		respond_to do |format|
			if @job.update_attributes(job_params)
				#flash[:success] = "Job post updated"
				format.html {redirect_to @job, notice: 'Job updated'}
			else
				format.html {render 'edit', alert: "Sorry something unexpected happened"}
			end
		end
	end

	def destroy
		if @job.destroy
			redirect_to jobs_path, notice: 'Your Job post is deleted'
		end
	end

	private

	def job_params
		params[:job].permit(:title, :company, :description, :salary, :category_id)
	end

	def set_job
		@job = Job.find(params[:id])
	end

end
