defmodule OrdersTest do
  use ExUnit.Case
  alias Orders.{Order, OrderItem, OrderCalculation}

  test "rounding" do
    items = [
      %OrderItem{net_price: 33.33, quantity: 2},
      %OrderItem{net_price: 12.34, quantity: 3}
    ]

    order = %Order{items: items}
    result = OrderCalculation.calculate_order(order, 0.23)

    assert result.net_total == 103.68
    assert result.tax == 23.84
    assert result.total == 127.52

    [first_item, second_item] = result.items
    assert first_item.net_total == 66.66
    assert first_item.total == 81.99
    assert second_item.net_total == 37.02
    assert second_item.total == 45.53
  end

  test "simple case with whole numbers" do
    items = [
      %OrderItem{net_price: 100.0, quantity: 2},
      %OrderItem{net_price: 50.0, quantity: 1}
    ]

    order = %Order{items: items}
    result = OrderCalculation.calculate_order(order, 0.23)

    assert result.net_total == 250.0
    assert result.tax == 57.5
    assert result.total == 307.5

    [first_item, second_item] = result.items
    assert first_item.net_total == 200.0
    assert first_item.total == 246.0
    assert second_item.net_total == 50.0
    assert second_item.total == 61.5
  end

  test "zero tax" do
    items = [
      %OrderItem{net_price: 10.0, quantity: 3},
      %OrderItem{net_price: 5.5, quantity: 2}
    ]

    order = %Order{items: items}
    result = OrderCalculation.calculate_order(order, 0.0)

    assert result.net_total == 41.0
    assert result.tax == 0.0
    assert result.total == 41.0

    [first_item, second_item] = result.items
    assert first_item.total == 30.0
    assert second_item.total == 11.0
  end

  test "empty" do
    order = %Order{items: []}
    result = OrderCalculation.calculate_order(order, 0.2)

    assert result.items == []
    assert result.net_total == 0.0
    assert result.tax == 0.0
    assert result.total == 0.0
  end

  test "sum of lines and tax relation" do
    items = [
      %OrderItem{net_price: 33.33, quantity: 2},
      %OrderItem{net_price: 12.34, quantity: 3}
    ]

    order = %Order{items: items}
    result = OrderCalculation.calculate_order(order, 0.23)

    sum_of_lines = Enum.reduce(result.items, 0.0, fn item, acc -> acc + item.total end)
    assert result.total == sum_of_lines
    assert result.tax == Float.round(result.total - result.net_total, 2)
  end
end
