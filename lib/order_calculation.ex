defmodule Orders.OrderCalculation do
  alias Orders.Order
  alias Orders.OrderItem

  def calculate_order(%Order{items: items} = order, tax_rate) do
    calculated_items =
      Enum.map(items, fn %OrderItem{net_price: net_price, quantity: quantity} = item ->
        net_total = Float.round(net_price * quantity, 2)
        total = Float.round(net_total * (1 + tax_rate), 2)
        %OrderItem{item | net_total: net_total, total: total}
      end)

    {net_total, total} =
      Enum.reduce(calculated_items, {0.0, 0.0}, fn item, {net_acc, total_acc} ->
        {net_acc + item.net_total, total_acc + item.total}
      end)

    net_total = Float.round(net_total, 2)
    tax = Float.round(total - net_total, 2)

    %Order{order | items: calculated_items, net_total: net_total, tax: tax, total: total}
  end
end
