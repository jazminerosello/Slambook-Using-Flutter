Rosello, Ma. Jazmine P.
2021-09665
CMSC 23-B5L

This app is connected in a firebase. Whenever users add a friend slambook in the app, it will be recorded in the firebase collection. Edit, update
and deletion is also reflected in the database using the strem and future. The codes are separated in model, api, provider, screens. 
Routing are being possible with the used of named route approach or the navigtor.push and navigator.pop. More documentations about the code are included
in every dart file.

Slambook provider dart file includes all the methods such as adding, deleting and updating so in slambook dart file, when users clicks the
submit button in the form of slambook, it will call the add method or function specified or written in the slambook provider and all it do is 
it converts the passed item to json format adn used the firebase service with the method of addSlambook which is in the api folder that uses future 
and connects to firebase. This is some sort of flow of how this app works for all update, delete and add methods in connection to firebase.
