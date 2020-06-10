class WorksController < ApplicationController

  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def show
    if @work.nil?
      render_not_found
      return
    end
  end

  def create 
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      @errors = @work.errors
      flash.now[:error] = "An error occurred: Unable to create #{@work.category}"
      render :new, status: :bad_request
    end
  end

  def edit
    if @work.nil?
      render_not_found
      return
    end
  end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path
    else
      flash.now[:error] = "A problem occurred: Could not update #{@work.category}"
      render :edit, status: :bad_request
    end
  end

  def destroy
    votes = Vote.where(work_id: @work.id)
    votes.destroy_all
    @work.destroy
    flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
    redirect_to root_path
    return
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to root_path
    end
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description )
  end

end
