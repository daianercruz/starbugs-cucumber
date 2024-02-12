Quando('acesso a página principal da Starbugs') do
    visit 'https://starbugs.vercel.app/'
    
end
  
  Então('eu devo ver uma lista de cafés disponíveis') do
    products = all ('.coffee-item')
    expect(products.size).to be > 0
end
  
Dado('que estou na página principal da Starbugs') do
    visit 'https://starbugs.vercel.app/'
end

Dado('que desejo comprar o seguente produto:') do |table|
    @product_name = table.hashes[0][:product]
    @product_price = table.hashes[0][:price]
    @product_delivery = table.hashes[0][:delivery]
  end
  
Quando('inicio a compra desse item') do
 product = find('.coffee-item', text: @product_name)
 product.find('.buy-coffee').click 

end

Então('deve ver a página de Checkout com os detalhes do produto') do
    product_title = find('.item-details h1')
    expect(product_title.text).to eql @product_name

    sub_price = find('.subtotal .sub-price')
    expect(sub_price.text).to eql @product_price

    delivery = find('.delivery-price')
    expect(delivery.text).to eql @product_delivery

end

Então('o valor total da compra deve ser de {string}') do |total_price|
    product_total = find('.total-price')
    expect(product_total.text).to eql total_price

end

Então('devo ver um popup informando que o produto está indisponível') do
 popup = find('.swal2-html-container')
 expect(popup.text).to eql 'Produto indisponível'
end
  