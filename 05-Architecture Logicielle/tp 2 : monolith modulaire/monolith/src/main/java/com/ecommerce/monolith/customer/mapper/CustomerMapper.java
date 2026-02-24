package com.ecommerce.monolith.customer.mapper;

import com.ecommerce.monolith.customer.dto.CreateCustomerRequest;
import com.ecommerce.monolith.customer.dto.CustomerDTO;
import com.ecommerce.monolith.customer.model.Customer;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import java.util.List;

@Mapper(componentModel = "spring")
public interface CustomerMapper {
    CustomerDTO toDTO(Customer customer);
    List<CustomerDTO> toDTOList(List<Customer> customers);
    @Mapping(target = "id", ignore = true)
    Customer toEntity(CreateCustomerRequest request);
    @Mapping(target = "id", ignore = true)
    void updateEntity(CreateCustomerRequest request, @MappingTarget Customer customer);
}
