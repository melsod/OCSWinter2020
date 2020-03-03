# get functions
import os

# list all files in the selected audio files (will have corpus and unique ID in title, could be done differently)
# all_files = os.listdir("/home/smithb/Dropbox/PSYC7310Open/experiments/Babble_Exp/selected_audio_files")
all_files = os.listdir('C:\\Users\\brads\\Dropbox\\PSYC7310Open\\experiments\\Babble_Exp\\selected_audio_files')
#os.getcwd()
#print(len(all_files))

# make a babies (unique ID)
baby_list=[]
for i in range(0,len(all_files)):
  # skip if already added into baby_list
  if all_files[i][:-14] in baby_list:
    pass
  # if not in baby list then add it
  else:
    baby_list.append(all_files[i][:-14]) # all_files[i][:-14] is the babies unique_id (not clip ID)
#print(baby_list)

# create new list
organized_baby_list = []
# make a list (within a list) for each baby
for i in range(len(baby_list)):
  organized_baby_list.append([])

# iterate across all files
for i in range(len(baby_list)):
  # iterate across all baby list
  for j in range(len(all_files)):
    # add file into the appropriate baby list
    if all_files[j][:-14]==baby_list[i]: # all_files[i][:-14] is the babies unique_id
      organized_baby_list[i].append(all_files[j])
      
#print((organized_baby_list[2]))

# make jsPsych stimuli
print_text = "var test_stimuli = [\n"
for i in range(len(organized_baby_list)):
  print_text=print_text+'''{ \n\t"stimulus":'''
  for j in range(len(organized_baby_list[i])):
    # organized_baby_list[i][j][:-4] is the baby unique ID + clip ID without the .wav on the end
     print_text=print_text+''''<audio src="selected_audio_files/'''+organized_baby_list[i][j]+'''" id = "clip_'''+organized_baby_list[i][j][:-4]+'''"></audio>'+'<button id="audio_button_'''+organized_baby_list[i][j][:-4]+'''" onclick="ChangeColour(audio_button_'''+organized_baby_list[i][j][:-4]+'''); window.which_clicked = UpdateClicked(this.id,window.which_clicked); window.which_clicked = EnableButtons(window.which_clicked); PlaySound(clip_'''+organized_baby_list[i][j][:-4]+''');" class="jspsych-btn" style="background-color: white; height:50px;width:100px">Clip '''+str(j+1)+'''</button>'+'''
  
  # this line is to add data to each individual trial. We will want this to have the correct answer + all data attatched to each trial
  #print_text = print_text[:-1]+''',\n\t"data": {\n\t\t"phase": "test",\n\t}\n},\n\n'''
  
  print_text = print_text[:-1]+'''},\n\n'''
print_text=print_text+''']'''
#print(print_text)

# write that jsPsych stimuli to a file
f = open("C:\\Users\\brads\\Dropbox\\PSYC7310Open\\experiments\\Babble_Exp\\test_stimuli.js","w+")
f.write(print_text)
f.close()
