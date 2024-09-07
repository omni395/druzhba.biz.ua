module Admin
  module OrderDecorator
    def status_color
      case status.to_s
      when 'new' then 'lime'
      when 'in_work' then 'pink'
      when 'done' then 'green'
      when 'rejected' then 'blue'
      else ''
      end
    end

    def paid_color
      case paid.to_s
      when 'unpaid' then 'red'
      when 'inpaid' then 'lime'
      else ''
      end
    end

  end
end