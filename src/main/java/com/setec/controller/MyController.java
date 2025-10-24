package com.setec.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value; // <--- Make sure this is imported
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.setec.entities.Booked.Booked; // <--- Corrected import path for Booked
import com.setec.repos.BookedRepo;
import com.setec.telegrambot.MyTelegramBot;

@Controller
public class MyController {
	//http://localhost:8081/

    @Value("${chat_id}") // <--- Injected from application.properties
    private String telegramChatId;

	@GetMapping({"/","/home"})
	public String home(Model mod) {
		Booked booked = new Booked(1, "Srey Pich", "070878808", "bunvathseang123@gmail.com", "09/20/2025", "8:26 PM", 2);
		mod.addAttribute("booked",booked);
		return "index" ;
	}

	@GetMapping("/about")
	public String about() {
		return "about";
	}

	@GetMapping("/service")
	public String service() {
		return "service";
	}

	@GetMapping("/menu")
	public String menu() {
		return "menu";
	}

	@GetMapping("/reservation")
	public String reservation(Model mod) {
		Booked booked = new Booked(1, "Seang Bunvath", "070878808", "bunvathseang123@gmail.com", "09/20/2025", "8:26 PM", 2);
		mod.addAttribute("booked",booked);
		return "reservation";
	}

	@GetMapping("/testimonial")
	public String testimonial() {
		return "testimonial";
	}

	@GetMapping("/contact")
	public String contact() {
		return "contact";
	}

	@Autowired
	private BookedRepo bookedRepo;

	@Autowired
	private MyTelegramBot bot;

	@PostMapping("/success")
	public String success(@ModelAttribute Booked booked) {
		bookedRepo.save(booked);

        // --- Start of Telegram Message Customization ---
        String telegramMessage = "<b>🔔 New Booking Alert! 🔔</b>\n\n" +
                                 "<b>Booking Details:</b>\n" +
                                 "---------------------------------\n" +
                                 "👤 <b>ID:</b> <code>" + (booked.getId() != null ? booked.getId() : "N/A") + "</code>\n" +
                                 "🔴 <b>Name:</b> " + (booked.getName() != null ? booked.getName() : "N/A") + "\n" +
                                 "📞 <b>Phone:</b>  " + (booked.getPhoneNumber() != null ? booked.getPhoneNumber() : "N/A") + "\n" +
                                 "📧 <b>Email:</b>  <a href='mailto:" + (booked.getEmail() != null ? booked.getEmail() : "") + "'>" + (booked.getEmail() != null ? booked.getEmail() : "N/A") + "</a>\n" +
                                 "📅 <b>Date:</b> " + (booked.getDate() != null ? booked.getDate() : "N/A") + "\n" +
                                 "🕔 <b>Time:</b> " + (booked.getTime() != null ? booked.getTime() : "N/A") + "\n" +
                                 "👨‍👩‍👧‍👦 <b>Persons:</b>  " + (booked.getPerson() > 0 ? booked.getPerson() : "N/A") + "\n" +
                                 "---------------------------------\n" +
                                 "<i>Thank you for using our service.</i>";

		// <--- Call the correct method with two arguments
		bot.sendMessage(telegramChatId, telegramMessage);
        // --- End of Telegram Message Customization ---

		return "success";
	}
}