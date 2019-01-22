require 'rails_helper'

RSpec.describe "product routes", :type => :routing do
  it { expect(products_path).to eq '/products' }
  it { expect(get: products_url).to route_to(
    controller: 'products',
    action: 'index' )
  }

  it { expect(product_path(1)).to eq '/products/1' }
  it { expect(get: product_url(1)).to route_to(
    controller: 'products',
    action: 'show',
    id: '1' )
  }

  it { expect(new_product_path).to eq '/products/new' }
  it { expect(get: new_product_url).to route_to(
    controller: 'products',
    action: 'new' )
  }

  it { expect(edit_product_path(1)).to eq '/products/1/edit' }
  it { expect(get: edit_product_url(1)).to route_to(
    controller: 'products',
    action: 'edit',
    id: '1' )
  }

  it { expect(publish_product_path(1)).to eq '/products/1/publish' }
  it { expect(put: publish_product_url(1)).to route_to(
    controller: 'products',
    action: 'publish',
    id: '1' )
  }
end