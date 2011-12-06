From: Chris Edwards <cedwards.linux@cedwards.geek.nz>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Tue, 06 Dec 2011 15:51:00 +1300
Message-ID: <4EDD8314.3060904@cedwards.geek.nz>
References: <4ECCE979.5080109@cedwards.geek.nz> <1322056363.20742.45.camel@frodo> <4ECD7DCC.3000505@ripples.dyndns.org> <1322691017.24563.9.camel@frodo> <4ED9EEB2.6070401@ripples.dyndns.org> <alpine.LFD.2.02.1112031726370.2735@ionos> <4EDAAEFD.9060209@ripples.dyndns.org> <alpine.LFD.2.02.1112041428560.2735@ionos> <4EDCC978.3060401@cedwards.geek.nz> <alpine.LFD.2.02.1112051740510.2735@ionos> <20111205181450.GK7834@aftab> <alpine.LFD.2.02.1112052200190.2735@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Borislav Petkov <bp@amd64.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Borislav Petkov <borislav.petkov@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.kinect.co.nz ([202.74.33.69]:40218 "EHLO kinect.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932842Ab1LFCwY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Dec 2011 21:52:24 -0500
In-Reply-To: <alpine.LFD.2.02.1112052200190.2735@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/12/11 10:02, Thomas Gleixner wrote:
> On Mon, 5 Dec 2011, Borislav Petkov wrote:
>> On Mon, Dec 05, 2011 at 05:56:01PM +0100, Thomas Gleixner wrote:
>>
>>> You could try the following patch. Be aware that it might not work at
>>> all, but I don't expect that you need a fire extinguisher :)

No smoke or flames noted. :)  And that appears to have solved the 
problem.  Firewire audio works, and even after running NetPIPE a couple 
of times over that Ethernet interface, there's only a handful of 
interrupts on the Firewire IRQ (as seems to be normal):

$ cat /proc/interrupts
            CPU0       CPU1
   0:        134          0   IO-APIC-edge      timer
   1:          0          2   IO-APIC-edge      i8042
   3:          0          2   IO-APIC-edge
   4:          0          2   IO-APIC-edge
   6:          0          5   IO-APIC-edge      floppy
   7:          1          0   IO-APIC-edge
   8:          0          0   IO-APIC-edge      rtc0
   9:          0          0   IO-APIC-fasteoi   acpi
  12:          0          4   IO-APIC-edge      i8042
  14:          0          0   IO-APIC-edge      pata_amd
  15:          0          0   IO-APIC-edge      pata_amd
  17:          9        120   IO-APIC-fasteoi   firewire_ohci
  18:       2645       2932   IO-APIC-fasteoi   radeon
  19:          0         46   IO-APIC-fasteoi   snd_gina24
  20:       2590       2357   IO-APIC-fasteoi   ohci_hcd:usb2
  21:        234       9128   IO-APIC-fasteoi   ehci_hcd:usb1, eth0
  22:       1346      10720   IO-APIC-fasteoi   sata_nv, ohci_hcd:usb3
  26:     471010     475803   IO-APIC-fasteoi   eth1
  27:          0          0   IO-APIC-fasteoi   sata_sil
NMI:          7          7   Non-maskable interrupts
LOC:     111328     106458   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:          7          7   Performance monitoring interrupts
IWI:          0          0   IRQ work interrupts
RES:      27286       7746   Rescheduling interrupts
CAL:       1051       5180   Function call interrupts
TLB:        224        229   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:         62         62   Machine check polls
ERR:          1
MIS:          0

Confirming kernel version and options:
[    0.000000] Linux version 3.2.0-rc4-rt5 (root@babelfish) (gcc version 
4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #2 SMP PREEMPT RT Tue Dec 6 14:32:44 
NZDT 2011
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.2.0-rc4-rt5 
root=UUID=ca21e0bf-b7f8-45c3-8fc9-066c4dd6052e ro quiet splash

I'll try reinstalling my other expansion cards and check that all 
remains well.

Thank you very much for the help.  Einfach Klasse!
--
Chris
