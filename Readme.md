# Skeys version 2.0

**NOTE**: I wrote Skeys over 10 years ago and have not touched it since. I hope you enjoy it but it should go without saying that it's not being maintained.

Skeys is a utility designed to simply the customization of the special keys found some keyboards. To put it simply, it lets you make them do whatever you want them to do.

Contents:

1. Skeys setup
  1.1 Identifying keys
  1.2 "Naming" keys
2. Using Skeys
3. Disabling Skeys
4. Using "Send" and "Paste"
5. Future plans
6. Known Bugs
7. Changelog
8. About me!
9. Special thanks/Resources used


## 1. Skeys setup

Before you can actually use skeys, you must first figure out what keys you want to use, and then pass that information along to Skeys. So the first window you see in Skeys is "Skeys setup".

### 1.1 Identifying keys
When you launch Skeys, you'll see a window with 18 different buttons all labeled "Use this key". Don't freak out, this is actually pretty easy. Every different special key has its own button. Press any special key on your keyboard, and you'll see one of the buttons change from "Use this key" to "!!!Use this key!!!". That's the button for that key. That's all there is to it! Once you've found the key you want to use, just press its button.

#### 1.2 "Naming" keys
In order to make Skeys more friendly and easy to use, you also have the option of "naming" a key, so that it is easier to tell what is what. In order to rename a key in Skeys Setup, right click the button for the key you want to rename, and press "Nickname". Enter your nickname, hit enter, and the button should change to your new name.

If you don't choose nicknames for your keys, they will be auto-nicknamed to their "scan code", which is "SC" followed by a three digit number.

Also, a quick note: all settings will be remembered per key, even if they are unmarked in setup. That means that if you use a key, give it a list of actions, then go back to Setup and unmark it, you can later go back and re-mark it in setup, and all of your setting will still be there.


## 2. Using Skeys

After you've gone through the setup at least once, you can now configure whatever keys you've selected. Begin by selecting from the dropdown list, after which you can either check or uncheck "Enabled". If "Enabled" is not checked, they key WILL STILL FUNCTION IN IT'S DEFAULT SETTING. You can also rename a key from this window.

Below, you have a list of actions: the heart of Skeys. In order to add an action, click "Add", then select your desired choice. Some actions may need no configuration, such as any of the power functions, the volume functions, or exiting Skeys (and all of those should be self-explanatory.) Here are a list of commands that DO need to be configured (also, the "Edit" button will only work on these):
-OPEN FILE/PROGRAM: Choose whatever file/program you want to open/run. You can either manually type in the path to the file, or click the ellipses button and navigate there. Please note that in the "Select File" dialog, you may choose either "Programs (*.exe)" or "All Files (*.*)" from the drop down list below the filename field.
-"SEND"/"PASTE" KEYSTROKES: Under the submenu of "Send keystrokes", "Send" will "type" whatever you want. The only difference between "Send" and "Paste" is that "Paste" types whatever you have specified instantly, like pasting from the clipboard, while "Send" types one character at a time. For more info, see section 3!
-"WAIT": Simply waits, doing nothing, forever however long you specify. The time is in seconds, but is accurate to milliseconds (0.001 seconds). Don't go below that accuracy, though (ie "1.000000000001"), because that is just beyond the limitations of Autohotkey (and it's just plain ridiculous).

To delete an action, highlight it, and press "Del". To re-order actions, press the "Up" or "Dn" (Down) buttons. Actions will be executed from top to bottom, so the order can be very vital. For example, if you have an action below a "Shutdown", it won't be executed, because the computer will be shutting down.


## 3. Disabling Skeys

If you want to temporarily disable a hotkey, go to the Skeys main window (NOT the Setup), and just uncheck the "Enabled" box for that key. The effect will be immediate, and the Special key will do its original intention outside of Skeys.

If you want to disable ALL of Skeys, Double click on the tray icon, or right click the tray and click "Enabled". If Skeys is disabled, the icon will be greyed out, and all of the Skeys will do their original purpose outside of Skeys. In other words, when Skeys is disabled, Special keys will act as if Skeys is not even running.

If you want to make a special key do nothing, mark in in Setup, then just check its "Enabled" box in the main window without adding any actions. This will make Skeys take over that key from its original purpose, but then give it 0 commands to do, meaning it will do nothing.


## 4. Using "Send" and "Paste"

In order to use "other" keys such as Backspace, Enter, the F keys, and so on and so forth, you must specify the keyname within braces, such as {ENTER}. Also, note that the capitilization does not matter inside of braces: {Enter}, {ENTER}, {enter}, {EnTeR} will all do the same thing.

If you are unsure of how to add a certain key, click the "+" button, and find the desired key in the menus. Here's a brief description of the menu:
-COMMON: Basically standard keys that have one function. Also includes the arrow keys.
-F KEYS: All F keys, up to 24. Even if you don't have a keyboard that has 1-24, you can still use 13-24.
-NUMPAD: ALl keys and variations on the numpad. Note that, in terms of textual output, a "Numpad 7" is the same as a regular "7". The difference is only if a game uses the Num keys, or such. Also note that these options are uneffected by Numlock.
-TOGGLE: Contains the "Locks" and the "Modifiers". Although it should be obvious "Shift down" will act as though Shift has been pressed down until "Shift up" is indicated. A regular "Shift" will stay down only until the immediate following character, such as "{Shift}rs" will produce "Rs" (if capslock is off.)
-BRACES: (or brackets....) Because braces/brackets are used for "other" keys, they also become "other" keys themselves. In order to use a brace, just put it inside braces! Example: {{}Hi there!{}} 	will result in		{Hi There!}


If you are using most of the "other" keys (except for maybe Enter), you most likely want to use "Send", because "Pasting" in things like {Shift down} and {Shift up} may have undesirable results. "Paste" is mostly for pure text, like a clipboard.

If you are aware of the Autohotkey language and notice the inconsistencies for some items ("Numpad 0" instead of "Numpad0", all of the Numpad 'math' keys), I apologize if it drives you insane, but you MUST follow the rules and enter keys as they are in the menus, NOT as they are in AHK! Although it is a tad strange, it is much easier for people to read, "Numpad *" or "Numpad ." and understand it rather than "NumpadMult" or "NumpadDot".

## 5. Future Plans

  + Ability to add modifiers to special keys (such as Win, Alt, Shift, Ctrl)
  + fix strange key press?
  - The "AppsKey"?
  - Mouse buttons (meh.....)
  - "Ahk coder's mind save".....Let "Send"/"Paste" entered be proper AHK.

## 6. Known Bugs

-RARE: If "skipsetup" is specified and no option has yet been selected (eg, the first time Skeys has been run)....unexpected and untested results may occur.
-Using some "other" keys may cause undesired results when used with "Paste"
-Special keys CANNOT be binded as modifier keys, such as Shift, because they are incapable of being "down".


## 7. Changelog

- v1.5
  - MAJOR code cleaning, most renaming variables & glabels and standardizing indentation
  - Added comments to code
  - Switched to GPLv3 for license
  - Added ability to handle portable file/program paths
- v1.1
  - FINALLY corrected the broken icon for the popups. God, I'm lazy.
  - Fixed a bug where if one key sent an 'unfinished' modifier (ie, "{Shift Down}"), other keys will still work while Shift is still virtually down. Thanks, Ken!
  - Fixed a bug where Skeys turned off NumLock and ScrollLock when it was turned on. Thanks, Dave!
- v1.0
  - Stable!
- pre1.0
  - Don't want to bore you :P

## 8. About me!

My name is Jon Petraglia. I'm a freshman in college who's had a very small amount of formal computer science training, and mostly picked up program writing while toying with Autohotkey in my spare time. I own an ASUS EEE 901 PC as my primary computer, and the tiny 8.9" screen can be a tad harsh, so I setup a monitor, speakers, and mouse at my desk to plug in so my computer experience would be more enjoyable. I did not have, however, a USB keyboard at the time, and since EEE PCs don't have PS/2 connectors, I decided that I had to buy one, and I did. When it came it had many function keys that I was not used to ("Special" keys, if you will), because I had not used a keyboard with special keys for several years (certainly not since learning Autohotkey.) As I tested them out, I found that some of them opened a web browser that I would rather not use, or that brought up an e-mail client instead of Gmail (which I use), or even that the volume + and - seemed to be swapped. So I decided to do a little coding and rebind it to what I wanted. That was easy enough, but then I thought, "What if I wrote a program for this?"

And so I did. Skeys began very slow, since the main, huge obstacle to overcome was the GUI and having to deal with 18 (at first 17...I missed one) different keys, being able to customize each with its own list of actions, name, ect. After learning a great deal more about hotkeys in Autohotkey than I knew beforehand, Skeys finally became operational. I then sat down with a text document and wrote this readme, including the about section, which reads: "My name is Jon Petraglia. I'm a freshman in college who's had a very small..."

RECURSION! ;)


WHAT YOU CAN DO FOR ME:
No, don't donate. Ok, but only if you really want. Ha. But seriously, there are three things that would make my day: (1) visit my freeware blog, FreewareWire.blogpost.com, check it out, drop a comment, and see if it's something you'd consider bookmarking, (2) e-mail me at FreewareWire@gmail.com with your thanks, bugs, or suggestions, and/or (3) send me something funny, especially a funny LOLCAT. Just let me know you tried the program in some way!

Thanks so much for downloading Skeys. I hope you like it, and it serves you well.
~Jon

PS - If you want to see whatever programs/projects I'm working on, visit the "My Freeware" tag on my blog, or if it's not there, e-mail me.

## 9. Special Thanks

[Xoxide](http://xoxide.com/superslim-illum-keyboard-black.html) - For making a freakin sweet, glowy keyboard to write Skeys.

[Titan](http://www.autohotkey.net/~Titan/#anchor) - For his ABSO-FRIKKIN-LUTELY A-MAZING anchor script, whichout which my programs could never be resized.

[Yook](http://www.autohotkey.com/forum/post-254755.html#254755) - For his AMAZING Balloontip script, letting you display a balloon any current control.