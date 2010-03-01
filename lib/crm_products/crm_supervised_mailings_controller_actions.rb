module CrmSupervisedMailings
  module ControllerActions

    # Add current asset items to a mailing (new or existing)
    #----------------------------------------------------------------------------
    def add_to_mailing
      
      unless params[:mailing][:id].nil?
        begin
          mailing = Mailing.find(params[:mailing][:id])
          edit = false
        rescue
          flash[:error] = "#{t(:mailing_not_found)}"
          redirect_to :back and return
        end
      else
        if params[:mailing][:name].empty?
          flash[:error] = "#{t(:mailing_needs_name)}"
          redirect_to :back and return
        else
          begin
            mailing = Mailing.create(:name => params[:mailing][:name], :user => @current_user, :access => Setting.default_access)
            edit = true
          rescue
            flash[:error] = "#{t(:mailing_error_creating)}"
            redirect_to :back and return   
          end
        end
      end
      
      items = self.send("get_#{self.controller_name.to_s}")      
      items.each do |item|
        MailingMail.create(:mailing_id => mailing.id, :user_id => 1, :mailable => item)
      end 

      redirect_to mailing_path(mailing, {:edit => edit})
    end

  end
end

ApplicationController.send(:include, CrmSupervisedMailings::ControllerActions)
