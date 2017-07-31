class Content < ActiveRecord::Base

  def self.search(search)
    if search
      Content.where(['title LIKE ?', "%#{search}%"])
    else
      Content.all
    end
  end

  



end
