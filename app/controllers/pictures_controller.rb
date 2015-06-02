class PicturesController < ApplicationController
  layout 'admin'
  
  before_action :confirm_logged_in

  def create
    @picture = Picture.new(picture_params)
    @picture.work_id = params[:work_id]
    if @picture.save
      flash[:notice] = "New Picture added!"
      redirect_to work_pictures_path params[:work_id]
    else
      flash[:notice] = "Add new picture failed!"
      redirect_to work_pictures_path params[:work_id]
    end
  end

  def index
    @work = Work.find(params[:work_id])
    @new_picture = @work.pictures.build
    @pictures = @work.pictures.sorted
    @picture_count = @pictures.count + 1
  end

  def update
    @picture = Picture.find params[:id]
    if @picture.update_attributes(picture_params)
      flash[:notice] = "Picture updated!"
      redirect_to work_pictures_path params[:work_id]
    else
      flash[:notice] = "Update picture failed!"
      redirect_to work_pictures_path params[:work_id]
    end
  end

  def delete
    @picture = Picture.find params[:id]
  end

  def destroy
    @picture = Picture.find params[:id]
    flash[:notice] = "Picture #{@picture.file_file_name} deleted!"
    @picture.destroy
    redirect_to work_pictures_path params[:work_id]
  end

  private
    def picture_params
      params.require(:picture).permit(:id, :file, :position)
    end
end
