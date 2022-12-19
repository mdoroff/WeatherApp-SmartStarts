# Internationalization

When you need to add support for additional languages in your application, the most important thing that one assumes is translating the App’s content to the respective language. But before you start to incorporate the language content it needs for another country or region in particular, your app should be able to adapt to different languages and regions in general. For your app to succeed in foreign markets in general, it must appear as if it is a native app in each of the languages and regions supported. This is made possible through internationalization. Then, either individually or as a group, the specific language translations must be included in the app, which is the localization. People sometimes speak of internationalization and localization interchangeably, without differentiating between them. However, they are two distinct parts of the process. 


**On iOS devices, users can set their preferred language from “Settings-> General -> International -> Language.”** 


**High level steps and tools in iOS for Internationalization:**

 • Extract language and locale dependencies from your user interface and code.

 • Use Xcode base internationalization to extract text seen by users from your .storyboard and .xib files.

 • Extract other user-facing text or assets from your code.

 • Does your app support any accessibility features, like captions and audio descriptions? Make sure you don't forget about internationalizing tools like VoiceOver.

 • In Interface Builder, use Auto Layout to adapt views as text length changes between languages.

 • Use standard APIs to handle different language systems and locale formats for dates, numbers, and plurals, for instance.

 • For right-to-left languages (Arabic and Hebrew, for example), mirror the user interface and change other text direction as required.


 **Localization** 

• Export and import specific language localizations using standard file formats, such as XLIFF 

• Lock views in the user interface. 

• Send the exported files to translators. 

• Import specific language or asset localization files 

• Check changes and ensure suitability for release through user testing.


## **Adding support for additional languages**

**Base Internationalization** 

Base internationalization in Xcode allows you to deal with one set of app content resources for different localizations, rather than several sets or resources (one set per localization.) For instance, if storyboards are localized in an app and a new user interface element is added, base internationalization allows you to deal with that new element just once, instead of having to add it to several separately localized sets of storyboards. Base internationalization creates individual folders for each language or localized version. Xcode prompts you to define the resources to be used within base internationalization, and also asks you to define your default language, for example, English. 

• .xib (and .nib) and .storyboard files are moved to the Base.lproj folder, which Xcode will create, if it does not already exist 

• String elements are extracted to project locale folders, such as en.lproj for English, also created by Xcode for the occasion. By saving new UI files for iOS localization to the Base.lproj folder, you enable them to support base internationalization too. 


**Adding a New Localization** 

When you select the resource files and language for the localization, Xcode will then: 

• Scan the base storyboard 

• Identify the text/UI elements to be localized 

• Copy them into a strings file as key/value pairs. 

This can include the visible strings of storyboards, such as label, button title, and navigation bar title.


**Use of NSLocalizedString**

The base internationalization in Xcode also provides the NSLocalizedString API to convert hardcoded strings in your app. For this, all the source files must be edited to change all the inline strings in the following way. 


Suppose you have put the hardcoded text of “Greetings” into your app. With NSLocalizedString, you change this reference to NSLocalizedString(@”Greetings”, @”greetings message”). By doing this, “Greetings” becomes a token. The NSLocalizedString call will return the localized string according to the language being used for the application at that time. The other text, “greetings message” is a comment to give further information on the nature of the string (“Greetings”) being localized. The Localizable.strings file must exist to hold all the output of the NSLocalizedString calls in one file (in the en.lproj localization directory in the first instance.) 


**Localization of Different Parts of Your App**

For each language for localization of your app, Xcode stores strings used in your app in a “.strings” file. Your code can simply use a method call to look up and retrieve the string required, according to the current language being used in the iOS device. 

• Strings in Main.storyboard and ViewController.m that are to be localized must be put in a separate file, where they can be referenced (for different language versions.) 

• The text of the label at the top of the screen is set in Main.storyboard, without the possibility to set this text programmatically (there is no IBOutlet.) To localize such **storyboard elements without additional code**, open the disclosure triangle to the left of Main.storyboard to see Main.storyboard (Base) and Main.storyboard (Language to localize into.) 

• To localize **“Localizable.strings”,** select this file using the left pane. Then in the right pane, open the File Inspector. Click on the button marked “Localize” and select “English” (assuming this is your default language), then click Localize. 

• I**mage files**. Prepare or download the foreign language version of the image. In the project directory (use the finder), there should be two or more .lproj folders. One is en.lproj, and at least one other will correspond to the localization language: for example, for French, you will see the fr.lproj folder. The en.lproj folder corresponds to resource files for the English localization, and the fr.lrpoj to the files for the French localization. At this stage both folders hold the same image. In the fr.lproj folder, replace the existing image with the new localized one. • Audio files. Prepare or download the default language and the localized audio file. Copy the default language audio file to the project. Open the file inspector for this file and use the Localize button to select both the default and the target localization language as the supported languages. Rename the localized audio file to have the same name as the default language audio file and copy it to the folder for the localized version, selecting the “Replace File” option in the finder to do this. 

• **App name**. When a localized version of the app is created, Xcode also creates the localization version of InfoPlist.strings. Replace the corresponding key/value pairs in the InfoPlist.string file to override values, including the app name, currently in the Info.plist file. 


**Add Comments for Translators**

You can add comments for translators directly in Interface Builder. NSLocalizedString allows you to include both a unique key and a comment destined to help better understand what is to be translated. For example, in English, the same word “clear” is used as an adjective and a verb, where as in many other languages two separate words are used. The same is true of the English word “run”. A comment for translators to indicate how the word is being used will help them to make a suitable translation and enhance the user experience for the app in the target language. Within base Internationalization, the NSLocalizedString macro will pick out the hard-coded texts in your app. Base Internationalization will also pick up the .xib files (the XML files defining graphic user interfaces developed in Interface Builder, with resources like “Label” and “Button”). However, Xcode builds a .strings file for every .xib resource, so you may want to deal with this before sending extracted text to be translated. One option is to add a comment to describe the resource (you can do this in Interface Builder directly) to say what it is, and (therefore) whether translators should translate it or ignore it. Another option is to simply delete such .strings files from the files that are given to translators. 


## **Auto Layout**

Other languages may differ significantly in average word length, compared to English. Continental European languages such as French, German, and Spanish may be 20% to 50% longer, whereas Asian languages tend to be 30% to 50% shorter. By using Auto Layout, the views in your storyboard will not have fixed origins, widths or heights. Views will therefore be repositioned or resized appropriately if changes in a language or a locale cause changes in text length. Auto Layout is another reason why developers can work with one set of .storyboard and .xib files for all languages. 


## **Plurals**

Languages differ in how they handle plurals, whether for objects or for units of measurement. Some languages don't indicate plurals (such as Japanese), while for others the word will change depending on the quantity (such as Russian).

To make things a bit easier, iOS has categorized the different plural types as follows:

* **Zero**. Used to indicate a 0 quantity.
* **One**. Used to indicate a quantity of exactly 1.
* **Two**. Used to indicate a quantity of exactly 2.
* **Few**. Used to indicate a small quantity greater than 2, but this depends on the language.
* **Many**. Used to indicate a large number, but this also depends on the language.
* **Other**. Used to indicate every number that isn't covered by the above categories.

Not all languages need all categories specified, since all work differently. At first glance, it would appear that English would require rules for zero, one and many. However, the plural rules for English would be specified with *one* and *other*, since all numbers apart from 1 are treated equally.

To specify the plural rules, you need to use a strings dictionary (Localizable.stringsdict) instead of a regular Localizable.strings file. In actual fact, you'll need the .strings file to still be present for the .stringsdict to work, even if it's empty.

In Xcode, create a new Plist file, and name it Localizable.stringsdict. Once populated, the raw data in the Plist will look as follows:

```javascript
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>number_of_days</key>
    <dict>
        <key>NSStringLocalizedFormatKey</key>
        <string>%#@value@</string>
        <key>value</key>
        <dict>
            <key>NSStringFormatSpecTypeKey</key>
            <string>NSStringPluralRuleType</string>
            <key>NSStringFormatValueTypeKey</key>
            <string>d</string>
            <key>one</key>
            <string>%d day remaining</string>
            <key>other</key>
            <string>%d days remaining</string>
        </dict>
    </dict>
</dict>
</plist>
```

This is a bit of a mouthful, but here's what each line means:

```javascript
<key>number_of_days</key>
<dict> ... </dict>
```

This is the name of the string. You use this value in NSLocalizedString() to retrieve the plural information (shown near the bottom of this article). Its corresponding value is a dictionary containing all of the plural translations.

```javascript
<key>NSStringLocalizedFormatKey</key>
<string>%#@value@</string>
```

This is the formatted string that will be output. The translation will be substituted into %#@value@. There can be multiple substitutions, but we're only doing one in this case (called value).

```javascript
<key>value</key>
<dict> ... </dict>
```

This dictionary specifies the rules for the placeholder called value. If there were multiple values being substituted into the NSStringLocalizedFormatKey string, then there would be another dictionary accordingly for that placeholder.

```javascript
<key>NSStringLocalizedFormatKey</key>
<string>NSStringPluralRuleType</string>
```

There are other uses for a .stringsdict file, but in this instance we're using it for plurals, so this entry specifies that fact.

```javascript
<key>NSStringFormatValueTypeKey</key>
<string>d</string>
```

This entry indicates the type of value that will determine the plural rules. d refers to a decimal number.

```javascript
<key>one</key>
<string>%d day remaining</string>
<key>other</key>
<string>%d days remaining</string>
```

These are the specific translations for the given categories (*one* and *other*). Depending on the language, you may have more categories (some languages you may only need the *other* category).

Finally, you can bring this pluralised translation into your code. Earlier we checked within the code to determine which translation to bring in, but now you can let iOS handle this for you:

```javascript
let format = NSLocalizedString("number_of_days", comment: "")

let message = String.localizedStringWithFormat(format, numDays)
```


## Currencies 

The locale settings related to currency are of two kinds:

* **Currency dependent**: these are related to the **monetary value** and depend only on the currency and remain valid wherever you use that currency. 
* **Cultural settings**: these depend on the usages and practices related to the language and the country of the **users** and not directly to the currency. Typically, it's the position of the currency code or symbol relatively to the value, as well as the decimal and thousand separators.

Fortunately, Swift has inbuilt number formatter to handle this exact conundrum.

**Demo code, with a couple of representative currencies:**

```javascript
let value: Double = 1345.23
for mycur in ["USD", "TND", "EUR", "JPY" ] {
    let myformatter = NumberFormatter()
    myformatter.numberStyle = .currencyISOCode
    let newLocale = "(Locale.current.identifier)@currency=(mycur)" // this is it!
    myformatter.locale = Locale(identifier:newLocale)
    print ("currency:(mycur): min:(myformatter.minimumFractionDigits) max:(myformatter.maximumFractionDigits)" 
    print ("result: (myformatter.string(from: value as NSNumber) ?? "xxx")")
}
```

* the USD and the EUR, which, like most currencies can be divided in 100 sub-units (the cents),
* the TND(Tunisian Dinar), which, like a handful of other dinar-currencies, can be divided in 1000 sub-units,
* the JPY(Japanese Yen), which could in the past be divided into sub-units of such a small value that the Japanese government decided not to use them anymore. 

**The results:**

In the current locale the result will be: (in Spanish speaking locale for eg, decimals are separated by a comma, and thousands with a hard space)

```javascript
cur:USD: min:2 max:2 result: 1  345,23 USD
cur:TND: min:3 max:3 result: 1  345,230 TND
cur:EUR: min:2 max:2 result: 1  345,23 EUR
cur:JPY: min:0 max:0 result: 1  345 JPY
```

But if you'd usually work in an English speaking environment, for example in a US culture, you'd get:

```javascript
cur:USD: min:2 max:2 result: USD 1,345.23
cur:TND: min:3 max:3 result: TND 1,345.230
cur:EUR: min:2 max:2 result: EUR 1,345.23
cur:JPY: min:0 max:0 result: JPY 1,345
```

## Date Formatting

Formatting dates properly for every user of your app is no easier (if you want to do everything manually). Luckily, the system can help us. 


For example, in the US one would write **"October 15"** while in The Netherlands we write **15 oktober**.

Note that the order of the date and the month is different, the spelling of the month is different and the capitalization is different too.


The DateFormatter in iOS will handle a lot of this for you:

```javascript
let now = Date()
let formatter = DateFormatter()
formatter.dateFormat = "dd MMMM"
formatter.string(from: now) // 15 oktober
```

The output of this code is spot on. Exactly what we need and it matches the specified date format perfectly. If you'd run the same code on a device that uses en_us as its locale the output would be **15 October**.

The date formatter got the spelling and capitalization right but the date and month are in the wrong order.

You can fix this by using setLocalizedDateFormatFromTemplate on your date formatter instead of assigning its dateFormat directly. Let's look at an example that runs on a device with nl as its locale again:

```javascript
let now = Date()
let formatter = DateFormatter()
formatter.setLocalizedDateFormatFromTemplate("dd MMMM")
formatter.string(from: now) // 15 oktober
```

That still works, perfect. If you'd run this code on an en_us device the output would be **October 15**. Exactly what we need.

If you want to play around with setLocalizedDateFormatFromTemplate in a Playground you can give it a go with the following code that uses a date formatter in different locales:

```javascript
import Foundation

let now = Date()
let formatter = DateFormatter()
formatter.locale = Locale(identifier: "en_us")
formatter.setLocalizedDateFormatFromTemplate("dd MMMM")
formatter.string(from: now) // October 15

formatter.locale = Locale(identifier: "nl")
formatter.setLocalizedDateFormatFromTemplate("dd MMMM")
formatter.string(from: now) // 15 oktober
```


## Time Formatting 

There are  different time formats based on the culture settings. In some countries people tend to use a 12-hour format and append  am/pm, whereas in others the standard is the 24-hour format. Therefore, it’s very important to properly localize date and time based on the currently set locale.


## Handling Timezones

We need to consider that time is always relative. For instance, the current time in the UK is different from the current time in Japan. To overcome this problem, developers have come up with the concept of the Coordinated Universal Time (UTC) timestamp which is the number of seconds from the UNIX epoch. But obviously, on the frontend, we don’t display time in UTC, we convert it into local time. In order to convert UTC to local time, we need to add the time offset to UTC.

***E.g.: UTC -> 2021–08–13T10:23:40***

***Local time -> 2021–08–13T10:23:40+07:00***

The format of parsing the time with the offset is %Y-%m-%dT%H:%M:%S%z. Here %z represents the offset.


The Foundation framework already comes equipped with the common operations you would do with time zones.According to Apple’s documentation, you would use a TimeZone to :

> *TimeZone defines the behavior of a time zone. Time zone values represent geopolitical regions. Consequently, these values have names for these regions. Time zone values also represent a temporal offset, either plus or minus, from Greenwich Mean Time (GMT) and an abbreviation (such as PST for Pacific Standard Time).*

 

**It is important not to handle time is raw formats like string. The Foundation framework takes care of all the corner cases like Leap years and daylight savings. Hence, always transfer time from one endpoint to the other in the from of UTC token. And when it comes to displaying the time on frontend, use the respective STL classes to convert the UTC token to respective local time based on device Timezone and locale. We will have addition information on Timezone and locale below.** 


**TimeZone construction:** 

A TimeZone struct can be constructed in two ways: 


1. By time zone identifier, via TimeZone(identifier: _) if your city identifier (usually in the format: "America/Los_Angeles") happens to match one of the options Apple stored in the framework. 
2. By time zone abbreviation, via TimeZone(abbreviation: _). For example “PST” stands for “Pacific Standard Time”, and its associated city, according to Apple’s data is America/Los_Angeles. This can be thought of as the most iconic city associated with the time zone abbreviation. The complete list of time zone identifiers can be accessed through the static variable TimeZone.knownTimeZoneIdentifiers.


**TimeZone conversion**

Once you have constructed the time zone struct, you can get its localized display name with the following method:

timezone.lolicazedName(for: NSTimeZone.NameStyle, locale: Locale?)

**NSTimeZone.NameStyle** is an enum consist of 6 options:


1. **.standard**: Gives the name of the time zone which usually contains the word “standard”.
2. **.shortStandard**: Gives the standard time in the format of time offset from GMT +0.
3. **.dayLightSaving**: Gives the daylight saving time label for the specific time zone.
4. .shortDayLightSaving
5. .generic
6. **.shortGeneric**: Gives the localized name down to the city. For example, if you use the time zone “America/Vancouver”, the converted name would be “Vancouver Time”. However some countries like China have unified time zone across the country, so even though you specify “Asia/Shanghai”, the result will be “China Mainland Time” instead of “Shanghai Time”

**Locale** determines which language the returned time zone label would be translated into. For example, "zh_Hans_CN" gives Simplified Chinese, "en_UK" gives the name in British English convention. In most cases, you would want to show the name based on the current device’s active locale, which can be accessed through Locale.current.

Below are the results of printing the localized name for each name style and locale combination:

```javascript
========For timezone: "Asia/Shanghai" and locale: "en_UK"
.standard:                     China Standard Time
.shortStandard:                GMT+8
.dayLightSaving:               China Daylight Time
.shortDaylightSaving:          GMT+8
.generic:                      China Standard Time
.shortGeneric:                 China mainland Time

========For timezone: "Asia/Shanghai" and locale: "zh_Hans_CN"
.standard:                     中国标准时间
.shortStandard:                GMT+8
.dayLightSaving:               中国夏令时间
.shortDaylightSaving:          GMT+8
.generic:                      中国标准时间
.shortGeneric:                 中国大陆时间

========For timezone: "America/Vancouver" and locale: "en_UK"
.standard:                     Pacific Standard Time
.shortStandard:                GMT-8
.dayLightSaving:               Pacific Daylight Time
.shortDaylightSaving:          GMT-7
.generic:                      Pacific Time
.shortGeneric:                 Vancouver Time

========For timezone: "America/Vancouver" and locale: "zh_Hans_CN"
.standard:                     北美太平洋标准时间
.shortStandard:                GMT-8
.dayLightSaving:               北美太平洋夏令时间
.shortDaylightSaving:          GMT-7
.generic:                      北美太平洋时间
.shortGeneric:                 温哥华时间
```


For comprehensive lookup you can refer [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) which is an international standard covering the worldwide exchange and communication of date and time-related data.

## Pseudolocalization

Pseudolocalization is a software testing method used for testing internationalization aspects of software. Instead of translating the text of the software into a foreign language, as in the process of localization, the textual elements of an application are replaced with an altered version of the original language. For example, instead of "Account Settings", the text would be altered to display as "!!! Àççôûñţ Šéţţîñĝš !!!". These specific alterations make the original words appear readable, but include the most problematic characteristics of the world's languages: varying length of text or characters, language direction, fit into the interface and so on. 

Pseudolocalization is also a great way to make sure you've left enough room in your GUI for other languages. A common rule of thumb is that non-English languages are 30% longer, so tiny buttons and titles may not fit when you localize. 


Traditionally, localization of software is independent of the software development process. In a typical scenario, software would be built and tested in one base language (such as English), with any *localizable* elements being extracted into external resources. Those resources are handed off to a localization team for translation into different target languages. The problem with this approach is that many subtle software bugs may be found during the process of localization, when it is too late (or more likely, too expensive) to fix them.

The types of problems that can arise during localization involve differences in how written text appears in different languages. These problems include:

* Translated text that is significantly longer than the source language, and does not fit within the UI constraints, or which causes text breaks at awkward positions.
* Font glyphs that are significantly larger than, or possess diacritic marks not found in, the source language, and which may be cut off vertically.
* Languages for which the reading order is not left-to-right, which is especially problematic for user input.
* Application code that assumes all characters fit into a limited character set, such as ASCII or ANSI, which can produce actual logic bugs if left uncaught.

In addition, the localization process may uncover places where an element should be localizable, but is hard coded in a source language. Similarly, there may be elements that were designed to be localized, but should not be (e.g. the element names in an XML or HTML document.) 

Pseudolocalization is designed to catch these types of bugs during the development cycle, by mechanically replacing *all* localizable elements with a pseudo-language that is readable by speakers of the source language, but which contains most of the troublesome elements of other languages and scripts. This is why pseudolocalisation is to be considered an engineering or internationalization tool more than a localization one.


**Pseudolocalization in iOS**

* You use a program to substitute all the English (source) phrases with a fake language.
*  Use this gibberish Localizable.strings file into Xcode and then run your app.
*  Check every screen and make sure all the text appears as the pseudo-localized text rather than your original.


You can use below Mac apps/ Websites to generate a pseudolocalized Localizable.strings file from your projects Localizable.strings file:

* A free app called on the Mac App store that generates pseudolocalized .strings files based on your source code (drag-and-drop) [here](https://itunes.apple.com/us/app/pseudolocalizer/id503026674?mt=12)
* The online translation service [Babble-on](http://www.ibabbleon.com/pseudolocalization.html)
* You can achieve this with the __[Translate Toolkit](http://docs.translatehouse.org/projects/translate-toolkit/)__.


\
# **References:**

<https://developer.apple.com/documentation/xcode/localization>

<https://en.wikipedia.org/wiki/Internationalization_and_localization>

<https://en.wikipedia.org/wiki/Pseudolocalization>

<https://phrase.com/blog/posts/ios-localization-the-ultimate-guide-to-the-right-developer-mindset/>

<https://crunchybagel.com/localizing-plurals-in-ios-development/>

<https://www.donnywals.com/formatting-dates-in-the-users-locale-using-dateformatter-in-swift/>

<https://lokalise.com/blog/date-time-localization/>

<https://medium.com/4-minute-swift/localize-timezone-display-names-in-swift-4d60132cfc26>

<https://en.wikipedia.org/wiki/ISO_8601>
