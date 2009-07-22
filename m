From: Dennis Borgmann <dennis.borgmann@googlemail.com>
Subject: Sound XRUN on RT-Linux
Date: Wed, 22 Jul 2009 15:31:49 +0200
Message-ID: <4A6714C5.7010000@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>,
	alsa-user@lists.sourceforge.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:34310 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbZGVNbv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Jul 2009 09:31:51 -0400
Received: by fxm18 with SMTP id 18so183124fxm.37
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Jul 2009 06:31:50 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello ALSA-users!
Hello RT-users!

I think, this mail might be interesting for both the lists, since it's
dealing with ALSA and the usage of a realtime-kernel.

I've been playing around with ALSA for quite some weeks now and I am
trying to get reading of sound done with small latencies. Therefore I am
using the "hw:0:0"-device with SND_PCM_STREAM_CAPTURE and
SND_PCM_NONBLOCK. My device is configured with a total buffersize of 882
frames (44100Hz in SND_PCM_FORMAT_S16 on 2 channels).

All I do, is waiting 2 milliseconds and then reading with
snd_ocm_readi() as much as I can from the soundcard (well, I get the
amount of frames available after 2ms, of course. This timing is quite
stable).

I have the program running on an X86-board (500MHz Geode with
CS5535-Chipset), I applied the realtime patches of Ingo Molnar, I did
set my software to SCHED_FIFO and prio 90, the ICQ of the sounddevice is
set to 98 (this is done with chrt -f -p 98 `pidof "IRQ-11"`), my
/proc/interrupts is quite empty (see below) and I did set the latency of
the PCI-devices in order to give prio ty the soundcard:

setpci -v -s '*:*' latency_timer=20
setpci -v -d '1022:2093' latency_timer=80

My uname:

# uname -a
Linux master 2.6.29.5-rt22-486-voyage #1 PREEMPT RT Wed Jun 24 09:10:02
GMT 2009 i586 GNU/Linux

Here goes the /proc/interrupts - stuff:

#cat /proc/interrupts                                                 
          
CPU0                                                                
  0:    1020847    XT-PIC-XT       
timer                                      
  1:          2    XT-PIC-XT       
i8042                                      
  2:          0    XT-PIC-XT       
cascade                                    
  4:        982    XT-PIC-XT       
serial                                     
 10:     762598    XT-PIC-XT       
wifi0                                      
 11:    1788972    XT-PIC-XT        CS5535
Audio                               
 12:          4    XT-PIC-XT       
i8042                                      
 14:        873    XT-PIC-XT       
ide0                                       
NMI:          0   Non-maskable
interrupts                                      
LOC:          0   Local timer
interrupts                                       
SPU:          0   Spurious
interrupts                                          
CNT:          0   Performance counter
interrupts                               
ERR:         
0                                                                
MIS:          0     

My problem now: roundabout 5 times per minute, I get a buffer outrun,
which results in a "scratch" of the sound, that I am recording. It seems
like I am running over- and underruns again and again. The output looks
like this:

curdma=f3d8000 < f970000
bufaddr.                                              
curdma=f3d8000 < f970000
bufaddr.                                              
curdma=f3d8000 < f970000
bufaddr.                                              
curdma=f3d8000 < f970000
bufaddr.                                              
diff=dc8 >= dc8
buf_bytes.                                                     
diff=dc8 >= dc8
buf_bytes.                                                     
curdma=f3d8000 < f970000
bufaddr.                                              
curdma=f3d8000 < f970000
bufaddr.                                              
curdma=f3d8000 < f970000
bufaddr.                                              
diff=dc8 >= dc8 buf_bytes.
(and so on...)

I found the driver module, that produces this output, it is

/usr/src/linux-2.6.29.5/sound/pci/cs5535audio/cs5535audio_pcm.c

>From line 329 and onwards, there is the function

static snd_pcm_uframes_t snd_cs5535audio_pcm_pointer

, which genreates this output and seems to be the reason for my crappy
sound.
Is there anyone among the RT-list or the ALSA-list who has a slight
idea, what my problem might be related to and how I can get rid of it?

Very kind regards,
Dennis Borgmann
