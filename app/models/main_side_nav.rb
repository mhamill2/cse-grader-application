class MainSideNav < ActiveRecord::Base

  def self.header_title
    return "GRADERS APP"
  end

  def self.header_link
    return "/"
  end
end
