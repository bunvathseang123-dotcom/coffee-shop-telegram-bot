package com.setec.telegrambot;

import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.model.request.ParseMode; // Import ParseMode
import com.pengrad.telegrambot.request.SendMessage; // Correct import for pengrad.telegrambot.request.SendMessage
import com.pengrad.telegrambot.response.SendResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service; // @Service is appropriate here for a utility class

@Service 
public class MyTelegramBot {

    private final TelegramBot bot; 
    private final String defaultChatId; 

    public MyTelegramBot(@Value("${token}") String token, @Value("${chat_id}") String chatId) {
        this.bot = new TelegramBot(token);
        this.defaultChatId = chatId; 
    }

    public SendResponse sendMessage(String targetChatId, String text) {
        // Create the SendMessage request for pengrad-telegrambot
        SendMessage request = new SendMessage(targetChatId, text)
                                .parseMode(ParseMode.HTML); 

        SendResponse response = bot.execute(request); 

        if (response.isOk()) {
            System.out.println("Pengrad Telegram message sent successfully to chat ID: " + targetChatId);
        } else {
            System.err.println("Failed to send Pengrad Telegram message to chat ID: " + targetChatId +
                               ". Error code: " + response.errorCode() +
                               ", Description: " + response.description());
        }
        return response;
    }

    public SendResponse sendMessage(String text) {
        return sendMessage(this.defaultChatId, text);
    }
}