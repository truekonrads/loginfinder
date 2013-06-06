# FormFinder



INTERESTING_WORDS="login auth user pass".split(" ")

class FormFinder

  def findAllForms(doc)
    res=[]
    res.concat self._findLoginFormsByActions doc
    res.concat self._findLoginFormsByInputs doc
    return res.uniq
  end


  def _getParentForm(node)
    begin
    if node.name=="form"
      return node
    elsif node.name=="document"
      return ""
    else
      return _getParentForm node.parent
    end
  rescue NoMethodError
    nil
  end
  end

  def _findLoginFormsByActions(doc)
    inputs=doc.xpath("//form").select { |n|
      bits=[]
      %w(action name).each {|x|
        bits << n[x].downcaseif n[x]
      }
      bits.any? {|b|
          INTERESTING_WORDS.any? {|word| not (b.index word).nil? }
      }
    }
  end

  def _findLoginFormsByInputs(doc)
    inputs=doc.xpath("//input").select { |n|
      bits=[]
      %w(name).each {|x|
        bits << n[x].downcase if n[x]
      }
      bits.any? {|b|
          INTERESTING_WORDS.any? {|word| not (b.index word).nil? }
      }
    }
    all_inputs=inputs.concat doc.xpath("//input[@type='password']")
    (all_inputs.map { |y| _getParentForm y }).uniq
  end
end
