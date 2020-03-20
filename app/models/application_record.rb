class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def date_with_day(date)
    date.strftime('%a %b %e, %Y')
  end
end
