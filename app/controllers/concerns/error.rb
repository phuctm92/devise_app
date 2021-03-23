# frozen_string_literal: true

module Error
  def render_not_found
    render partial: 'errors/404', status: :not_found
  end
end
