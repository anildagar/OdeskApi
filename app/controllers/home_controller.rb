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
    @grp_data = {}
    status = ["hidden","shortlisted","messaged","hired","declined","offered"]
    if $data.present?
      @data =  $data.get('/api/hr/v3/clients/applications.json?job_key='+params[:id]+'&buyer_team__reference='+company_reference).read_body
      # for i in (0..(status.length-1))
      #    @grp_data[status[i]] = $data.get('/api/hr/v3/clients/applications.json?job_key='+params[:id]+'&buyer_team__reference='+company_reference).read_body
      # end

       @grp_data["hidden"] = $data.get('/api/hr/v3/clients/applications.json?job_key='+params[:id]+'&buyer_team__reference='+company_reference+'&status=hidden').read_body
       @grp_data["shortlisted"] = $data.get('/api/hr/v3/clients/applications.json?job_key='+params[:id]+'&buyer_team__reference='+company_reference+'&status=shortlisted').read_body
       @grp_data["messaged"] = $data.get('/api/hr/v3/clients/applications.json?job_key='+params[:id]+'&buyer_team__reference='+company_reference+'&status=messaged').read_body
       @grp_data["hired"] = $data.get('/api/hr/v3/clients/applications.json?job_key='+params[:id]+'&buyer_team__reference='+company_reference+'&status=hired').read_body
       @grp_data["declined"] = $data.get('/api/hr/v3/clients/applications.json?job_key='+params[:id]+'&buyer_team__reference='+company_reference+'&status=declined').read_body
       @grp_data["offered"] = $data.get('/api/hr/v3/clients/applications.json?job_key='+params[:id]+'&buyer_team__reference='+company_reference+'&status=offered').read_body


    end
  

    if @data.present?
      @applicaiton = get_hash(@data)["applications"]
      for i in (0..(status.length))
        if i==6
          @grp_data["all"] = @applicaiton
        else
         @grp_data[status[i]] = get_hash(@grp_data[status[i]])["applications"]
        end 
      end
    # binding.pry
      # @myar1 = []
      #  @applicaiton.each do |key|
      #    if key["is_shortlisted"]=="1"
      #     h = {}
      #     h = key
      #     @myar1 << h
      #    end
      #  end
      #  @grp_data["shortlisted"] = @myar1
       @grp_data["all"] = @applicaiton


      #binding.pry
       ar = []
       ar << @grp_data
       respond_with(ar)
    else
      #binding.pry
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
