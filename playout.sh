cvlc -vvv './video/1000.mp4' 'vlc://quit' --avcodec-hw none --sout-all --sout-ts-shaping=1000 --sout '#transcode{vcodec=mp2v,vfilter=canvas{aspect=4:3,width=720,height=576},width=720,height=576,fps=25,vb=2000,acodec=mpga,samplerate=48000,ab=256}:standard{access=udp,mux=ts{pcr=40,pid-pmt=1000,pid-video=1001,pid-audio=1002,tsid=1,netid=1,sdtdesc="projectbattersea,pb00001",use-key-frames},dst=224.0.0.1:1234}' -I dummy --no-dbus & 

cvlc -vvv './video/2000.mp4' 'vlc://quit' --avcodec-hw none --sout-all --sout-ts-shaping=1000 --sout '#transcode{vcodec=mp2v,vfilter=canvas{aspect=4:3,width=720,height=576},width=720,height=576,fps=25,vb=2000,acodec=mpga,samplerate=48000,ab=256}:standard{access=udp,mux=ts{pcr=40,pid-pmt=2000,pid-video=2001,pid-audio=2002,tsid=1,netid=1,sdtdesc="projectbattersea,pb00002",audio-sync,use-key-frames,avcodec-interlace},dst=224.0.0.1:1235}' -I dummy --no-dbus & 

cvlc -vvv './video/3000.mp3' 'vlc://quit' --avcodec-hw none --sout-all --sout-ts-shaping=1000 --sout '#transcode{acodec=mpga,samplerate=48000,ab=256}:standard{access=udp,mux=ts{pcr=40,pid-pmt=3000,pid-audio=3002,tsid=1,netid=1,sdtdesc="projectbattersea,pb00003"},dst=224.0.0.1:1236}' -I dummy --no-dbus

