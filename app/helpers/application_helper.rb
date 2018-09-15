module ApplicationHelper
  def humanize_order order
    if order < 0.15
      "Awful"
    elsif order < 0.3
      "Bad"
    elsif order < 0.45
      "Poor"
    elsif order < 0.6
      "Decent"
    elsif order < 0.75
      "Good"
    elsif order < 0.9
      "Great"
    else
      "Excellent"
    end
  end

  def variant_url img, size
    url_for(img.variant(resize: size)) if img.attached?
  end
end
