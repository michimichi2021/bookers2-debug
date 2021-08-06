require 'test_helper'

class BookSearchControllerTest < ActionDispatch::IntegrationTest
  test "should get book_count" do
    get book_search_book_count_url
    assert_response :success
  end

end
