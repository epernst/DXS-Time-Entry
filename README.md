
# DX365-Time-Entry-App

Extend your Dynamics 365 'Tenerife' with the ability to make time based entries. If you sell your services by the hour, 
then this this app allows you to enter start and end timed. The system will then show the actual duration and calculate the quantity.

You may enter starting and ending time (*1*) directly in the following tables:
- Job Journal Line
- Job Planning Line
- Resource Journal
Additionally the times are transferred to:
- Job Ledger Entry
- Resource Ledger

# Setup

A setup assistant will guide you through the setup.

## Use with hourly units of measure?

The recommended use of the App is to link the time based entries to unit of measure codes marked as hourly. This way you don't accidentially enter a time where you should enter an item quantity. 
The second step in the setup guide will allow you to mark the "Hourly Unit"'s in the list of units of measure. All hourly units also need to have a "Time Rounding" specified. The default "0.25" will round time entered up to 15 minute intervals, where as "1" will round to a full hour. 

## Allow end time to pass midnight?

If you do not want to allow users to enter end times which will pass midnight into the next day, then select the "No" option.
As an alternative you may select end times to go into the next day, or even multiple days. 

## Which fields to show?

If you did not allow end times you pass into the next day or longer, then the best option is to show the regular start and end times. If you do, then the users should be able to enter times where they can see both the date and times. You may also choose to show both or to mix which fields to show.

## Registration email

Unless registered with your email, then it will not be possible to use the app after the trial period. When you register your app, then you will recieve a registration id per email, to the registered email address. We will not share your email with any other parties.

# Additional Features

In the job journal a handy factbox gives the user a quick summery of the job he is working on, plus the job journal in total. This feature require that "Hourly Units Only" is selected in the setup.

