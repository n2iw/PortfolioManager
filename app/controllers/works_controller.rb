class WorksController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in

  def new
    @work = Work.new
    @work_count = Work.count + 1
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:notice] = "New Work #{@work.name} created!"
      redirect_to work_pictures_path(@work.id)
    else
      flash[:notice] = "Create new work failed!"
      redirect_to action: :new
    end
  end

  def index
    @works = Work.sorted
    @work_count = Work.count
  end

  def show
    @work = Work.find(params[:id])
    @pictures = @work.pictures.sorted
  end

  def edit
    @work = Work.find(params[:id])
    @work_count = Work.count
    @pictures = @work.pictures.sorted
  end

  def update
    @work = Work.find params[:id]

    if @work.update_attributes(work_params)
      flash[:notice] = "Work: #{@work.name} updated!"
      redirect_to action: :show
    else
      flash[:notice] = "Work: #{@work.name} update failed!"
      redirect_to action: :edit
    end
  end

  def update_position
    @work = Work.find params[:id]

    if @work.update_attributes(work_params)
      flash[:notice] = "Work: #{@work.name} updated!"
      redirect_to action: :index
    else
      flash[:notice] = "Work: #{@work.name} update failed!"
      redirect_to action: :index
    end
  end

  def delete
    @work = Work.find params[:id]
  end

  def destroy
    @work = Work.find params[:id]
    @work.destroy
    flash[:notice] = "Work: #{@work.name} deleted!"
    redirect_to action: :index
  end


  private
    def work_params
      params.require(:work).permit(:name, :thumbnail, :position, :visible, :description)
    end
end
