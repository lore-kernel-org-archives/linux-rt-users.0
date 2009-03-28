From: Robin Gareus <robin@gareus.org>
Subject: Re: 2.6.29-rt1+ irqbalance = OOPS
Date: Sat, 28 Mar 2009 16:57:49 +0100
Message-ID: <49CE48FD.5040506@gareus.org>
References: <49CCFBCA.6050702@gareus.org> <49CD03AA.4030000@novell.com> <49CD0BC1.6090305@gareus.org> <alpine.LFD.2.00.0903281536420.3397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:43470 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbZC1P5z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 28 Mar 2009 11:57:55 -0400
In-Reply-To: <alpine.LFD.2.00.0903281536420.3397@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner wrote:
> On Fri, 27 Mar 2009, Robin Gareus wrote:
>> Gregory Haskins wrote:
>>> Robin Gareus wrote:
>>>> Hello,
>>>>
>>>> Starting the irqbalance daemon ( http://www.irqbalance.org/ ) on
>>>> 2.6.29-rt1 causes the system to OOPS and freeze. irqbalance works fine
>>>> with previous realtime kernels (2.6.24.7-rt27).
>>>>
>>>> The OOPS seems to be caused by the PID of the [timer] IRQ-1
>>> This in of itself might be part of the problem.  I didn't think the
>>> timer was supposed to be threaded.  Thomas?
>> OOPS ;) my bad. IRQ-0 is the timer and it's indeed not threaded.
>>
>> IRQ-1 is i8042
>>
>> The OOPS can be triggered by launching irqbalance. then pressing any key.
>> For whatever reason the OOPS also takes place after a random amount of
>> time without pressing any key..
> 
> Hmm. Works fine here. Can you please provide the output of
> 
> # cat /proc/interrupts
           CPU0       CPU1
  0:    2592396          0   IO-APIC-edge      timer
  1:      31901          0   IO-APIC-edge      i8042
  8:         79          0   IO-APIC-edge      rtc0
  9:     294004          0   IO-APIC-fasteoi   acpi
 12:      55544          0   IO-APIC-edge      i8042
 14:      28478          0   IO-APIC-edge      ata_piix
 15:          0          0   IO-APIC-edge      ata_piix
 16:          0          0   IO-APIC-fasteoi   uhci_hcd:usb1, yenta,
i915@pci:0000:00:02.0
 17:        166          0   IO-APIC-fasteoi   uhci_hcd:usb2, HDA Intel,
ohci1394
 18:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4, mmc0
 19:         66          0   IO-APIC-fasteoi   ehci_hcd:usb3, uhci_hcd:usb5
 28:       1504          0   PCI-MSI-edge      iwl3945
NMI:          0          0   Non-maskable interrupts
LOC:     398393    1538764   Local timer interrupts
SPU:          0          0   Spurious interrupts
CNT:          0          0   Performance counter interrupts
RES:     120526     181396   Rescheduling interrupts
CAL:      42459      30754   Function call interrupts
TLB:        839       1056   TLB shootdowns
TRM:          0          0   Thermal event interrupts
ERR:          0
MIS:          0

The corresponding .config is available at
http://rg42.org/_media/wiki/kernel/config-2.6.29-rt1.txt

I just tested Fernando's CCRMA 2.6.29-rt1 kernel which is x686 plus
generic x86-compat (mine is MCORE2) and irqbalance does not produce an
OOPS there.

I'll see if can get a dump of the OOPS on Monday using netconsole.

HTH,
robin
