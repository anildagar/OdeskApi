class HomeController < ApplicationController
  


  def index
    if $data.present?
      @company_data = $data.get('/api/hr/v2/companies.json').read_body
      @c_ref = JSON.parse(@company_data)["companies"].first["reference"]
      @data ||=  $data.get('/api/hr/v2/jobs.json?buyer_team__reference='+@c_ref).read_body
    end

    if @data.present?
      @hash_data = JSON.parse(@data)
      @applications = @hash_data["jobs"]["job"]
    end

  end

  def show_application
    if $data.present?
      @data ||=  $data.get('/api/hr/v3/clients/applications.json?job_key='+params[:job_key]+'&buyer_team__reference=1486689').read_body
    end
    if @data.present?
      @hash_data = JSON.parse(@data)
      @applicaiton = @hash_data["applications"]
    end
    #binding.pry
  end

  def show
 
    if $data.present?
      @data ||=  $data.get('/api/hr/v3/clients/applications/'+params[:app]+'.json?buyer_team__reference=1486689').read_body
    end
    @hash_data = JSON.parse(@data)
    @application = @hash_data["application"]
   #binding.pry

  end

  def new
  end

  def create
  end

end
