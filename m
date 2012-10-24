From: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Wed, 24 Oct 2012 21:32:09 +0200
Message-ID: <op.wmo67vqb6426ze@localhost.localdomain>
References: <alpine.LFD.2.02.1210202133470.2719@ionos>
 <op.wmk8f6m96426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210222029480.2756@ionos>
 <op.wmnlvqm76426ze@localhost.localdomain>
 <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
 <op.wmobxtv66426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210241156380.2756@ionos>
 <op.wmoiyqew6426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210241621060.2756@ionos>
 <op.wmo0g1qc6426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210242037440.2756@ionos>
 <op.wmo45bu46426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210242123570.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
Cc: sven@thebigcorporation.com, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.getmail.no ([84.208.15.66]:53622 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756592Ab2JXTcU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2012 15:32:20 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCE002M8WXUPU10@get-mta-out02.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Wed, 24 Oct 2012 21:32:18 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id B6FCB179BD1C_884242B	for <linux-rt-users@vger.kernel.org>; Wed,
 24 Oct 2012 19:32:18 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 82BFD17AA77B_884242F	for <linux-rt-users@vger.kernel.org>; Wed,
 24 Oct 2012 19:32:18 +0000 (GMT)
Received: from localhost.localdomain ([84.211.57.6])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCE00MYHWXL1H10@get-mta-in02.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Wed, 24 Oct 2012 21:32:18 +0200 (MEST)
In-reply-to: <alpine.LFD.2.02.1210242123570.2756@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 24 Oct 2012 21:24:23 +0200, Thomas Gleixner <tglx@linutronix.de>  
wrote:

> On Wed, 24 Oct 2012, Uwaysi Bin Kareem wrote:
>> On Wed, 24 Oct 2012 20:38:36 +0200, Thomas Gleixner <tglx@linutronix.de>
>> wrote:
>>
>> > On Wed, 24 Oct 2012, Uwaysi Bin Kareem wrote:
>> > > On Wed, 24 Oct 2012 16:27:54 +0200, Thomas Gleixner  
>> <tglx@linutronix.de>
>> > > wrote:
>> > > I can ofcourse always compile with net in, but what I needed was  
>> dmseg
>> > > right?
>> > > Actually I have an old pic of this error.
>> > > http://www.paradoxuncreated.com/tmp/rterror.jpg
>> >
>> > So the ata controller fails. Which driver is in use?
>> >
>> > Thanks,
>> >
>> > 	tglx
>>
>> sata_nv
>
> Ok. Can you please provide dmesg from a working kernel ?

uwaysi@Millennium:~$ dmesg
input: HDA NVidia Line Out Front as  
/devices/pci0000:00/0000:00:10.1/sound/card0/input11
init: udev-fallback-graphics main process (1309) terminated with status 1
init: gdm main process (1336) killed by TERM signal
nvidia 0000:03:00.0: irq 40 for MSI/MSI-X
NVRM: Your system is not currently configured to drive a VGA console
NVRM: on the primary VGA device. The NVIDIA Linux graphics driver
NVRM: requires the use of a text-mode VGA console. Use of other console
NVRM: drivers including, but not limited to, vesafb, may result in
NVRM: corruption and stability problems, and is not supported.
fuse init (API version 7.20)
usb 1-7: reset high-speed USB device number 4 using ehci_hcd
usb 2-5: USB disconnect, device number 2
usb 2-5: new low-speed USB device number 4 using ohci_hcd
input: Logitech USB Optical Mouse as  
/devices/pci0000:00/0000:00:0b.0/usb2/2-5/2-5:1.0/input/input12
hid-generic 0003:046D:C018.0003: input,hidraw0: USB HID v1.11 Mouse  
[Logitech USB Optical Mouse] on usb-0000:00:0b.0-5/input0
usb 2-5: USB disconnect, device number 4
usb 2-5: new low-speed USB device number 5 using ohci_hcd
input: Logitech USB Optical Mouse as  
/devices/pci0000:00/0000:00:0b.0/usb2/2-5/2-5:1.0/input/input13
hid-generic 0003:046D:C018.0004: input,hidraw0: USB HID v1.11 Mouse  
[Logitech USB Optical Mouse] on usb-0000:00:0b.0-5/input0
usb 2-5: USB disconnect, device number 5
usb 2-5: new low-speed USB device number 6 using ohci_hcd
input: Logitech USB Optical Mouse as  
/devices/pci0000:00/0000:00:0b.0/usb2/2-5/2-5:1.0/input/input14
hid-generic 0003:046D:C018.0005: input,hidraw0: USB HID v1.11 Mouse  
[Logitech USB Optical Mouse] on usb-0000:00:0b.0-5/input0
usb 2-5: USB disconnect, device number 6
usb 2-5: new low-speed USB device number 7 using ohci_hcd
input: Logitech USB Optical Mouse as  
/devices/pci0000:00/0000:00:0b.0/usb2/2-5/2-5:1.0/input/input15
hid-generic 0003:046D:C018.0006: input,hidraw0: USB HID v1.11 Mouse  
[Logitech USB Optical Mouse] on usb-0000:00:0b.0-5/input0
usb 2-5: USB disconnect, device number 7
usb 2-5: new low-speed USB device number 8 using ohci_hcd
input: Logitech USB Optical Mouse as  
/devices/pci0000:00/0000:00:0b.0/usb2/2-5/2-5:1.0/input/input16
hid-generic 0003:046D:C018.0007: input,hidraw0: USB HID v1.11 Mouse  
[Logitech USB Optical Mouse] on usb-0000:00:0b.0-5/input0
usb 2-5: USB disconnect, device number 8
usb 2-5: new low-speed USB device number 9 using ohci_hcd
input: Logitech USB Optical Mouse as  
/devices/pci0000:00/0000:00:0b.0/usb2/2-5/2-5:1.0/input/input17
hid-generic 0003:046D:C018.0008: input,hidraw0: USB HID v1.11 Mouse  
[Logitech USB Optical Mouse] on usb-0000:00:0b.0-5/input0
