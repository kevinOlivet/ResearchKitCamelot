#ResearchKitCamelot

This project implements ResearchKit and HealthKit.

It's a combination of two tutorials from Ray Wenderlich.
The first one is here:
https://www.raywenderlich.com/104575/researchkit-tutorial-with-swift

The first section implements a request for Authorization to read and write to the phone's health kit.
Please note that the user must accept for any of this to work.

The second button implements the steps for obtaining consent with explanations for each section and a signature screen.
The survey part implements a textfield and multiple choice (with written words and color images) answer styles.
The microphone part records and saves a voice sample (must be tested on a device to see it in action).

The second part of the project comes from here:
https://www.raywenderlich.com/117433/accessing-heart-rate-data-researchkit-study

The walk section has the user walk and then sit comfortably. 
The app generates mock heartrate data (so don't test this part on a device).
The data is then shared with the user's phone Health app. 
Its records can be accessed in the Today or Health sections.

The music section plays a random clip of music to assess it's affect on heart rate.  
Again the heart rate data is stored and shared with the Health app.