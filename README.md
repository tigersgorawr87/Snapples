# Snapples
Snapples is word association game using user generated snaps of user generated topics.

<h3>Purpose:</h3>
  1.  The main purpose of this project is to learn swift<br />
  2.  A secondary purpose of this project is map out my idea of a good app (still a work in progress)<br />
  3.  The next step in this project is to refine my ideas and write a better version using React Native<br />

<h3>Included in this project:</h3>
  &nbsp;&nbsp;&nbsp;1. podfile (for installing dependencies)
  
  2. Snapples (folder containing all code of the code I have written in swift and corresponding UI nib files)<br />
    a. last update was converting code to swift 4<br />
    b. updating to swift 4 broke the facebook login to my code,  so that part of this project was gutted and not included<br />
    c. incomplete: made it all the way to getting users to access camera,  however the snaps never make it to storage<br />
      &nbsp;&nbsp;&nbsp;&nbsp;A.  user generated topic section has yet to be created<br />
      &nbsp;&nbsp;&nbsp;&nbsp;B.  user rating system has yet to be created<br />
      &nbsp;&nbsp;&nbsp;&nbsp;C.  the "game" aspect has yet to be created<br />
    d. Broken: the views seem to be broken for plus models,  this issue arrose from updating code to swift 4<br />
    
  3. SnapplesDB (folder containing my api written with django rest framework)<br />
    a. this db has become mostly useless with in the current project due to ios 11 gutting facebook login<br />
    b. the intentions of this db was to take a graph request from users and automating a profile for them<br />
    c. incomplete: there is no user validation for the Db, also never made it to storage of links to uploaded snaps<br />
    








