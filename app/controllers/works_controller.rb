class WorksController < ApplicationController
  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:notice] = "New Work #{@work.name} created!"
      redirect_to action: :index
    else
      flash[:error] = "Create new work failed!"
      redirect_to action: :new
    end
  end

  def index
    @works = Work.visible.sorted
  end

  def show
    @work = Work.find(params[:id])
  end

  def edit
    @work = Work.find(params[:id])
  end

  def udpate
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
