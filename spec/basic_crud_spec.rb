require File.expand_path("../helper", __FILE__)

describe 'LocalwikiClient' do

  before(:all) do
    VCR.insert_cassette 'basic_crud', :record => :new_episodes
    @wiki = Localwiki::Client.new ENV['localwiki_client_server'],
                                  ENV['localwiki_client_user'],
                                  ENV['localwiki_client_apikey']
    require 'securerandom'
    @pagename = "TestPage#{SecureRandom.uuid}"
    @path_matcher = lambda do |request_1, request_2|
      URI(request_1.uri).path.match(/TestPage/) && URI(request_2.uri).path.match(/TestPage/)
    end
    @create_response = @wiki.create('page', {name: @pagename, content: '<p>Created!</p>'}.to_json)
  end

  after(:all) do
    VCR.eject_cassette
  end

  context "CRUD method" do

    it "#create('page', json) response.status is 201" do
      @create_response.status.should eq 201
    end

    it "#read('page', pagename) returns page content" do
      VCR.use_cassette 'basic_crud_read_success', :match_requests_on => [:method, @path_matcher] do
        page = @wiki.read('page', @pagename)
        page.content.should match(/Created!/)
      end
    end

    it "#page_by_name(pagename) returns page content" do
      VCR.use_cassette 'basic_crud_page_by_name_success', :match_requests_on => [:method, @path_matcher] do
        page = @wiki.page_by_name(@pagename)
        page.content.should match(/Created!/)
      end
    end

    it "#update('page', pagename, json) response.status is 204" do
      VCR.use_cassette 'basic_crud_update_success', :match_requests_on => [:method, @path_matcher] do
        response = @wiki.update('page', @pagename, {content: '<foo>'}.to_json)
        response.status.should eq 204
      end
    end

    it "#delete('page', pagename) response.status is 204" do
      VCR.use_cassette 'basic_crud_delete_success', :match_requests_on => [:method, @path_matcher] do
        response = @wiki.delete('page', @pagename)
        response.status.should eq 204
      end
    end

    context "when page does not exist" do

      it "#read returns response.status of 404" do
        VCR.use_cassette 'basic_crud_read_fail', :match_requests_on => [:method, @path_matcher] do
          response = @wiki.read('page', @pagename)
          response.status.should eq 404
        end
      end

      it "#delete returns response.status of 404" do
        VCR.use_cassette 'basic_crud_delete_fail', :match_requests_on => [:method, @path_matcher] do
          response = @wiki.delete('page', @pagename)
          response.status.should eq 404
        end
      end

    end
  end
end
