module ApplicationHelper
  def self.get_menu
    itens = []
    
    itens.push({
      :path => "/home",
      :label => "Dashboard",
      :icone => "fa fa-dashboard",
    })
    
    itens.push({
      :path => "/dispositivos",
      :label => "Dispositivos",
      :icone => "fa fa-mobile",
    })
    
    return itens
  end
end
