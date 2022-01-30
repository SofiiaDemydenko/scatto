package com.example.repos;

import com.example.domain.Message;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/*
Spring automatically implements this repository interface in a bean that has the same name
(with a change in the case it is called messageRepository).
 */
public interface MessageRepository extends CrudRepository<Message, Long> {

    List<Message> findByTag(String tag);

}
