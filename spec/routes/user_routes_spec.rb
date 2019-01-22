require 'rails_helper'

RSpec.describe "users routing", type: :routing do

  it { expect(users_path).to eq "/users" }
  it { expect(get: users_url).to route_to(
    controller: 'users',
    action: 'index' )
  }

  it { expect(user_path(1)).to eq "/users/1" }
  it { expect(get: user_url(1)).to route_to(
    controller: 'users',
    action: 'show',
    id: '1')
  }

  it { expect(dashboard_path).to eq "/dashboard" }
  it { expect(get: dashboard_url).to route_to(
    controller: 'users',
    action: 'dashboard')
  }

end