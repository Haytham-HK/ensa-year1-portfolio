package com.ecommerce.monolith.product.mapper;

import com.ecommerce.monolith.product.dto.CreateProductRequest;
import com.ecommerce.monolith.product.dto.ProductDTO;
import com.ecommerce.monolith.product.model.Product;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2026-02-24T22:18:28+0000",
    comments = "version: 1.5.2.Final, compiler: javac, environment: Java 17.0.18 (Ubuntu)"
)
@Component
public class ProductMapperImpl implements ProductMapper {

    @Override
    public ProductDTO toDTO(Product product) {
        if ( product == null ) {
            return null;
        }

        ProductDTO productDTO = new ProductDTO();

        productDTO.setId( product.getId() );
        productDTO.setName( product.getName() );
        productDTO.setDescription( product.getDescription() );
        productDTO.setPrice( product.getPrice() );
        productDTO.setStock( product.getStock() );

        return productDTO;
    }

    @Override
    public List<ProductDTO> toDTOList(List<Product> products) {
        if ( products == null ) {
            return null;
        }

        List<ProductDTO> list = new ArrayList<ProductDTO>( products.size() );
        for ( Product product : products ) {
            list.add( toDTO( product ) );
        }

        return list;
    }

    @Override
    public Product toEntity(CreateProductRequest request) {
        if ( request == null ) {
            return null;
        }

        Product.ProductBuilder product = Product.builder();

        product.name( request.getName() );
        product.description( request.getDescription() );
        product.price( request.getPrice() );
        product.stock( request.getStock() );

        return product.build();
    }

    @Override
    public void updateEntity(CreateProductRequest request, Product product) {
        if ( request == null ) {
            return;
        }

        product.setName( request.getName() );
        product.setDescription( request.getDescription() );
        product.setPrice( request.getPrice() );
        product.setStock( request.getStock() );
    }
}
