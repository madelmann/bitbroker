
mNotifications = {

Constructor: function() {
	mDebugMessage = document.getElementById("debug_message");
	mDebugMessagePanel = document.getElementById("debug_message_panel");
	mErrorMessage = document.getElementById("error_message");
	mErrorMessagePanel = document.getElementById("error_message_panel");
	mUserMessage = document.getElementById("user_message");
	mUserMessagePanel = document.getElementById("user_message_panel");

	mMessageId = 0;

	this.ClearNotifications();
},

Destructor: function() {
	this.ClearNotifications();
},

AddDebugMessage: function(msg) {
	var notification = document.createElement("div");
	notification.classList.add("debug_message");
	notification.id = 'debug_message_' + mNotifications.mMessageId++;
	notification.innerHTML  = "<img class='notification_remove' onclick='mNotifications.ClearDebugNotifications(" + notification.id + ");' src='resources/images/x_button_notifications.png' />";
	notification.innerHTML += "<p>" + msg + "</p>";

	//mNotifications.mDebugMessagePanel.appendChild(notification);
},

AddErrorMessage: function(msg) {
	var notification = document.createElement("div");
	notification.classList.add("error_message");
	notification.id = 'error_message_' + mNotifications.mMessageId++;
	notification.innerHTML  = "<img class='notification_remove' onclick='mNotifications.ClearErrorNotifications(" + notification.id + ");' src='resources/images/x_button_notifications.png' />";
	notification.innerHTML += "<p>" + msg + "</p>";

	//mNotifications.mErrorMessagePanel.appendChild(notification);
},

AddUserMessage: function(msg) {
	var notification = document.createElement("div");
	notification.classList.add("user_message");
	notification.id = 'user_message_' + mNotifications.mMessageId++;
	notification.innerHTML  = "<img class='notification_remove' onclick='mNotifications.ClearUserNotifications(" + notification.id + ");' src='resources/images/x_button_notifications.png' />";
	notification.innerHTML += "<p>" + msg + "</p>";

	//mNotifications.mUserMessagePanel.appendChild(notification);
},

ClearDebugNotifications: function(id) {
/*
	if ( id ) {
		mNotifications.mDebugMessagePanel.removeChild(id);
	}
*/
},

ClearErrorNotifications: function(id) {
/*
	if ( id ) {
		mNotifications.mErrorMessagePanel.removeChild(id);
	}
*/
},

ClearNotifications: function() {
	mNotifications.ClearDebugNotifications();
	mNotifications.ClearErrorNotifications();
	mNotifications.ClearUserNotifications();
},

ClearUserNotifications: function(id) {
/*
	if ( id ) {
		mNotifications.mUserMessagePanel.removeChild(id);
	}
*/
}

};

