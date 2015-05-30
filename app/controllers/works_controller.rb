class WorksController < ApplicationController
  before_action :confirm_logged_in, except: [:index, :show]

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
    @pictures = @work.pictures.sorted
  end

  def edit
    @work = Work.find(params[:id])
    @work_count = Work.count
    @pictures = @work.pictures.sorted
    @picture_count = @work.pictures.count + 1
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

  def add_picture
    @work = Work.find params[:id]
    @picture = Picture.new(picture_params)
    if @picture.save
      flash[:notice] = "New Picture added!"
      redirect_to action: :edit
    else
      flash[:notice] = "Add new picture failed!"
      redirect_to action: :edit
    end
  end

  def update_picture
    @picture = Picture.find params[:picture][:id]
    if @picture.update_attributes(picture_params)
      flash[:notice] = "Picture updated!"
      redirect_to action: :edit
    else
      flash[:notice] = "Update picture failed!"
      redirect_to action: :edit
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

    def picture_params
      params.require(:picture).permit(:id, :file, :position, :work_id, :visible)
    end
end
