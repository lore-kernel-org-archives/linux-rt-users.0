From: Chris Edwards <cedwards.linux@cedwards.geek.nz>
Subject: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on SMP
 AMD64 system
Date: Thu, 24 Nov 2011 01:39:21 +1300
Message-ID: <4ECCE979.5080109@cedwards.geek.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.kinect.co.nz ([202.74.33.69]:49892 "EHLO kinect.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752960Ab1KWMuP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Nov 2011 07:50:15 -0500
Received: from mail01.kinect.co.nz (mail01.kinect.co.nz [202.74.33.70])
	by mx1.kinect.co.nz  with ESMTP id pANCdQUp017995-pANCdQUr017995
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=CAFAIL)
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Nov 2011 01:39:26 +1300
Received: from [116.251.188.53] (helo=[192.168.5.64])
	by mail01.kinect.co.nz with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <cedwards.linux@cedwards.geek.nz>)
	id 1RTC6o-000722-0l
	for linux-rt-users@vger.kernel.org; Thu, 24 Nov 2011 01:39:26 +1300
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

Problem:
IRQ-related "nobody cared" kernel call traces not long after bootup on 
Linux 3.0.10-rt27.  I thought I'd try a -rt kernel to see if it would 
resolve the audio drop-outs on my new Firewire audio interface.

System:
Dual Opteron 244 processors on an Iwill DK8N (AMD 8131 and nForce3 250Gb)
Ubuntu 10.04.3 LTS

`uname -a` returns:
Linux zaphod 3.0.10-rt27 #1 SMP PREEMPT RT Thu Nov 24 00:50:56 NZDT 2011 
x86_64 GNU/Linux

`dmesg` snippet:
[   86.720241] irq 17: nobody cared (try booting with the "irqpoll" option)
[   86.720248] Pid: 553, comm: irq/17-firewire Not tainted 3.0.10-rt27 #1
[   86.720251] Call Trace:
[   86.720261]  [<ffffffff810c315a>] __report_bad_irq+0x3a/0xd0
[   86.720266]  [<ffffffff810c3332>] note_interrupt+0x142/0x1f0
[   86.720270]  [<ffffffff810c2e16>] irq_thread+0x1b6/0x1e0
[   86.720273]  [<ffffffff810c2f10>] ? exit_irq_thread+0x80/0x80
[   86.720277]  [<ffffffff810c2c60>] ? irq_finalize_oneshot+0x130/0x130
[   86.720281]  [<ffffffff810c2c60>] ? irq_finalize_oneshot+0x130/0x130
[   86.720286]  [<ffffffff81081876>] kthread+0x96/0xa0
[   86.720290]  [<ffffffff8104dda2>] ? finish_task_switch+0x52/0x100
[   86.720296]  [<ffffffff815f09e4>] kernel_thread_helper+0x4/0x10
[   86.720300]  [<ffffffff810817e0>] ? kthreadd+0x170/0x170
[   86.720304]  [<ffffffff815f09e0>] ? gs_change+0x13/0x13
[   86.720306] handlers:
[   86.720310] [<ffffffff810c1760>] irq_default_primary_handler threaded 
[<ffffffffa010bd70>] irq_handler
[   86.720319] Disabling IRQ #17
[   87.905515] irq 18: nobody cared (try booting with the "irqpoll" option)
[   87.905521] Pid: 470, comm: irq/18-Gina24 Not tainted 3.0.10-rt27 #1
[   87.905523] Call Trace:
[   87.905528]  [<ffffffff810c315a>] __report_bad_irq+0x3a/0xd0
[   87.905531]  [<ffffffff810c3332>] note_interrupt+0x142/0x1f0
[   87.905535]  [<ffffffff810c2e16>] irq_thread+0x1b6/0x1e0
[   87.905538]  [<ffffffff810c2f10>] ? exit_irq_thread+0x80/0x80
[   87.905542]  [<ffffffff810c2c60>] ? irq_finalize_oneshot+0x130/0x130
[   87.905545]  [<ffffffff810c2c60>] ? irq_finalize_oneshot+0x130/0x130
[   87.905550]  [<ffffffff81081876>] kthread+0x96/0xa0
[   87.905553]  [<ffffffff8104dda2>] ? finish_task_switch+0x52/0x100
[   87.905557]  [<ffffffff815f09e4>] kernel_thread_helper+0x4/0x10
[   87.905562]  [<ffffffff810817e0>] ? kthreadd+0x170/0x170
[   87.905566]  [<ffffffff815f09e0>] ? gs_change+0x13/0x13
[   87.905568] handlers:
[   87.905571] [<ffffffff810c1760>] irq_default_primary_handler threaded 
[<ffffffffa02fe7b0>] snd_echo_interrupt
[   87.905579] Disabling IRQ #18

I don't see these messages with the non-rt version of the same kernel.  
These seem to be the only IRQs affected.

I did try the "irqpoll" kernel command-line option as suggested in the 
error messages, but the kernel messages say that it's not supported in -rt.

`cat /proc/interrupts' reports:
            CPU0       CPU1
   0:        135          0   IO-APIC-edge      timer
   1:          0          2   IO-APIC-edge      i8042
   3:          0          2   IO-APIC-edge
   4:          0          3   IO-APIC-edge
   6:          0          5   IO-APIC-edge      floppy
   7:          1          0   IO-APIC-edge
   8:          0          0   IO-APIC-edge      rtc0
   9:          0          0   IO-APIC-fasteoi   acpi
  12:          0          4   IO-APIC-edge      i8042
  14:          0          0   IO-APIC-edge      pata_amd
  15:          0          0   IO-APIC-edge      pata_amd
  17:     199111        890   IO-APIC-fasteoi   firewire_ohci
  18:     196249       3752   IO-APIC-fasteoi   Gina24
  20:       4511        193   IO-APIC-fasteoi   ohci_hcd:usb2
  21:       2375       3144   IO-APIC-fasteoi   ehci_hcd:usb1
  22:          0          0   IO-APIC-fasteoi   sata_nv, ohci_hcd:usb3
  25:       6138        482   IO-APIC-fasteoi   aic7xxx
  26:       5520         91   IO-APIC-fasteoi   eth1, aic7xxx
  27:      42997       6943   IO-APIC-fasteoi   sata_sil
  29:          1        375   IO-APIC-fasteoi   megaraid
NMI:         17         16   Non-maskable interrupts
LOC:     254097     230128   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:         17         16   Performance monitoring interrupts
IWI:          0          0   IRQ work interrupts
RES:      26350      25414   Rescheduling interrupts
CAL:       2825      32855   Function call interrupts
TLB:       1697       1346   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:        117        117   Machine check polls
ERR:          1
MIS:          0


Needless to say, the Firewire audio is a no-go.

I'm also having trouble getting dual-head X to work, but that's another 
issue, most likely.  I'm also wondering if I can get the HPET timer 
enabled: AFAICT (from looking at other BIOSes) the nForce3 has one, but 
this system's ACPI tables don't advertise it.

Any help or suggestions gratefully received. :^)
--
Chris

