##"I want the mean pitch of every interval that has a non-empty label on tier 5."
##Script from praat manual Boersma & Weenink 2020

if numberOfSelected ("Sound") <> 1 or numberOfSelected ("TextGrid") <> 1
    exitScript: "Please select a Sound and a TextGrid first."
endif
sound = selected ("Sound")
textgrid = selected ("TextGrid")
writeInfoLine: "Result:"
selectObject: sound
pitch = To Pitch: 0.0, 75, 600
selectObject: textgrid
n = Get number of intervals: 5
for i to n
    tekst$ = Get label of interval: 5, i
    if tekst$ <> ""
       t1 = Get starting point: 5, i
       t2 = Get end point: 5, i
       selectObject: pitch
       f0 = Get mean: t1, t2, "Hertz"
       appendInfoLine: fixed$ (t1, 3), " ", fixed$ (t2, 3), " ", round (f0), " ", tekst$
       selectObject: textgrid
    endif
endfor
selectObject: sound, textgrid