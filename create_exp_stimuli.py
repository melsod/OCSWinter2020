import os
# all_files = os.listdir("/home/smithb/Dropbox/PSYC7310Open/experiments/Babble_Exp/selected_audio_files")
all_files = os.listdir('C:\\Users\\brads\\Dropbox\\PSYC7310Open\\experiments\\Babble_Exp\\selected_audio_files')
#os.getcwd()
#print(len(all_files))

baby_list=[]
for i in range(0,len(all_files)):
  if all_files[i][:-14] in baby_list:
    pass
  else:
    baby_list.append(all_files[i][:-14])
#print(baby_list)
organized_baby_list = []
for i in range(len(baby_list)):
  organized_baby_list.append([])

for i in range(len(baby_list)):
  for j in range(len(all_files)):
    if all_files[j][:-14]==baby_list[i]:
      organized_baby_list[i].append(all_files[j])
      
#print((organized_baby_list[2]))

print_text = "var test_stimuli = [\n"
for i in range(len(organized_baby_list)):
  print_text=print_text+'''{ \n\t"stimulus":'''
  for j in range(len(organized_baby_list[i])):
     print_text=print_text+''''<audio src="selected_audio_files/'''+organized_baby_list[i][j]+'''" id = "clip_'''+organized_baby_list[i][j][:-4]+'''"></audio>'+'<button id="audio_button_'''+organized_baby_list[i][j][:-4]+'''" onclick="ChangeColour(audio_button_'''+organized_baby_list[i][j][:-4]+'''); window.which_clicked = UpdateClicked(this.id,window.which_clicked); window.which_clicked = EnableButtons(window.which_clicked); PlaySound(clip_'''+organized_baby_list[i][j][:-4]+''');" class="jspsych-btn" style="background-color: white; height:50px;width:100px">Clip '''+str(j+1)+'''</button>'+'''
  #print_text = print_text[:-1]+''',\n\t"data": {\n\t\t"phase": "test",\n\t}\n},\n\n'''
  print_text = print_text[:-1]+'''},\n\n'''
print_text=print_text+''']'''
#print(print_text)

f = open("C:\\Users\\brads\\Dropbox\\PSYC7310Open\\experiments\\Babble_Exp\\test_stimuli.js","w+")
f.write(print_text)
f.close()
