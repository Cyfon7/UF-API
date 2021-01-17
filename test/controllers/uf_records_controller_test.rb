require "test_helper"

class UfRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @uf_record = uf_records(:one)
  end

  test "should get index" do
    get uf_records_url, as: :json
    assert_response :success
  end

  test "should create uf_record" do
    assert_difference('UfRecord.count') do
      post uf_records_url, params: { uf_record: { client: @uf_record.client, resquest_date: @uf_record.resquest_date, uf_value: @uf_record.uf_value } }, as: :json
    end

    assert_response 201
  end

  test "should show uf_record" do
    get uf_record_url(@uf_record), as: :json
    assert_response :success
  end

  test "should update uf_record" do
    patch uf_record_url(@uf_record), params: { uf_record: { client: @uf_record.client, resquest_date: @uf_record.resquest_date, uf_value: @uf_record.uf_value } }, as: :json
    assert_response 200
  end

  test "should destroy uf_record" do
    assert_difference('UfRecord.count', -1) do
      delete uf_record_url(@uf_record), as: :json
    end

    assert_response 204
  end
end
