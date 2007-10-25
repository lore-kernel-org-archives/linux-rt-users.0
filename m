From: Darren Hart <dvhltc@us.ibm.com>
Subject: 2.6.23.rt3 fails to boot on 8 way opteron
Date: Thu, 25 Oct 2007 12:15:18 -0700
Message-ID: <200710251215.18172.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:36749 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbXJYTPt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Oct 2007 15:15:49 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9PJFhxp018191
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Oct 2007 15:15:43 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l9PJFhRh116834
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Oct 2007 13:15:43 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l9PJFgwX019082
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Oct 2007 13:15:43 -0600
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven, 

Per our discussion on irc, here is more context surrounding the crash.  The 
system boots fine with rt1 and the same .config.

Freeing unused kernel memory: 244k freed
Write protecting the kernel read-only data: 1156k
Red Hat nash version 5.1.19.6 starting
Mounting proc filesystem
Mounting sysfs filesystem
Creating /dev
Creating initial device nodes
Setting up hotplug.
Creating block dUSB Universal Host Controller Interface driver v3.0
evice nodes.
LoACPI: PCI Interrupt Link [LPUS] enabled at IRQ 5
ading uhci-hcd.kACPI: PCI Interrupt 0000:00:03.0[A] -> o module
LoadinLink [LPUS] -> g ohci-hcd.ko moGSI 5 (level, low) -> IRQ 5
dule
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:03.0: irq 5, io mem 0xf3fff000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [LPUS] -> GSI 5 (level, low) -> 
IRQ 5
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.1: irq 5, io mem 0xf3ffe000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Loading ehci-hcdACPI: PCI Interrupt 0000:00:03.2[A] -> .ko module
Link [LPUS] -> GSI 5 (level, low) -> IRQ 5
ehci_hcd 0000:00:03.2: EHCI Host Controller
ehci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:03.2: irq 5, io mem 0xf3ffd000
ehci_hcd 0000:00:03.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
Loading jbd.ko module
Loading ext3.ko module
LSCSI subsystem initialized
oading scsi_mod.ko module
Loading sd_mod.ko module
Waiting for driver initialization.
usb 3-4: new high speed USB device using ehci_hcd and address 2
usb 3-4: configuration #1 chosen from 1 choice
hub 3-4:1.0: USB hub found
hub 3-4:1.0: 2 ports detected
Scanning and configuring dmraid Kernel panic - not syncing: Attempted to kill 
init!
supported device
s
Creating rootCall Trace:
 device.
Mounti [<ffffffff802380f3>] panic+0xaf/0x169
ng root filesyst [<ffffffff8024558f>] blocking_notifier_call_chain+0xf/0x11
em.
mount: coul [<ffffffff8023b733>] do_exit+0xb4/0x86a
d not find files [<ffffffff8023bf78>] sys_exit_group+0x0/0x14
ystem '/dev/root [<ffffffff8023bf8a>] sys_exit_group+0x12/0x14
'
Setting up ot [<ffffffff8020be9e>] system_call+0x7e/0x83
her filesystems.

Setting up new root fs
setuproot: moving /dev failed: No such file or directory
no fstab.sys, mounting internal defaults
setuproot: error mounting /proc: No such file or directory
setuproot: error mounting /sys: No such file or directory
Switching to new root and running init.
unmounting old /dev
unmounting old /proc
unmounting old /sys
switchroot: mount failed: No such file or directory

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
