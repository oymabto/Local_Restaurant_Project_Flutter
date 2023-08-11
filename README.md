# Final Project: Bytes on Bikes: Employee Dashboard

This is the Final Project for Related Technologies, by Alireza, Devin, and Ian. It is a managerial app for the fictitious Bytes on Bikes restaurant delivery chain.

## Login Information to Use the App

### Manager
Username: `manager1`

Password: `11111111`

Username: `manager2`

Password: `22222222`

### Driver
Username: `driver1`

Password: `11111111`

Username: `driver2`

Password: `22222222`

## Project Overview

An overview of the entire project is given here, to formalize (and brainstorm) the content, features, and functionality of our app.

### Landing Page: Login Form
![Login Screen Image](https://i.postimg.cc/x8RpMjqM/Screenshot-2023-06-30-at-1-52-13-PM.png)


When the User launches the App, they will land on a login form including two (2) `TextField()`s for `username` and `password`. These are two of the fields stored in our `drivers` and `managers` documents. When information is entered in both fields a log in `Button()` will appear. When the information is correct, it will take the User to the appropriate Home Screen.

### HomeScreen

When the User logs in, they will be directed to the Home Screen, either Driver Dashboard or Manager Dashboard, depending on the account information.

#### Driver
![Driver Dashboard Screen Image](https://i.postimg.cc/tJymsnR9/Screenshot-2023-06-30-at-11-02-17-AM.png)


##### Scaffold

The Driver Home Screen consists of a scaffold with the driver's name. Three (3) buttons exist in the BottomBar: Home, Current Delivery, and About Us.

**Home** returns the User to the Driver Home Screen. **Current Delivery** returns the User to the Current Delivery Screen, which contains all the information of the current order, including the destination address, so that all information is glanceable for the driver's convenience. **About Us** shows a welcome message, the company's mission statement, and a statement of support.

##### Cards

To navigate to the other screens in the app, `Card()`s are used instead of simple `Button()`s for easy functionality.

###### Current Delivery

![Current Delivery Screen Image](https://i.postimg.cc/V6jCkDkH/Screenshot-2023-06-30-at-10-30-03-PM.png)


The **Current Delivery Card** will display the **card title** Current Delivery the *order number*, and the *address* of the destination.

When the card is clicked, the User is redirected to the Current Delivery activity which displays all relevant information of the current delivery for the driver. There is a `Button()` labeled Order Delivered that when pressed removes the information and shows a no current delivery message. When the manager assigns a new order, the new information will appear.

###### Availability Status

![Availability Status Screen Image](https://i.postimg.cc/CKMhq77Q/Screenshot-2023-06-30-at-10-33-48-PM.png)



This card will display the **card title**, and the driver's `bool isAvailable` **status**. The card will **toggle** `isAvailable` and between red and green, depending on the status of the driver.

###### My Customer Reviews

This card will display the **card title**, the driver's **rating** as a float between `0` and `10`, and a small blurb of the **latest review**.

When the card is clicked, it will take the driver to a list of all of their reviews.

###### Manager's Updates

This card will display the **card title**, the **date** and **blurb** of the latest manager update, and a message of the number of **unseen updates**.

Clicking on the card will show a list of all manager updates.

#### Manager

![Manager Dashboard Screen Image](https://i.postimg.cc/8CJY9Vng/Screenshot_2023-06-30_at_11.01.45_AM.png)



##### Scaffold

The TopBar consists of the manager `name`, `family` with a welcome message, and which screen they are on. Three (3) buttons exist in the BottomBar: Home, Orders, and Contact Us.

**Home** returns the User to the Manager Home Screen. **Orders** returns the User to the Order Management Screen, which contains all the information of the current orders. **Contact Us** shows employees, location, telephone, email, date established, operating hours, and links to social media.

##### Cards

###### Order Management

![Order Management Screen Image](https://i.postimg.cc/hGdCM1fS/Screenshot_2023-06-30_at_9.58.33_AM.png)


This card will display the **card title**, and an orders image.

Clicking on this card will bring the User to a screen with a list of all the orders, with CRRUD operations available, and allows the manager to assign a delivery to a driver.

###### Inventory

![Inventory Screen Image](https://i.postimg.cc/kGXvrQXR/Screenshot_2023-06-30_at_9.03.56_AM.png)


This card will display the **card title**, and an inventory image.

Clicking on this card will allow the manager to see all information about the raw ingredients, and perform CRRUD operations on each ingredient.

###### Drivers

![Drivers Management Screen Image](https://i.postimg.cc/x8tgqsFP/Screenshot_2023-06-30_at_9.54.02_AM.png)


This card will display the **card title**, and image.

Clicking on the card will bring the User to a list of all drivers, and of all messages organized with two (2) tabs. The User will be able to perform CRRUD operations on the list of all drivers, and set their availability, as well as send manager's updates with full CRRUD capabilities.

###### Menu

![Menu Screen Image](https://i.postimg.cc/44bSrPwy/Screenshot_2023-06-30_at_11.09.11_AM.png)


This card will display the **card title**, and a menu image.

Clicking on this card will allow the manager to perform CRRUD operations on all menu items, and set their availability.