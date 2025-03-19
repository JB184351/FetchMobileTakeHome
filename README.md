### Summary: Include screen shots or a video of your app highlighting its features

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
Here is a list of things I prioritized.

1. Focused on core functionality first that being able to get data from the endpoint provided and displaying that data in a list in SwiftUI.
     - I focused on this first because this was the main part of the test and a common task done in iOS development and wanted to showcase this skill first.
2. Focused on Unit Tests
   - I focused on this a bunch to because I hadn't done this a lot in the past so it was a good exercise for me to do and show I can learn new things without using AI
   - I also thought using Swift Testing would make a great impression since this is a newer technology
  
I did also look into image caching but I couldn't understand the information I was finding online and so went ahead and try to make my project the best possible without it.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I think the most time I spent on this project was with Unit Testing because the concept was unfamiliar to me and I wanted to learn this without using AI so I did a lot of
googling around and learning how Unit Tests work and felt my tests reflect what I learn, though I'm sure there are ways to improve them in the future as I learn more about
Unit Tests. I believe I spent about 12 hours due to mostly Unit Testing, if I were to break it down I think it would look like this.

~1.5 Hours for fetching the data and displaying the Recipes and making sure that worked.
~5 hours for Unit Testing due to not knowing much about it and implementing it and testing it
took some time.
~3 hours looking into Image Caching and trying some things but couldn't understand or successful
in my implementation.
~1 hour of implementing filtering and list refreshing in various ways, this was fun and made sure this 
functionality was working properly.
~0.5 Hours double/triple/quadruple checking requirements and seeing a couple of things I forgot like creating an
empty state if data were to not come back from the server.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
This is similar to my weakest part of the project but caching is something I decided not to add to this project.
This was purely because I couldn't understand how to do it even with some research and turns out the easiest way was
to use a 3rd party library but this was forbidden for this exercise and test.

### Weakest Part of the Project: What do you think is the weakest part of your project?
Not supporting caching is the weakest part of the project because I wasn't sure how to do it despite the research I did.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I added a filtering option to the project, I know this wasn't required but figured it would stick out and was fun to implement. I 
also feel that supporting image caching might be beyond the level of an iOS developer at the Apprenticeship level (I could totally
be wrong here) and there seems to be a good number of 3rd party options for that. I looked at and used `AsyncImage` but that doesn't 
support caching despite some claims online but wanted to use what Apple provided.
