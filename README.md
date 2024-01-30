# Slambook-App-Using-Flutter

**Author**: Ma. Jazmine P. Rosello

**Purpose**: For the completion of exercise in CMSC 23: Mobile Computing

**Note**: This slambook uses firebase, however, I cannot access firebase now because of this... and therefore, storing the friends records in the slambook would not work and so the edit and delete record functions.
![Screen Shot 2024-01-31 at 6 46 37 AM](https://github.com/jazminerosello/Slambook-Using-Flutter/assets/125422872/1f4fe5eb-2fdd-4435-9a50-092d491db2ab)

## Program Description:

This app is connected in a firebase. Whenever users add a friend slambook in the app, it will be recorded in the firebase collection. Edit, update and deletion is also reflected in the database using the strem and future. The codes are separated in model, api, provider, screens. Routing are being possible with the used of named route approach or the navigtor.push and navigator.pop. More documentations about the code are included in every dart file.

Slambook provider dart file includes all the methods such as adding, deleting and updating so in slambook dart file, when users clicks the submit button in the form of slambook, it
will call the add method or function specified or written in the slambook provider and all it do is it converts the passed item to json format adn used the firebase service with the method of addSlambook which is in the api folder that uses future and connects to firebase. This is some sort of flow of how this app works for all update, delete and add methods in connection to firebase.
