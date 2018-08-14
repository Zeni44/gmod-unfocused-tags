# Unfocused Tags
A small simple script

### What is this?
This is a simple and relatively small script that displays text above players, showing if they are unfocused from the game right now or not.
<br/>
Can be turned off and on with `cl_unfocused_tags`

### For Developers
Unfocused Tags allows you to disable the text rendering on specific or all individuals by using a clientside hook on clients named `ShouldDrawUnfocus`.
<br/>
This hook passes a `Player` as it's first argument and returning `false` stops the rendering on all or a specific individual.
<br/>
Two shared functions exists named `PLAYER:GetFocus()` and `PLAYER:HasFocus()` returning true or false.
<br/>
A serverside function named `PLAYER:SetFocused()` exists, however it's pointless as it's overriden almost instantly unless stopped and mainly used for debugging

### Contributing
Feel free to create a Pull request for anything odd / bad / whatever.
