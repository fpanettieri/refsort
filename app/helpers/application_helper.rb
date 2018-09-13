module ApplicationHelper
  def humanize_order order
    if order < 1
      "Awful"
    elsif order < 2
      "Bad"
    elsif order < 3
      "Poor"
    elsif order < 5
      "Decent"
    elsif order < 8
      "Good"
    elsif order < 10
      "Great"
    else
      "Excellent"
    end
  end
end
