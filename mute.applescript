set curVolume to get volume settings
if input muted of curVolume is false then
	set volume with input muted
else
	set volume without input muted
end if


sudo osascript -e "set volume input volume 0 --100%"


there is not mute option for the input but looks like you can set it to 0 and it mutes it
now I need to set up a script that remembers the last value other than 0
and bind it to a shortcut 
would also be good to play a sound on activation and deactivation
or have a visual indicator of the sound 
could also setup a push to talk system 
and a toggle
