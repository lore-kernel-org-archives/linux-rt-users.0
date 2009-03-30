From: Robin Gareus <robin@gareus.org>
Subject: Re: 2.6.29-rt1+ irqbalance = OOPS
Date: Mon, 30 Mar 2009 15:43:00 +0200
Message-ID: <49D0CC64.5010605@gareus.org>
References: <49CCFBCA.6050702@gareus.org> <49CD03AA.4030000@novell.com> <49CD0BC1.6090305@gareus.org> <alpine.LFD.2.00.0903281536420.3397@localhost.localdomain> <49CE48FD.5040506@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>,
	linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:63774 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbZC3NnN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Mar 2009 09:43:13 -0400
In-Reply-To: <49CE48FD.5040506@gareus.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Robin Gareus wrote:

> The corresponding .config is available at
> http://rg42.org/_media/wiki/kernel/config-2.6.29-rt1.txt

BTW. This is a vanilla 2.6.29 with only the 2.6.29-rt1 patch applied.

> I just tested Fernando's CCRMA 2.6.29-rt1 kernel which is x686 plus
> generic x86-compat (mine is MCORE2) and irqbalance does not produce an
> OOPS there.
> 
> I'll see if can get a dump of the OOPS on Monday using netconsole.

If the netconsole module is loaded, the OOPS is produced without the
Call and Stack Trace (both on local terminal and remote) and the cause
is no longer the keyboard-interrupt but ethernet (IRQ 28)

Starting `irqbalance` still reliably hangs this system (Thinkpad X60s).

------------[ cut here ]------------
kernel BUG at kernel/sched_rt.c:1602!
invalid opcode: 0000 [#1] PREEMPT SMP kernel BUG at kernel/sched_rt.c:1602!
invalid opcode: 0000 [#1] PREEMPT SMP
last sysfs file: /sys/devices/pci0000:00/0000:00:1c.0/0000:02:00.0/irq
Modules linked in: netconsole ipv6 nfsd exportfs nfs lockd nfs_acl
auth_rpcgss sunrpc deflate zlib_deflate twofish twofish_common camellia
serpent blowfish des_generic cbc aes_i586 aes_generic xcbc rmd160
sha256_generic sha1_generic
last sysfs file: /sys/devices/pci0000:00/0000:00:1c.0/0000:02:00.0/irq
Modules linked in: netconsole ipv6 nfsd exportfs nfs lockd nfs_acl
auth_rpcgss sunrpc deflate zlib_deflate twofish twofish_common camellia
serpent blowfish des_generic cbc aes_i586 aes_generic xcbc rmd160
sha256_generic sha1_generic


-=-=-=-=-

# lspci ..

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 02) (prog-if 00 [Normal decode])

# cat /proc/interrupts

          CPU0       CPU1
  0:     416869          0   IO-APIC-edge      timer
  1:       2921          0   IO-APIC-edge      i8042
  8:         48          0   IO-APIC-edge      rtc0
  9:      36105          0   IO-APIC-fasteoi   acpi
 12:      23294          0   IO-APIC-edge      i8042
 14:      19922          0   IO-APIC-edge      ata_piix
 15:          0          0   IO-APIC-edge      ata_piix
 16:          0          0   IO-APIC-fasteoi   uhci_hcd:usb2, yenta,
i915@pci:0000:00:02.0
 17:      51665          0   IO-APIC-fasteoi   uhci_hcd:usb3, ohci1394,
HDA Intel
 18:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4, mmc0
 19:         28          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb5
 28:       2669          0   PCI-MSI-edge      eth1
 29:        449          0   PCI-MSI-edge      iwl3945
NMI:          0          0   Non-maskable interrupts
LOC:      79098     252004   Local timer interrupts
SPU:          0          0   Spurious interrupts
CNT:          0          0   Performance counter interrupts
RES:      86816     141218   Rescheduling interrupts
CAL:       6852       5954   Function call interrupts
TLB:        268        266   TLB shootdowns
TRM:          0          0   Thermal event interrupts
ERR:          0
MIS:          0
