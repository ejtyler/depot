require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  def get_to_order
    LineItem.delete_all
    Order.delete_all

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

  test "check routing number" do
    get_to_order

    select 'Check', from: 'pay_type'

    assert_selector '#order_routing_number'

    fill_in "Routing #", with: "123456"
    fill_in "Account #", with: "987654"

    perform_enqueued_jobs do
      click_button "Place Order"
    end

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal "Dave Thomas", order.name
    assert_equal "123 Main Street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check", order.pay_type
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Pragmatic Depot <depot@example.com>', mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
  end
end
