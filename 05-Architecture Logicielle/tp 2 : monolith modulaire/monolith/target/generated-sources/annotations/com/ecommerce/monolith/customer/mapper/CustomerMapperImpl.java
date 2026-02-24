package com.ecommerce.monolith.customer.mapper;

import com.ecommerce.monolith.customer.dto.CreateCustomerRequest;
import com.ecommerce.monolith.customer.dto.CustomerDTO;
import com.ecommerce.monolith.customer.model.Customer;
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
public class CustomerMapperImpl implements CustomerMapper {

    @Override
    public CustomerDTO toDTO(Customer customer) {
        if ( customer == null ) {
            return null;
        }

        CustomerDTO customerDTO = new CustomerDTO();

        customerDTO.setId( customer.getId() );
        customerDTO.setFirstName( customer.getFirstName() );
        customerDTO.setLastName( customer.getLastName() );
        customerDTO.setEmail( customer.getEmail() );

        return customerDTO;
    }

    @Override
    public List<CustomerDTO> toDTOList(List<Customer> customers) {
        if ( customers == null ) {
            return null;
        }

        List<CustomerDTO> list = new ArrayList<CustomerDTO>( customers.size() );
        for ( Customer customer : customers ) {
            list.add( toDTO( customer ) );
        }

        return list;
    }

    @Override
    public Customer toEntity(CreateCustomerRequest request) {
        if ( request == null ) {
            return null;
        }

        Customer.CustomerBuilder customer = Customer.builder();

        customer.firstName( request.getFirstName() );
        customer.lastName( request.getLastName() );
        customer.email( request.getEmail() );

        return customer.build();
    }

    @Override
    public void updateEntity(CreateCustomerRequest request, Customer customer) {
        if ( request == null ) {
            return;
        }

        customer.setFirstName( request.getFirstName() );
        customer.setLastName( request.getLastName() );
        customer.setEmail( request.getEmail() );
    }
}
