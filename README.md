# Documentation

please read the agora documentation and follow the instructions to understand more about the code [Agora doc](https://docs.agora.io/en/video-calling/get-started/get-started-sdk)

# Packages
there is something important about the package that is being used in this project there are two packages that has been used:

- package: **agora_rtc_engine**
- package: **agora_ui_kit**

**please note** that the two packages **cannot be used at the same project** both of them are the same package but the different is that **agora_ui_kit** creates the UI automatically while the other is just the basic code, just to test the video call and customize it manually by yourself.

# Agora console

before beginning create the app you need to create an account on agora website [Agora](https://www.agora.io/en/)
,after that you need to create:

- appID
- channelName
- token

## Creating appid

go to your agora console after logging in > Project Management > Create > write the project name and select the use case ( make it social/chatroom ) > choose Authentication Mechanism ( if you will pick secured mode there will be token and appid it is used for live app to create every chat/video call a unique channel, the other one just for testing in the debugging mode) > Submit.
you will find the appid in the table just copy it and put in the utils.dart.

## Creating channelName and token

on the agora console, press config on your project > under Features press Generate temp RTC token > write the channel name > Generate.

you will find that the token has been created copy both channel name and token on put it in utils.dart.

# Implementation

you can read the code and the agora documentation to help you understand more about the code and i commented on each function to help you understand what does it do please remember to read the instruction of the documentation it will really help you run the code.
