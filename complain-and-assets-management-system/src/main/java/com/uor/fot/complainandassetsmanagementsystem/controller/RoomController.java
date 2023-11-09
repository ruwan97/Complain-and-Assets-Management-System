package com.uor.fot.complainandassetsmanagementsystem.controller;

import com.uor.fot.complainandassetsmanagementsystem.model.Room;
import com.uor.fot.complainandassetsmanagementsystem.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/rooms")
public class RoomController {

    private final RoomService roomService;

    @Autowired
    public RoomController(RoomService roomService) {
        this.roomService = roomService;
    }

    @GetMapping
    public String showAllRooms(Model model) {
        List<Room> rooms = roomService.getAllRooms();
        model.addAttribute("rooms", rooms);
        return "room/rooms";
    }

    @GetMapping("/new")
    public String showRoomForm(Model model) {
        model.addAttribute("room", new Room());
        return "room/add_room";
    }

    @GetMapping("/{id}")
    public String showRoomById(@PathVariable Long id, Model model) {
        Optional<Room> room = roomService.getRoomById(id);
        if (room.isPresent()) {
            model.addAttribute("room", room.get());
            return "room-form";
        } else {
            return "redirect:/rooms";
        }
    }

    @PostMapping
    public ResponseEntity<Room> createRoom(@RequestBody Room room) {
        Room createdRoom = roomService.createRoom(room);
        return new ResponseEntity<>(createdRoom, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Room> updateRoom(@PathVariable Long id, @RequestBody Room updatedRoom) {
        Room room = roomService.updateRoom(id, updatedRoom);
        if (room != null) {
            return new ResponseEntity<>(room, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRoom(@PathVariable Long id) {
        boolean deleted = roomService.deleteRoom(id);
        if (deleted) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

