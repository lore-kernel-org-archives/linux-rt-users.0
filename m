From: Dennis Borgmann <dennis.borgmann@googlemail.com>
Subject: BUG - kernel NULL pointer reference
Date: Wed, 29 Jul 2009 10:44:58 +0200
Message-ID: <4A700C0A.6000309@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f221.google.com ([209.85.218.221]:53082 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbZG2Io6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Jul 2009 04:44:58 -0400
Received: by bwz21 with SMTP id 21so544024bwz.37
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jul 2009 01:44:56 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello RT-Users!

I am using preemption-patches with such an uname:

client30:/tmp# uname -a
Linux client30 2.6.29.5-rt22-486-voyage #1 PREEMPT RT Fri Jul 17
08:55:16 GMT 2009 i586 GNU/Linux

I did let an ALIX-board with an ALSA-application run for one night and I
ran into this bug:

 BUG: unable to handle kernel NULL pointer dereference at 4
IP: [<d0131749>] snd_pcm_period_elapsed+0x11/0x1e3
[snd_pcm]                    
*pde =
00000000                                                                 
Oops: 0000 [#1]
PREEMPT                                                         
last sysfs file:
/sys/class/net/lo/operstate                                    
Modules linked in: ipv6 dm_mod ledtrig_timer ledtrig_heartbeat led_class
scx2002
                                                                              
 
Pid: 3148, comm: IRQ-11 Tainted: P           (2.6.29.5-rt22-486-voyage
#1)      
EIP: 0060:[<d0131749>] EFLAGS: 00010292 CPU:
0                                  
EIP is at snd_pcm_period_elapsed+0x11/0x1e3
[snd_pcm]                           
EAX: 00000000 EBX: ce9c1f38 ECX: ce9c1f38 EDX:
cf053110                         
ESI: ce9c1f20 EDI: cf333400 EBP: ce4bff64 ESP:
ce4bff4c                         
 DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
preempt:00000001                  
Process IRQ-11 (pid: 3148, ti=ce4bf000 task=cf053110
task.ti=ce4bf000)          
Stack:                                                                        
 
 ce4bff5c 00000000 ceabe89c ce9c1f38 ce9c1f20 00000004 ce4bff7c
d01dc1ba        
 cf010210 cf07e7a0 00000000 0000000b ce4bff9c c01351da 0000000b
00000000        
 00000000 c0392c10 0000000b 0000000b ce4bffb4 c0135596 cf07e7a0
c0392c10        
Call
Trace:                                                                     
 [<d01dc1ba>] ? snd_cs5535audio_interrupt+0x80/0xf6
[snd_cs5535audio]           
 [<c01351da>] ?
handle_IRQ_event+0x45/0xb6                                      
 [<c0135596>] ?
thread_simple_irq+0x43/0x7c                                     
 [<c0135b5c>] ?
do_irqd+0x95/0x247                                              
 [<c0135ac7>] ?
do_irqd+0x0/0x247                                               
 [<c012501c>] ?
kthread+0x39/0x61                                               
 [<c0124fe3>] ?
kthread+0x0/0x61                                                
 [<c0103047>] ?
kernel_thread_helper+0x7/0x10                                   
Code: ff ff 59 43 8b 0c 9d 80 88 13 d0 83 f9 ff 75 d0 8d 65 f4 31 c0 5b
5e 5f 5
EIP: [<d0131749>] snd_pcm_period_elapsed+0x11/0x1e3 [snd_pcm] SS:ESP
0068:ce4bfc
CR2:
00000000000001f4                                                           
---[ end trace ab661b3967ef3988
]---                                            
Clocksource tsc unstable (delta = 186926649 ns)

If you need any additional informations about this problem, just let me
know. I hope, this will help you in improving the preemtion-patches. In
addition, a fix of my problem would be nice ;-)

Kind regards,
Dennis
