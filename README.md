# FALL-2016
Setup steps:

1. Install MySQL

2. Open and run SQL script SQL_Database_Setup.sql (Please note, there maybe groups that didn't add their Stored Procs here. However, most of them are here). This script contains the database creation, the creation of the User Story Stored Procs, and will insert dummy data.

3. Go to ```src\client\server\config\db-connection.js``` and configure your MySQL config settings (username and password).

4. To run app (server/client), open cmd prompt and run ```npm start```. Both server and client run concurrently. See package.json for details.

5. When the app is running, go to the Chrome web browser and visit http://localhost:3000/src/client

6. You should land on the "Create Request" page.