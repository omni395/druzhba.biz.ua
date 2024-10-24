# frozen_string_literal: true

module AdminHelper
  def content_security_policy_nonce
    @content_security_policy_nonce ||= SecureRandom.base64(16)
  end

  def admin_field_invalid?(form, field)
    form.object&.errors&.include?(field)
  end

  def admin_search_result_count(records)
    return nil if records.blank?

    "#{records.offset_value + 1} - #{records.offset_value + records.length} of #{records.total_count} in total"
  end

  def admin_turbo_stream_flash
    turbo_stream.append 'flashes', partial: 'admin/common/flash'
  end

  def admin_turbo_frame_request_id
    request.headers['Turbo-Frame']
  end

  def admin_remote_modal_id
    admin_turbo_frame_request_id
  end
end
