class PublicController < ApplicationController
  layout 'public'

  before_action :find_work, only: [:show, :show_process]
  before_action :set_og_tag_site_name
  before_action :hit_count

  def about
    @og_title = "About Moyu Zhang"
    @og_type = 'profile'
    @og_url = about_url
    @og_image = view_context.asset_url('moyuzhang.jpg')
    @og_description = 'About Moyu Zhang'
    @paragraph = AboutParagraph.first
  end

  def contact
    @og_title = "Contact Moyu Zhang"
    @og_type = 'profile'
    @og_url = contact_url
    @og_image = view_context.asset_url('contact.jpg')
    @og_description = 'Contact Moyu Zhang'
  end

  def index
    @works = Work.visible.sorted
    @og_title = "Moyu Zhang Design"
    @og_type = 'website'
    @og_url = root_url
    @og_image = "http://moyuzhang.com/system/works/thumbnails/000/000/022/thumb/Dance_No.2_thumbnail_copy.jpg?1434254667"
    @og_description = 'Works of Moyu Zhang'
  end

  def show
    unless @work.visible
      redirect_to action: :index
    end
    @pictures = @work.pictures.sorted
    @process_picture_count = @work.process_pictures.count
  end

  def show_process
    unless @work.visible
      redirect_to action: :index
    end
    @pictures = @work.process_pictures.sorted
    render 'show'
  end

  private
  def find_work
    @work = Work.find(params[:id])
    set_og_tags(@work)
  end

  def set_og_tags(work)
    @og_title = work.name + " by Moyu Zhang"
    @og_type = 'article'
    @og_url = work_url(@work)
    @og_image = URI.join(request.url, work.thumbnail.url(:thumb))
    @og_description = work.description
  end

  def set_og_tag_site_name
    @og_site_name = 'Moyu Zhang Design'
  end

  def hit_count
    #Admin users
    if session[:admin]
      #get_hit_counts
      return
    end

    #Guests
    unless session[:visited]
      session[:visited] = 0
      # add a unique visit count
      add_unique_hit
    end

    name = page_name
    unless cookies[name]
      cookies[name] = { value: true, expires: 1.hour.from_now }
      session[:visited] += 1
      add_hit name
      add_hit 'all'
    end
  end

  def add_unique_hit
    hit = HitCount.find_by_cat('unique')
    if hit
      hit.hits += 1
      hit.save
    else
      hit = HitCount.create(cat: 'unique', hits: 1)
    end
  end

  def add_hit(name)
    hit = HitCount.find_by_cat(name)
    if hit
      hit.hits += 1
      hit.save
    else
      hit = HitCount.create(cat: name, hits: 1)
    end
  end

end
