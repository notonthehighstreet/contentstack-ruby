require 'spec_helper'
require_relative '../lib/contentstack.rb'

describe Contentstack do
  let(:client) { create_client }
  let(:eu_client) { create_client('ACCESS_TOKEN', 'API_KEY', 'STACK_ENV', {region: Contentstack::Region::EU}) }
  let(:custom_host_client) { create_client('ACCESS_TOKEN', 'API_KEY', 'STACK_ENV', {host: "https://custom-cdn.contentstack.com"}) }

  it "has a version number" do
    expect(Contentstack::VERSION).not_to be nil
  end

  it "has region data" do
    expect(Contentstack::Region::EU).not_to be 'eu'
    expect(Contentstack::Region::US).not_to be 'us'
  end

  it "has default host and region" do
    expect(client.region).to eq Contentstack::Region::US
    expect(client.host).to eq 'https://cdn.contentstack.io'  
  end

  it "has custom region with region host" do
    expect(eu_client.region).to eq Contentstack::Region::EU
    expect(eu_client.host).to eq 'https://eu-cdn.contentstack.com'  
  end

  it "has custom host" do
    expect(custom_host_client.host).to eq 'https://custom-cdn.contentstack.com'  
  end

end