class HomeController < ApplicationController

  def index
    if $data.present?
      @data ||=  $data.get('/api/hr/v2/jobs.json?buyer_team__reference='+company_reference).read_body
    end
    if @data.present?
      @applications = get_hash(@data)["jobs"]["job"]
    end

  end

  def show_application
    if $data.present?
      @data ||=  $data.get('/api/hr/v3/clients/applications.json?job_key='+params[:job_key]+'&buyer_team__reference='+company_reference).read_body
    end
    if @data.present?
      @applicaiton = get_hash(@data)["applications"]
    end
  end

  def show
 
    if $data.present?
      @data ||=  $data.get('/api/hr/v3/clients/applications/'+params[:app]+'.json?buyer_team__reference='+company_reference).read_body
    end

    if @data.present?
      @application = get_hash(@data)["application"]
    end
  end

  def new
  end

  def create
  end

  private

  def company_reference
     @company_data = $data.get('/api/hr/v2/companies.json').read_body
     @c_ref = JSON.parse(@company_data)["companies"].first["reference"]
     return @c_ref
  end

  def get_hash(data)
     @hash_data = JSON.parse(data)
     return @hash_data
  end
end
