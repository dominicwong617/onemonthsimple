class BenefitFormsController < ApplicationController
  DIR = "public/docs/"
  HEALTH_FILE = "Health_n_Stuff.pdf"
  DENTAL_FILE = "Dental_n_Stuff.pdf"
  FILES = [ "#{DIR}#{HEALTH_FILE}", "#{DIR}#{DENTAL_FILE}" ]

  def index
    @benefits = Benefits.new
  end

  def download
    begin
      if FILES.include?(params[:name]) && params[:type] == "File"
        path = Rails.root.join('public', 'docs', params[:name].split('/')[2])
      else
        path = Rails.root.join('public', 'docs', DENTAL_FILE)
      end

      send_file File.new(path), :disposition => 'attachment'
    rescue
      redirect_to user_benefit_forms_path(:user_id => current_user.user_id)
    end
  end

  def upload
    file = params[:benefits][:upload]
    if file
      flash[:success] = "File Successfully Uploaded!"
      Benefits.save(file, params[:benefits][:backup])
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to user_benefit_forms_path(:user_id => current_user.user_id)
  end
end
