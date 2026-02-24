package com.ecommerce.monolith.product.mapper;

import com.ecommerce.monolith.product.dto.CreateProductRequest;
import com.ecommerce.monolith.product.dto.ProductDTO;
import com.ecommerce.monolith.product.model.Product;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import java.util.List;

@Mapper(componentModel = "spring")
public interface ProductMapper {
    ProductDTO toDTO(Product product);
    List<ProductDTO> toDTOList(List<Product> products);
    @Mapping(target = "id", ignore = true)
    Product toEntity(CreateProductRequest request);
    @Mapping(target = "id", ignore = true)
    void updateEntity(CreateProductRequest request, @MappingTarget Product product);
}
