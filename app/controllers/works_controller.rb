class WorksController < ApplicationController
  def new
    @work = Work.new
    @work_count = Work.count + 1
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:notice] = "New Work #{@work.name} created!"
      redirect_to action: :index
    else
      flash[:notice] = "Create new work failed!"
      redirect_to action: :new
    end
  end

  def index
    @works = Work.visible.sorted
  end

  def manage
    @works = Work.sorted
    @work_count = Work.count
  end

  def show
    @work = Work.find(params[:id])
  end

  def edit
    @work = Work.find(params[:id])
    @work_count = Work.count
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
      redirect_to action: :manage
    else
      flash[:notice] = "Work: #{@work.name} update failed!"
      redirect_to action: :manage
    end
  end

  def delete
  end

  def destroy
  end

  private
    def work_params
      params.require(:work).permit(:name, :thumbnail, :position, :visible, :description)
    end
end
