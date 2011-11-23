From: Chris Edwards <cedwards@ripples.dyndns.org>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Thu, 24 Nov 2011 12:12:12 +1300
Message-ID: <4ECD7DCC.3000505@ripples.dyndns.org>
References: <4ECCE979.5080109@cedwards.geek.nz> <1322056363.20742.45.camel@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.kinect.co.nz ([202.74.33.69]:51441 "EHLO \031"
	rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1752463Ab1KWXXM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Nov 2011 18:23:12 -0500
In-Reply-To: <1322056363.20742.45.camel@frodo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 24/11/11 02:52, Steven Rostedt wrote:
> On Thu, 2011-11-24 at 01:39 +1300, Chris Edwards wrote:
>> Hi all,
>>
>> Problem:
>> IRQ-related "nobody cared" kernel call traces not long after bootup on
>> Linux 3.0.10-rt27.  I thought I'd try a -rt kernel to see if it would
>> resolve the audio drop-outs on my new Firewire audio interface.
> I wonder if this is another bad irq chipset. Does it go away if you boot
> with noapic in the kernel command line?
>

Thanks for the quick reply, Steven.  Booting with "noapic" does seem to 
avoid the problem with IRQs 17 and 18, and the Firewire audio now works, 
but the "nobody cared" error now appears for IRQ 7:

[  752.450644] irq 7: nobody cared (try booting with the "irqpoll" option)
[  752.450653] Pid: 74, comm: irq/7-ohci_hcd: Not tainted 3.0.10-rt27 #1
[  752.450657] Call Trace:
[  752.450671]  [<ffffffff810c315a>] __report_bad_irq+0x3a/0xd0
[  752.450676]  [<ffffffff810c3332>] note_interrupt+0x142/0x1f0
[  752.450680]  [<ffffffff810c2e16>] irq_thread+0x1b6/0x1e0
[  752.450684]  [<ffffffff810c2f10>] ? exit_irq_thread+0x80/0x80
[  752.450688]  [<ffffffff810c2c60>] ? irq_finalize_oneshot+0x130/0x130
[  752.450692]  [<ffffffff810c2c60>] ? irq_finalize_oneshot+0x130/0x130
[  752.450699]  [<ffffffff81081876>] kthread+0x96/0xa0
[  752.450703]  [<ffffffff8104dda2>] ? finish_task_switch+0x52/0x100
[  752.450711]  [<ffffffff815f09e4>] kernel_thread_helper+0x4/0x10
[  752.450715]  [<ffffffff810817e0>] ? kthreadd+0x170/0x170
[  752.450719]  [<ffffffff815f09e0>] ? gs_change+0x13/0x13
[  752.450721] handlers:
[  752.450726] [<ffffffff810c1760>] irq_default_primary_handler threaded 
[<ffffffff81464e60>] usb_hcd_irq
[  752.450733] Disabling IRQ #7


Here is the interrupt arrangement now:

cat /proc/interrupts
            CPU0       CPU1
   0:        125          0    XT-PIC-XT-PIC    timer
   1:          2          0    XT-PIC-XT-PIC    i8042
   2:          0          0    XT-PIC-XT-PIC    cascade
   3:          1          0    XT-PIC-XT-PIC
   4:          1          0    XT-PIC-XT-PIC
   5:       4794        279    XT-PIC-XT-PIC    ehci_hcd:usb1
   6:          4          1    XT-PIC-XT-PIC    floppy
   7:       2071      16855    XT-PIC-XT-PIC    ohci_hcd:usb3
   8:          0          0    XT-PIC-XT-PIC    rtc0
   9:        295         18    XT-PIC-XT-PIC    acpi, sata_nv, ohci_hcd:usb2
  10:       9995       1467    XT-PIC-XT-PIC    sata_sil, Gina24
  11:       1758        305    XT-PIC-XT-PIC    megaraid, aic7xxx, 
firewire_ohci, eth1, aic7xxx
  12:          4          0    XT-PIC-XT-PIC    i8042
  14:          0          0    XT-PIC-XT-PIC    pata_amd
  15:          0          0    XT-PIC-XT-PIC    pata_amd
NMI:          2          2   Non-maskable interrupts
LOC:      39580      37870   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:          2          2   Performance monitoring interrupts
IWI:          0          0   IRQ work interrupts
RES:      12595      17142   Rescheduling interrupts
CAL:       4611       2901   Function call interrupts
TLB:        264        285   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:         21         21   Machine check polls
ERR:         34
MIS:          0

Looking at the interrupt rates while running jackd with different 
settings, it looks a lot like the Firewire interrupts are being 
duplicated on IRQ 7.  Also (and I'm not sure if this is significant) the 
interrupt rates seem to be swapped with respect to the CPUs:

IRQ 7 on CPU 0 (ohci_hcd:usb3) shows essentially the same rate as IRQ 11 
on CPU 1 (megaraid, aic7xxx, firewire_ohci, eth1, aic7xxx).

IRQ 7 on CPU 1 (ohci_hcd:usb3) ditto WRT IRQ 11 on CPU 0 (megaraid, 
aic7xxx, firewire_ohci, eth1, aic7xxx)

Here are the interrupt stats after that testing - you can see the 
relationship between IRQs 7 and 11 and the ERR (and, I just noticed, 
also the RES) counts.

cat /proc/interrupts
            CPU0       CPU1
   0:        125          0    XT-PIC-XT-PIC    timer
   1:          2          0    XT-PIC-XT-PIC    i8042
   2:          0          0    XT-PIC-XT-PIC    cascade
   3:          1          0    XT-PIC-XT-PIC
   4:          1          0    XT-PIC-XT-PIC
   5:       4794        279    XT-PIC-XT-PIC    ehci_hcd:usb1
   6:          4          1    XT-PIC-XT-PIC    floppy
   7:    1110109    5323192    XT-PIC-XT-PIC    ohci_hcd:usb3
   8:          0          0    XT-PIC-XT-PIC    rtc0
   9:      28893       5605    XT-PIC-XT-PIC    acpi, sata_nv, ohci_hcd:usb2
  10:      25475       2831    XT-PIC-XT-PIC    sata_sil, Gina24
  11:    5264022    1101395    XT-PIC-XT-PIC    megaraid, aic7xxx, 
firewire_ohci, eth1, aic7xxx
  12:          4          0    XT-PIC-XT-PIC    i8042
  14:          0          0    XT-PIC-XT-PIC    pata_amd
  15:          0          0    XT-PIC-XT-PIC    pata_amd
NMI:         81         78   Non-maskable interrupts
LOC:    2386834    1935552   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:         81         78   Performance monitoring interrupts
IWI:          0          0   IRQ work interrupts
RES:    1343954    5673656   Rescheduling interrupts
CAL:      10113      12523   Function call interrupts
TLB:        859        674   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:        493        493   Machine check polls
ERR:    6233341
MIS:          0

BTW, the Firewire audio is now working flawlessly, even with very small 
buffers/low latency (up to the point I run out of CPU). :)

Thanks again,
Chris

