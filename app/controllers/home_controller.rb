class HomeController < ApplicationController
 
  respond_to :json


  # List the all application/job on index page which posted by User 
  def index
    if $data.present?
      @data ||=  $data.get('/api/hr/v2/jobs.json?buyer_team__reference='+company_reference).read_body
    end
    if @data.present?
      @applications = get_hash(@data)["jobs"]["job"]
      respond_with(@applications)
    else
      respond_with(User.all)
    end
  end


  # it will show all applicants list which applied for particular contract or job
  def show_application
    if $data.present?
      @data ||=  $data.get('/api/hr/v3/clients/applications.json?job_key='+params[:id]+'&buyer_team__reference='+company_reference).read_body
    end
    if @data.present?
      @applicaiton = get_hash(@data)["applications"]
      respond_with(@applicaiton)
    else
      respond_with(User.all)
    end
  end

 
  # it show contractractor/ applicants detail 
  def show
    
    if $data.present?
      @data ||=  $data.get('/api/hr/v3/clients/applications/'+params[:id]+'.json?buyer_team__reference='+company_reference).read_body
    end

    if @data.present?
      @application = get_hash(@data)["application"]
      arr = []
      arr << @application
       respond_with(arr)
    end

  end

 # def destroy
    
  #  if $data.present?
  #     @data ||=  $data.get('/api/hr/v3/clients/applications.json?job_key='+params[:job_key]+'&buyer_team__reference='+company_reference).read_body
  #   end
  #   if @data.present?
  #     @applicaiton = get_hash(@data)["applications"]
  #     respond_with(@applicaiton)
  #   end
  # end

  private


  # return Company Reference id for access data
  def company_reference
     @company_data = $data.get('/api/hr/v2/companies.json').read_body
     @c_ref = JSON.parse(@company_data)["companies"].first["reference"]
     return @c_ref
  end

  # it convert the Data in Json format for showing them.
  def get_hash(data)
     @hash_data = JSON.parse(data)
     return @hash_data
  end
end
