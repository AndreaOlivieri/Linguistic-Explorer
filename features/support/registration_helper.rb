module RegistrationHelper
  def log_in email, password, group=nil, level=nil, role=nil
    sign_up(email, password, group, level, role)
    sign_in(email, password)
  end

  def sign_up(email, password, group=nil, level=nil, role=nil)
    @user = User.find_by_email(email) || create_user(:email => email, :password => password)
    if group.present?
      @group = Group.find_by_name(group) || FactoryGirl.create(:group, :name => group)
      if level.present?
        @membership = Membership.create!(:member => @user, :group => @group, :level => level)
      end
    end
  end

  def sign_in email, password
    visit path_to("the home page")
    click_link "Sign in"
    fill_in "Email",    :with => email
    fill_in "Password", :with => password
    click_button "Sign in"
  end
end

World(RegistrationHelper)