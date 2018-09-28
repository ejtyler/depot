require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  def get_to_order
    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'Dave Thomas'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'dave@example.com'
  end


  test "check check payment type" do
    get_to_order

    assert_no_selector "#order_routing_number"
    assert_no_selector "#order_account_number"

    select 'Check', from: 'pay_type'

    assert_selector "#order_routing_number"
    assert_selector "#order_account_number"
  end

  test "check credit card payment type" do
    get_to_order

    assert_no_selector "#order_credit_card_number"
    assert_no_selector "#order_expiration_date"

    select 'Credit card', from: 'pay_type'

    assert_selector "#order_credit_card_number"
    assert_selector "#order_expiration_date"
  end

  test "check purchase order payment type" do
    get_to_order

    assert_no_selector "#order_po_number"

    select 'Purchase order', from: 'pay_type'

    assert_selector "#order_po_number"
  end
end
