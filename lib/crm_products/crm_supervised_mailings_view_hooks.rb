class CrmSupervisedMailingsViewHooks < FatFreeCRM::Callback::Base

  ACTIONS_FOR_SHOW = <<EOS
%br
%h4= get_supervised_mailings_translation('mailings')

.label
  %span#mailing_create_title
    = t(:create_new) << " " << t(:or) << " <a href='#' onclick='select_mailing(1); return false;'>" << t(:select_existing) << "</a>:"
  %span#mailing_select_title
    = "<a href='#' onclick='create_mailing(1); return false;'>" << t(:create_new) << "</a> " << t(:or) << " " << t(:select_existing) << ":"
  %span#mailing_disabled_title :
    
= form_tag :action => "add_to_mailing"
= collection_select :mailing, :id, Mailing.my(@current_user).open, :id, :name, {}, { :style => "width:170px; display:none;" }
= text_field(:mailing, :name, :style => "width:170px; display:none;")
:javascript
  // Hide mailing dropdown and show create new mailing edit field instead.
  //----------------------------------------------------------------------------
  create_mailing = function(and_focus) {
    $("mailing_disabled_title").hide();
    $("mailing_select_title").hide();
    $("mailing_create_title").show();
    $("mailing_id").hide();
    $("mailing_id").disable();
    $("mailing_name").enable();
    $("mailing_name").clear();
    $("mailing_name").show();
    if (and_focus) {
      $("mailing_name").focus();
    }
  }
  
  // Hide create mailing edit field and show mailings dropdown instead.
  //----------------------------------------------------------------------------
  select_mailing = function(and_focus) {
    $("mailing_disabled_title").hide();
    $("mailing_create_title").hide();
    $("mailing_select_title").show();
    $("mailing_name").hide();
    $("mailing_name").disable();
    $("mailing_id").enable();
    $("mailing_id").show();
    if (and_focus) {
      $("mailing_id").focus();
    }
  }
  create_mailing(1);
= submit_tag t(:add)
EOS

  SM_JAVASCRIPT = <<EOS
// Hide mailing dropdown and show create new mailing edit field instead.
//----------------------------------------------------------------------------
create_mailing = function(and_focus) {
  $("mailing_disabled_title").hide();
  $("mailing_select_title").hide();
  $("mailing_create_title").show();
  $("mailing_id").hide();
  $("mailing_id").disable();
  $("mailing_name").enable();
  $("mailing_name").clear();
  $("mailing_name").show();
  if (and_focus) {
    $("mailing_name").focus();
  }
}

// Hide create mailing edit field and show mailings dropdown instead.
//----------------------------------------------------------------------------
select_mailing = function(and_focus) {
  $("mailing_disabled_title").hide();
  $("mailing_create_title").hide();
  $("mailing_select_title").show();
  $("mailing_name").hide();
  $("mailing_name").disable();
  $("mailing_id").enable();
  $("mailing_id").show();
  if (and_focus) {
    $("mailing_id").focus();
  }
}

// Show mailings dropdown and disable it to prevent changing the mailing.
//----------------------------------------------------------------------------
select_existing_mailing = function() {
  $("mailing_create_title").hide();
  $("mailing_select_title").hide();
  $("mailing_disabled_title").show();
  $("mailing_name").hide();
  $("mailing_name").disable();
  $("mailing_id").disable();
  $("mailing_id").show();
}

//----------------------------------------------------------------------------
create_or_select_mailing = function(selector) {
  if (selector !== true && selector > 0) {
    this.select_existing_mailing(); // disabled mailings dropdown
  } else if (selector) {
    this.create_mailing();          // create mailing edit field
  } else {
    this.select_mailing();          // mailings dropdown
  }
}

//----------------------------------------------------------------------------
create_or_select_mailing(1);

EOS

  #----------------------------------------------------------------------------
  [ :account, :contact, :lead ].each do |model|

    define_method :"index_#{model}_sidebar_bottom" do |view, context|
      Haml::Engine.new(ACTIONS_FOR_SHOW).render(view, :model => context[model])
    end

  end
  
end
