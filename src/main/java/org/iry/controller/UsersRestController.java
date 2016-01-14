/**
 * 
 */
package org.iry.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.iry.dto.user.UserDto;
import org.iry.model.user.User;
import org.iry.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author vaibhavp
 *
 */
@RestController
@RequestMapping("/rest")
public class UsersRestController {
	
	private static final Logger log = Logger.getLogger(UsersRestController.class);
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/users", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<UserDto>> listAllUsers() {
		log.debug("Fetching all users...");
        List<User> users = userService.findAllUsers();
        return new ResponseEntity<List<UserDto>>(convertToDto(users), HttpStatus.OK);
    }
	
	private List<UserDto> convertToDto(List<User> users) {
		List<UserDto> userDtos = new ArrayList<UserDto>();
		if( users != null ) {
			for (User user : users) {
				UserDto userDto = new UserDto();
				userDto.setId(user.getId());
				userDto.setFirstName(user.getFirstName());
				userDto.setLastName(user.getLastName());
				userDto.setSsoId(user.getSsoId());
				userDto.setEmail(user.getEmail());
				userDto.setAuthorizedTransactionLimit(user.getAuthorizedTransactionLimit());
				userDto.setReportingTo(user.getReportingToStr());
				userDto.setRoles(user.getUserProfileStr());
				userDto.setStatus(user.getIsActive() ? "Active" : "Inactive");
				userDtos.add(userDto);
			}
		}
		return userDtos;
	}

}