module DispositivosHelper
  def self.get_icon_class(disp)
    if disp.platform == "Android"
        return "fa-android"
    end
    if disp.platform == "iOS"
        return "fa-apple"
    end
    
    return "fa-mobile"
  end
end
