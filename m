From: Florian Boelstler <euphoria@arcor.de>
Subject: 2.6.26.8-rt16 powerpc and mem=...
Date: Tue, 17 Feb 2009 18:46:23 +0100
Message-ID: <gnet5c$7k2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:39141 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbZBQRqb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2009 12:46:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LZU1e-0006Km-Pe
	for linux-rt-users@vger.kernel.org; Tue, 17 Feb 2009 17:46:30 +0000
Received: from fw-emea.rohde-schwarz.com ([80.246.32.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2009 17:46:30 +0000
Received: from euphoria by fw-emea.rohde-schwarz.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2009 17:46:30 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm currently running 2.6.26.8-rt16 on a custom MPC8540-based board.
I was wondering whether there is any experience reducing the available 
memory using the mem= kernel argument on linux-rt.
(Use case: A specific memory portion is reserved for configuration data, 
which is set by an external system attached over PCI)

It seems that there is a race condition, which is hit during extraction 
of the initrd only if the available memory is reduced.
(For vanilla 2.6.26.8 it works without any problems. The problem occurs 
in 2.6.24.7-rt24 as well)

[...]
RAMDISK: Compressed image found at block 0
crc error
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 140k init
Kernel panic - not syncing: No init found.  Try passing init= option to 
kernel.
Call Trace:
[d7441e90] [c00072c4] show_stack+0x54/0x188 (unreliable)
[d7441ec0] [c0020d58] panic+0x98/0x160
[d7441f50] [c0001bf8] name_to_dev_t+0x0/0x25c
[d7441f60] [c03059e0] kernel_init+0x250/0x284
[d7441ff0] [c000d910] kernel_thread+0x44/0x60

Sometimes the output is slightly different, and init is actually called. 
But the file system is corrupt. E.g.:

[...]
RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (-28 != 7032) 33554432
crc error
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 140k init
init started:  BusyBox v1.1.0 (2007.01.23-00:05+0000) multi-call binary
[...]
EXT2-fs error (device ram0): ext2_check_page: bad entry in directory 
#1594: : directory entry across blocks - offset=0, inode=909341804, 
rec_len=14392, name_len=55
Remounting filesystem read-only
[...]

In a single case Linux even booted without any problems.

Some details about my setup:
- 512MB RAM in total
- Memory available for Linux is reduced to 508M (mem=520192K)
- Linux is booted from U-Boot (v1.2.0), which places the initrd image in 
lowmem below 0x18000000 (initrd_high=0x18000000). This is done because 
Linux seems to not allow having the initrd in highmem. (Output from 
kernel regarding CAMs: "Memory CAM mapping: CAM0=256Mb, CAM1=64Mb, 
CAM2=64Mb residual: 124Mb")




