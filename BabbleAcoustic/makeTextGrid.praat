## Praat script by Kevin Ryan 9/05
## Parts inspired by Katherine Crosswhite and Jennifer Hay (as indicated)
## Below: user provides directory (the default below is the path for my own desktop;
## you will probably want to change that), initial substring of filename (or complete
## filename minus the extension), the extension (default is .wav), and one or more tiers

form Select directory, file type, and tiers
	sentence Directory S:\Soderstrom-Lab\CurrentStudies\BabblepaperOCS\
	sentence Filename_initial_substring_(optional)
        sentence Extension wav
        sentence Tier(s) t1 t2
endform

Create Strings as file list... list 'directory$''filename_initial_substring$'*.'extension$'
file_count = Get number of strings

## Loop through files and make grids (this section partly inspired by code by Katherine Crosswhite)

for k from 1 to file_count
     select Strings list
     current$ = Get string... k
     Read from file... 'directory$''current$'
     short$ = selected$ ("Sound")

## Below: look for grid, if found, open it, otherwise make new one
## This section inspired by code by Jen Hay

     full$ = "'directory$''short$'.TextGrid"
     if fileReadable (full$)
  	Read from file... 'full$'
  	Rename... 'short$'
     else
  	select Sound 'short$'
  	To TextGrid... "'tier$'"
     endif

## End Jen Hay inspired block

     plus Sound 'short$'
     Edit
     pause Annotate tiers, then press continue...
     minus Sound 'short$'
     Write to text file... 'directory$''short$'.TextGrid
     select all
     minus Strings list
     Remove
endfor

select Strings list
Remove
clearinfo
echo Done. 'file_count' files annotated.
