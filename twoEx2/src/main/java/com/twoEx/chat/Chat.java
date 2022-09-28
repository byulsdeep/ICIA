package com.twoEx.chat;

public class Chat {
	
	private String name;
	private String content;
	//private String profile;
	//private MessageType type;
	
	public enum MessageType {
		CHAT,LEAVE,JOIN
	}
	
	public Chat(String name, String content) {
		this.name = name;
		this.content = content;
		//this.profile = profile;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}