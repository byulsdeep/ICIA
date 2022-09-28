var stompClient = null;
var currentRoom = null;
var subscription = null;

function setRoom() {
	currentRoom = claSelCode.value + claCteCode.value + claPrdCode.value;
	
	if(subscription !== null) {
		subscription.unsubscribe();
		subscription = stompClient.subscribe(
			'/topic/' + currentRoom,
			function (chat) {
            showChat(JSON.parse(chat.body).name, JSON.parse(chat.body).content);
        });
		document.getElementById("chats").innerHTML = "";
	}
	connect();
}

function setConnected(connected) {    
    connected ? document.getElementsByClassName("connect")[0].innerText = 
    	"[" + claName.value + "]" + " 채팅방에 연결되었습니다." :
    	"연결실패"; 
}

function connect() {	
    var socket = new SockJS('/chat');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        setConnected(true);
        subscription = stompClient.subscribe(
			'/topic/' + currentRoom,
			function (chat) {
            showChat(JSON.parse(chat.body).name, JSON.parse(chat.body).content);
        });
    });   
}

function send() {
	var content = document.getElementById("content");
	if(this.userType == "buyer") {
		var name = this.buyNickname;
	} else if(this.userType == "seller") {
		var name = this.selNickname + "[선생님]";
	}
	stompClient.send("/app/chat/" + currentRoom + "/" + name, {}, content.value.trim());
    content.value = "";
    content.focus();
}

function showChat(name, content) {
	let chats = document.getElementById("chats");
	let div = document.createElement("div");
	div.innerText = name + " : " + content;
    chats.appendChild(div);
    chats.scrollTop = chats.scrollHeight;
}