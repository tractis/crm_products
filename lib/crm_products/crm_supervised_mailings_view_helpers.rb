module CrmSupervisedMailings
  module ViewHelpers
    
    def get_addmails_link
      button_to :add_mailing_mails, :action => "add_to_mailing"
    end
    
    def get_addmails_link2
      controller = self.controller_name.to_s
      link_to t(:add_mailing_mails, t(controller)), addtomailing_mailing_path(controller)
    end
    
    # Quick-fix for view_hooks translations not working (needs review of fcc code)
    #----------------------------------------------------------------------------
    def get_supervised_mailings_translation(string)
      t(string.to_sym)
    end
    
  end
end

ActionView::Base.send(:include, CrmSupervisedMailings::ViewHelpers)
