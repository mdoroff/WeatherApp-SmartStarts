# Accessibility: Best Practices in iOS

# Background

There are millions of smartphone users around the world that have some sort of disability.

If we don't take into consideration the accessibility of an app then we miss out on reaching a large number of audience for our app. 

In US, As per [Section 508](https://www.section508.gov/manage/laws-and-policies/) mandates **all technology used and maintained by the federal government to be accessible for people with disabilities (ADA Compliant)**.


**What is ADA Compliance?**

ADA compliance refers to the Americans with Disabilities Act Standards for Accessible Design, which states that all electronic and information technology must be accessible to people with disabilities.


**Who needs to follow this?**

Organizations that need to adhere with ADA requirements mainly include:


1. State and local government agencies
2. Businesses that operate for the benefit of the public


**What happens if the tech isn’t ADA compliant?**

The stakeholder are liable. A lawsuit could be filed against the company if people with disabilities cannot access the tech. Even if the business didn’t intend to discriminate or exclude people with disabilities from accessing the tech, liability can be thousands of dollars in lawsuits.


Apple provides a host of features and support for implementing accessibility in iOS apps.

There are four accessibility domains to keep in mind when thinking about your users:


1. Vision: a person may be blind, colour blind, or have a vision challenge that makes focusing difficult.
2. Mobility: a person with reduced mobility may have difficulty holding a device or tapping the interface.
3. Hearing: a person may be deaf, have partial hearing loss, or they may have difficulty hearing sounds within a certain range.
4. Cognitive: a person may have difficulty remembering a sequence of steps or they may find an overly complex user interface too hard to process and manage.

   \

# Visual Accessibility:

People experience a wide range of visual impairment. 

Some people have full sight, partial sight or low sight, and some have no sight at all. it also includes colour blindness, light sensitivity, motion sensitivity etc. 

Since each person's experience with vision loss is unique, iOS offers a range of visual accessibility settings so that everyone can get the most out of their device in a way that works best for them. 

## Colors:

To make our app visually accessible the designers use colours to make a particular UI element stand out.

### **Shapes**:

Although using colour is often a great way to create emphasis, but we don't want to rely on only colours. The reason for that would be that there can be people that are colour-blind or have low vision. So using only colours to create emphasis will not serve the purpose.

To overcome this issue and improve the visual accessibility and design of the app, we also include **shapes**.


 ![Screenshot showing Apple maps app, for each button (Home, Work, Add) there is a shape associated along with colour. It helps the buttons to stand out, and lets the user know it’s not just a standard button and captures the user’s attention](/api/attachments.redirect?id=2639f6cb-8062-4f22-8460-e8bf7411b911 " =333x627")


Apple emphasizes on using symbols over colours to communicate meaning. 

Designers should apply this design practice to status icons, text with distinguishing colours, or anything else that relies on color alone to convey meaning.  Apple also provides  [SF Symbols](https://developer.apple.com/sf-symbols/) which can be used in this case.

### **Contrast**:

When we use color in our apps, it's important to keep in mind that contrast plays a huge role in readability, and it can be the difference between someone being able to see an element or having it completely blend in.

The **Increase Contrast** accessibility setting makes elements stand out by updating colours to high-contrast appearances. 

iOS provides a range of system colours that automatically adapt to settings like Increase Contrast.

As a general rule, colours should get darker in Light Mode and lighter in Dark Mode. 

If we are not using system colours, then increase in contrast can make a huge difference for some people. 

If we are using custom colours and symbols in our app, we will need to update the tint color or provide alternate assets for high-contrast appearances. 

In the project's asset catalog, We can configure the appearance of the asset by making changes in the Attributes Inspector. Under Appearances, we can check the High Contrast box to provide alternate versions of your asset. 

The High Contrast appearance will be used when Increase Contrast is on. iOS will automatically switch between them based on anyone's display preference.

 ![Screenshot showing the different icons for Normal contrast and High Contrast for Any and Dark mode](/api/attachments.redirect?id=4e1a370e-3651-4bde-8770-4ce9e0a84f4b)

### **Smart Invert Colors:**

Smart Invert Colors is similar to Dark Mode, it darkens bright white UI elements. 

The difference with Dark mode is that it generally has higher contrast, so people with light sensitivity may prefer to use it. Smart Invert Colors is a system setting that asserts an inverted UI over any app. 

You should specially flag certain views (photos, videos and app icons) in your app so they don't get inverted.

You can do that by setting `accessibilityIgnoresInvertColors` on any UIView subclass. This will enable the views to retain standard colors.


So when designing with colors:


1. Take a variety of approaches to create visual emphasis.
2. Colours and shapes are a great opportunity for branding your app experience.
3. Observe and respect preferences if your default design is not accommodating. 


# Font Size:

## **Text Readability**

iOS provides support for changing the size of text on your device.

Smaller text can provide a higher content density by fitting more words on-screen, and large text can make things easy on the eyes. 

This is a great way to ensure your app looks good, not only for every content size, but also across many devices with different display sizes. 

We should avoid truncating text as the content size increases so that the user doesn't miss out on anything. Instead, wrap labels and use all of the available display width.

You can override the function `traitCollectionDidChange`, which gets called when display traits are adjusted on the device. 

The `UITraitCollection` lets you get the device's preferred content size category. We can use a comparison operator to perform comparisons on this enum and adjust our App’s UI.

## **Dynamic Type**

Dynamic Type allows users to choose the text size of content displayed on the screen for better readability. 

It helps users who need larger text for better readability. It also accommodates those who can read smaller text, allowing more information to appear on the screen.

With your application using dynamic font size. You can utilise system’s dynamic font capability to render your applications font in multiple variants like

* ExtraExtraExtraLarge.
* ExtraExtraLarge.
* ExtraLarge.
* Large.
* Medium.
* Small.
* ExtraSmall.

### **Configuring Text Styles Using Interface Builder**


1. **System Font:**

In Interface Builder, select the text style from the Font menu, then select the Automatically Adjust Font checkbox to the right of Dynamic Type.


 ![A partial screenshot of Interface Builder showing the text style "Body" as the selected font in the Attribute Inspector for the selected label.](https://docs-assets.developer.apple.com/published/e6601ba688/a1411025-8bb3-4233-b326-e92d67ab412e.png " =582x509")


2. **Custom Font:**

In Interface Builder, the DynamicType option has no effect on custom fonts set in Interface Builder.


### **Configuring Text Styles in Source Code**


1. **System Font:**

Below code snippet tells the text control to adjust the text size based on the Dynamic Type setting provided by the user.

```swift
label.font = UIFont.preferredFont(forTextStyle: .body)
label.adjustsFontForContentSizeCategory = true
```

To detect to text-size changes the user makes in Settings or Control Center at runtime  we need to override the `traitCollectionDidChange(_:)` method and check for changes to the content size category trait. 

You can also observe `didChangeNotification` and update the font when the notification arrives.


2. **Custom Font:**

For using custom font in our app, we must create a scaled instance of the font in our source code. 

You can use this call on the default font metrics, or you can specify a text style, such as headline.

Fonts created through `UIFontMetrics` behave the same as the preferred fonts the system provides.

```swift
guard let customFont = UIFont(name: "CustomFont-Light", size: UIFont.labelFontSize) else {
    fatalError("""
        Failed to load the "CustomFont-Light" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
    )
}
label.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
label.adjustsFontForContentSizeCategory = true
```


### **To Turn on Dynamic Font Sizing:**


1. Go to Settings > Accessibility > Display & Text Size > Larger Text
2. Toggle Large Accessibility Sizes Toggle (Optional)
3. Use Slider to change font sizes.


# Voice Over:

VoiceOver is a gesture-based screen reader that enables people to experience the interface on their devices even if you can't see the screen. 

Visually Impaired users depend on it to provide auditory feedback while using their iOS devices.

It gives audible descriptions of onscreen content, helping people get information and navigate when they can’t see the screen.

### **To Turn on Voice Over:**


1. Go to Settings > Accessibility > VoiceOver > Turn On
2. Simply ask Siri: "Turn on VoiceOver"

**For testing, there are five key gestures that you may use:**

* Swipe left or right to navigate to the next or previous UI element.
* One-finger double-tap to activate the selected element.
* Two-finger tap to stop and resume speaking.
* Swipe up with two fingers to read everything onscreen.
* Three-finger triple-tap to turn Screen Curtain on and off.

To learn more, see [Operate iPhone using VoiceOver gestures](https://support.apple.com/guide/iphone/operate-iphone-using-voiceover-gestures-iph3e2e2329/ios).

## **Identify common accessibility issues:**

To test the accessibility of your app, turn on VoiceOver and navigate through the interface.

Auditing reveals which elements are accessible with VoiceOver and which aren’t and shows us to identify if VoiceOver navigation is clear and logical. 

Keep track of elements that aren’t accessible and create a list of improvements for adding better VoiceOver support. Check the ordering of all the elements is as per our intention.

To replicate the experience of someone who is solely dependent on VoiceOver, test your app using Screen Curtain. 

Screen Curtain blacks out the entire screen and you can’t see the elements on the screen., but you can still navigate using VoiceOver gestures.

Below are some of the common accessibility issues:

* **Add accessibility information for your app’s elements.** VoiceOver doesn’t recognise custom UI elements by default. we must add additional accessibility information to these elements.
* **Group elements so that VoiceOver navigates through them in the correct order.** VoiceOver reads from  leading to trailing edge. If you want VoiceOver to read your elements in a different order, use groups to facilitate navigation that makes sense for your app.
* **Include descriptive text for VoiceOver to read.** A UI that depends on visual feedback may look nice, but it can be unusable for a VoiceOver user. 
  * For example, VoiceOver doesn’t detect if a confirmation button turns from grey to green when the user selects it. VoiceOver may only describe the element and not its current state.  In this case we can ensure that VoiceOver says if the button is in a selected state.


## **Update your app’s accessibility:**

To improve the App’s accessibility to VoiceOver, we can add accessibility labels, hints, traits and value.


1. **accessibilityLabel:** 

   
   1. Provides descriptive text that VoiceOver reads when the user selects an element. It Should be short and informative. 
   2. By default, VoiceOver reads the text for standard UIKit controls, such as `UILabel` and `UIButton`.
   3. We can add the description to the `.accessibilityLabel` property of a UIElement
2. **accessibilityHint**: Provides additional context (or actions) for the selected element.

   
   1. If there is too much of text to add in an accessibility label, we must consider moving it into a hint.
3. **accessibilityValue:**

   
   1. A string that represents the current value of the accessibility element.  
   2. If a status of a progress changes, we can update the accessibility value too so that user is informed of the update. 
   3. We can update the value by changing `.accessibilityValue` property of the UIElement
4. **accessibilityTraits:**

   
   1. Tell an assistive application how an accessibility element behaves or should be treated by setting these accessibility traits. 
   2. There are several other traits that can viewed by going inside the definition of `.image` or `.none`


### **Improving accessibility using the Identity inspector:**

If the content on the screen is static, use Interface Builder to configure accessibility options.

When using standard UIKit controls, assign accessibility labels and hints in Xcode using the Identity inspector’s Accessibility pane. 

To improve accessibility, you make an element accessible by selecting the Accessibility Enabled option. 


 ![An Xcode screenshot showing the Accessibility pane of the Identity inspector. This pane has a checkbox to enable accessibility, and three text fields to enter text for an object’s label, hint, and identifier. The Accessibility Enabled option is in a selected state. The Label field says Play Song, the Hint field says Play the selected song, and the Identifier field is blank.](https://docs-assets.developer.apple.com/published/3149b8ccd2/3023633@2x.png " =735x")


### **Improving accessibility programmatically:**

If the content on the page is dynamic, use code to configure accessibility options.

To make your element accessible to VoiceOver programmatically, define it as an accessibility element.

For Eg:

```swift
score.isAccessibilityElement = true
```

An element’s label might not stay the same throughout the entire life cycle of your app. For example, for a counter that keeps score as you play a game, you want to change the label as the score changes. Do this programmatically by setting the accessibility label and hint.

```swift
score.accessibilityLabel = "score: (currentScore)"
score.accessibilityHint = "Your current score" 
```


### **Grouping related elements:**

VoiceOver reads in the direction of the device’s language. For example, VoiceOver reads English from left-to-right and it reads Arabic and Hebrew from right-to-left. 

If you vertically stack labels in a UI, or display text in a table, VoiceOver may not read the labels in the correct order. 

You can programmatically group accessibility elements to ensure that VoiceOver reads them as you intend. 

For example, if you’re creating an app that stacks a title and a value to display a person’s name and email address, depending on their order in the interface, VoiceOver may not read those elements together. In such cases Group the elements to ensure that you’re creating a clear context.


 ![Two side-by-side diagrams demonstrating how VoiceOver reads ungrouped and grouped labels. The first group contains the Name label and the person’s name, and the second group contains the Email label and the email address. VoiceOver reads the first group before reading the second group.](https://docs-assets.developer.apple.com/published/ee49778365/bce02f2c-ccd3-4cae-a8fd-22601abc4cb0.png " =533x")


In the image above, there are four labels on the left that VoiceOver reads from the leading to the trailing edge, in this case, left-to-right. 

Although every element is accessible to VoiceOver, it doesn’t provide the best user experience. 

On the right, VoiceOver reads the grouped labels in the intended order, which allows clear navigation.

To group the labels, create a `UIAccessibilityElement` and add the information you want to group together.

```swift
var elements = [UIAccessibilityElement]()
let groupedElement = UIAccessibilityElement(accessibilityContainer: self)
groupedElement.accessibilityLabel = "(nameTitle.text!), (nameValue.text!)"
groupedElement.accessibilityFrameInContainerSpace = nameTitle.frame.union(nameValue.frame)
elements.append(groupedElement)
```


# **UIAccessibilityIdentification:**

# **accessibilityIdentifier**

A string that identifies an element in our User Interface.

It can be used to uniquely identify an element in the scripts we write using the UI Automation interfaces. 

Using an identifier allows you to avoid inappropriately setting or accessing an element’s accessibility label.

Another usage would be for identifying views within UI tests.

We can register all of our identifiers within an enum. Below extension on `UIAccessibilityIdentification` sets accessibilityIdentifiers on our views. 

By adding the enum to the app target and the UI test target, another extension can be added to find views within tests using the ID enum. 

Using an enum avoids duplicating the identifier strings and thus avoids errors.

**App sources**

```swift
extension UIAccessibilityIdentification {
    var viewAccessibilityIdentifier: ViewAccessibilityIdentifier? {
        get { fatalError("Not implemented") }
        set {
            accessibilityIdentifier = newValue?.rawValue
        }
    }
}

addContactButton.viewAccessibilityIdentifier = .addContactButton
```

**Test sources**

```swift
extension XCUIElementQuery {
    subscript(key: ViewAccessibilityIdentifier) -> XCUIElement {
        self[key.rawValue]
    }
}

XCUIApplication().buttons[.addContactButton].tap()
```


Once you have added support for accessibility in your app, we can test it using Xcode’s **Accessibility Inspector.**

# **Accessibility Inspector**

**Accessibility Inspector** is an incredible Xcode tool that Apple provides to developers and quality engineers for testing accessibility in applications. 

There we can inspect the attributes of the elements on the screen, test different text sizes with *Dynamic Type*, invert colors and run audit to find common layout issues (including fix suggestions).

To open it, go to **Xcode > Open Developer Tool > Accessibility Inspector**.


 ![](https://miro.medium.com/max/1400/1*_3YRWMUwQ1Mtn2obknH6rg.png " =700x521")


# Conclusion:

By accommodating above best practices, we can be sure that our app not only looks great on any device, but also  inclusive and accommodating and thus empowering for our customers. 

Also you can enable the above Accessibility settings and see what your app looks like. You will be surprised by what already looks great and start figuring out what can be improved.

# Where to go from here:

* **[Best Practices for the VoiceOver User Experience](https://medium.com/capital-one-tech/ios-accessibility-best-practices-for-the-voiceover-user-experience-dc08112ef16)**
* **[5 Tips to Make Your App More Accessible](https://medium.com/@andrehsouza/ios-accessibility-5-tips-to-make-your-app-more-accessible-de0e9be85a34)**


