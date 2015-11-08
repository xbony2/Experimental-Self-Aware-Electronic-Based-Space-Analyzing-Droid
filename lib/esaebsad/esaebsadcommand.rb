class ESAEBSADCommand 
  
  $sub_classes = []
  
  def self.inherited(sub_class)
    $sub_classes.push(sub_class)
  end
end
