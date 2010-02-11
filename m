From: "Leggo, Adam (UK)" <Adam.Leggo2@baesystems.com>
Subject: RE: Converting a device driver for real time kernel
Date: Thu, 11 Feb 2010 10:57:38 -0000
Message-ID: <B5339992F194184BABF87ECF0296990D02717616@GLKMS2105.GREENLNK.NET>
References: <B5339992F194184BABF87ECF0296990D02716BA7@GLKMS2105.GREENLNK.NET> <alpine.LFD.2.00.1002092317420.2811@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ukmta3.baesystems.com ([20.133.40.55]:28904 "EHLO
	ukmta3.baesystems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab0BKK5o (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Feb 2010 05:57:44 -0500
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LFD.2.00.1002092317420.2811@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Thanks for all the suggestions. I will start testing them soon.

I have uploaded the driver code, if anyone wants a look:
http://dl.dropbox.com/u/4618054/nsl_driver.zip
Some restricted application code has been removed, but the driver code
is all GPL.

Using the existing RT kernel, I have enabled debugging in the driver and
the crash output from dmesg is below.

Regards
Adam Leggo

START dmesg dump

GTDBG: dcfiIoctl()
GTDBG: <4>dcfiIoctlXfer begin
GTDBG: dcfiXferChunk() begin
GTDBG: dcfiXferChunk() end
GTDBG: <4>dcfiIoctlXfer end
GTDBG: dcfiIoctl() exit...
GTDBG: dcfiIoctl()
GTDBG: <4>dcfiIoctlXfer begin
stopped custom tracer.
Unable to handle kernel NULL pointer dereference at 0000000000000028
RIP: 
<6>GTDBG: dcfiXferChunk() end
 [<ffffffff80255b58>] lock_hrtimer_base+0x18/0x60
PGD 5848c7067 PUD 584d19067 PMD 0 
Oops: 0000 [1] PREEMPT SMP 
last sysfs file: /devices/pci0000:00/0000:00:00.0/irq
CPU 1 
Modules linked in: dcfi_nsl_module nfsd exportfs lockd nfs_acl sunrpc
ipv6 button sg battery ac st apparmor<6>GTDBG: <4>dcfiIoctlXfer end
 xfs loop dm_mod usbhid hid ff_memless generic nx_nic ide_core ipmi_si
uhci_hcd ehci_hcd usbcore ipmi_msghandler firmware_class rtc_cmos
rtc_core rtc_lib reiserfs edd fan thermal processor cciss ata_piix
libata sd_mod scsi_mod
Pid: 7023, comm: nsltp Tainted: G      N 2.6.22.19-0.14-rt #1
RIP: 0010:[<ffffffff80255b58>]  [<ffffffff80255b58>]
lock_hrtimer_base+0x18/0x60
RSP: 0018:ffff81057d9afb38  EFLAGS: 00010292
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff810308c50b30
RDX: ffff81058c080040 RSI: ffff81057d9afb68 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff81057d9ae000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8021cec0 R12: ffff81057d9afb68
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000292
FS:  0000000041001940(0063) GS:ffff81059762e5c0(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 000000058d250000 CR4: 00000000000006e0
Process nsltp (pid: 7023, threadinfo ffff81057d9ae000, task
ffff81058c080040)
Stack:  0000000000000000 00000000ffffffff 0000000000000004
ffffffff80255c08
 0000000000000004 ffffffff8025e97d 0000000000400040
0000000000000000<6>GTDBG: dcfiIoctl() exit...

 ffff810308c50b08 ffffffff80255c76 0000000000000000 ffffffff80468cd2
Call Trace:
GTDBG: dcfiXferChunk() end
GTDBG: <4>dcfiIoctlXfer end
GTDBG: dcfiIoctl() exit...
 [<ffffffff80255c08>] hrtimer_try_to_cancel+0x18/0x70
GTDBG: dcfiIoctl()
 [<ffffffff8025e97d>] do_try_to_take_rt_mutex+0x16d/0x1b0
 [<ffffffff80255c76>] hrtimer_cancel+0x16/0x20
GTDBG: <4>dcfiIoctlXfer begin
GTDBG: dcfiXferChunk() begin
 [<ffffffff80468cd2>] rt_mutex_slowlock+0x242/0x2d8
 [<ffffffff8025f4fd>] rt_down+0x1d/0x60
 [<ffffffff8843c5cd>] :dcfi_nsl_module:dcfiIoctlXfer+0x4bd/0x6a0
GTDBG: dcfiIoctl()
GTDBG: <4>dcfiIoctlXfer begin
GTDBG: dcfiXferChunk() begin
 [<ffffffff8843c965>] :dcfi_nsl_module:dcfiIoctl+0x1b5/0x440
 [<ffffffff8025e97d>] do_try_to_take_rt_mutex+0x16d/0x1b0
 [<ffffffff80468c26>] rt_mutex_slowlock+0x196/0x2d8
 [<ffffffff8843c7b0>] :dcfi_nsl_module:dcfiIoctl+0x0/0x440
 [<ffffffff802bb8b3>] do_ioctl+0x93/0xe0
 [<ffffffff802bb974>] vfs_ioctl+0x74/0x2d0
 [<ffffffff802bbc65>] sys_ioctl+0x95/0xb0
 [<ffffffff8020a04e>] system_call+0x7e/0x83


Code: 48 8b 5d 28 48 85 db 74 33 48 8b 3b e8 87 3b 21 00 49 89 04 
RIP  [<ffffffff80255b58>] lock_hrtimer_base+0x18/0x60
 RSP <ffff81057d9afb38>
CR2: 0000000000000028
GTDBG: dcfiXferChunk() end
GTDBG: <4>dcfiIoctlXfer end
GTDBG: dcfiIoctl() exit...
GTDBG: dcfiXferChunk() end
GTDBG: <4>dcfiIoctlXfer end
GTDBG: dcfiIoctl() exit... 

END dmesg dump

-----Original Message-----
From: Thomas Gleixner [mailto:tglx@linutronix.de] 
Sent: 09 February 2010 22:28
To: Leggo, Adam (UK)
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Converting a device driver for real time kernel


                    *** WARNING ***

  This message has originated outside your organisation,
  either from an external partner or the Global Internet. 
      Keep this in mind if you answer this message.


On Tue, 9 Feb 2010, Leggo, Adam (UK) wrote:

> Hello,
>  
> What is the best way of converting an existing device driver to work 
> under a real-time kernel?
>  
> A device driver provided for a special serial card (Curtiss Wright 
> SL240 sFDFP card http://www.cwcembedded.com/products/0/1/461.html) 
> works under vanilla Linux (SLES SP10 SP2 kernel 2.6.16.60-0.21-smp), 
> but compiling the driver under the real time kernel 
> (2.6.22.19-0.14-rt) the system locks up and crashes. The rt kernel is 
> being used to write large amounts of data from the serial card to disk

> and testing has found the rt kernel has the best consistent write
performance.
>  
> I have gone back to the supplier and they are not interested in 
> developing a real time version of the driver. So I am trying to modify

> the driver myself. The driver code can be provided if anyone wants a 
> look (released under GPLv2).
>  
> Any assistance would be useful.

The problem of the driver is probably broken locking, which needs to be
fixed for !RT as well.

But if you want to fix it your self and need some assistance it would be
helpful if you could:

1) Run against a recent -rt kernel

2) provide a serial console log of the kernel crash

3) run the kernel with CONFIG_PROVE_LOCKING=y and provide the output

4) upload the source to some place so we can at least have a look at
   the code to give you hints.

Thanks,

	tglx



********************************************************************
This email and any attachments are confidential to the intended
recipient and may also be privileged. If you are not the intended
recipient please delete it from your system and notify the sender.
You should not copy it or use it for any purpose nor disclose or
distribute its contents to any other person.
********************************************************************

