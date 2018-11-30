Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from barracuda2.shentel.net ([204.111.1.145]:9152 "EHLO
        barracuda3.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726644AbeLADBx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Nov 2018 22:01:53 -0500
Received: from smtp1.edbg.cloud.shentel.net (smtp1.edbg.cloud.shentel.net [204.111.2.17]) by barracuda3.shentel.net with ESMTP id TxVqFMzi5wMK5KVB for <linux-rt-users@vger.kernel.org>; Fri, 30 Nov 2018 10:52:04 -0500 (EST)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp1.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 1AB4620343
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Nov 2018 10:52:04 -0500 (EST)
From: Gene Heskett <gheskett@shentel.net>
Subject: Re: git clone of v4.19.1-rt3 fails, unk compression mode, fatal exit twice
Date: Fri, 30 Nov 2018 10:52:03 -0500
References: <201811260830.58983.gheskett@shentel.net> <20181130144647.ay5nkt2ejhhbca6v@linutronix.de>
In-Reply-To: <20181130144647.ay5nkt2ejhhbca6v@linutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201811301052.03239.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

On Friday 30 November 2018 09:46:47 Sebastian Andrzej Siewior wrote:

> On 2018-11-26 08:30:58 [-0500], Gene Heskett wrote:
> > What am I missing on a rpi3b currently running jessie?
> >
> > The error message:
> > pi@picnc:/media/slash $ git clone
> > git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> > v4.19.1-rt3 Cloning into 'v4.19.1-rt3'...
> > remote: Counting objects: 6894009, done.
> > remote: Compressing objects: 100% (1061586/1061586), done.
> > Receiving objects: 100% (6894009/6894009), 1.25 GiB | 1.22 MiB/s,
> > done. remote: Total 6894009 (delta 5798755), reused 6870334 (delta
> > 5786550) error: inflate: data stream error (unknown compression
> > method) fatal: serious inflate inconsistency
> > error: inflate: data stream error (unknown compression method)
> > fatal: recursion detected in die handler
> > fatal: index-pack failed
> >
> > And it leaves no evidence that a v4.19.1-rt3 tree ever existed on
> > that machines 64GB ssd drive, currently 7% occupied. Weird.
>
> Works here on a Jessie i386 box.
> Does dmesg show any problems?

yes. I have a 60GB ssd thats usb attached, and partitioned as a swap of 10GB, and 50GB of /media/slash. htop says  106 megs used, 
out of 9,999 megs,
and its full of this:

scsi_io_completion: 2 callbacks suppressed
[1980165.328894] sd 1:0:0:0: [sdb] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=0x08
[1980165.328928] sd 1:0:0:0: [sdb] tag#0 Sense Key : 0xb [current]
[1980165.328936] sd 1:0:0:0: [sdb] tag#0 ASC=0x47 ASCQ=0x1
[1980165.328946] sd 1:0:0:0: [sdb] tag#0 CDB: opcode=0x2a 2a 00 00 22 5a 98 00 00 f0 00
[1980165.328951] blk_update_request: 2 callbacks suppressed
[1980165.328955] blk_update_request: I/O error, dev sdb, sector 2251416
[1980165.328991] Write-error on swap-device (8:16:2251424)
[1980165.329006] Write-error on swap-device (8:16:2251432)
[1980165.329019] Write-error on swap-device (8:16:2251440)
[1980165.329056] Write-error on swap-device (8:16:2251448)
[1980165.329067] Write-error on swap-device (8:16:2251456)
[1980165.329078] Write-error on swap-device (8:16:2251464)
[1980165.329088] Write-error on swap-device (8:16:2251472)
[1980165.329099] Write-error on swap-device (8:16:2251480)
[1980165.329109] Write-error on swap-device (8:16:2251488)
[1980165.329120] Write-error on swap-device (8:16:2251496)
[1980165.329131] Write-error on swap-device (8:16:2251504)
[1980165.329141] Write-error on swap-device (8:16:2251512)
[1980165.329180] Write-error on swap-device (8:16:2251520)
[1980165.329191] Write-error on swap-device (8:16:2251528)
[1980165.329203] Write-error on swap-device (8:16:2251536)
[1980165.329213] Write-error on swap-device (8:16:2251544)
[1980165.329224] Write-error on swap-device (8:16:2251552)
[1980165.329235] Write-error on swap-device (8:16:2251560)
[1980165.329245] Write-error on swap-device (8:16:2251568)
[1980165.329256] Write-error on swap-device (8:16:2251576)
[1980165.329267] Write-error on swap-device (8:16:2251584)
[1980165.329302] Write-error on swap-device (8:16:2251592)
[1980165.329313] Write-error on swap-device (8:16:2251600)
[1980165.329323] Write-error on swap-device (8:16:2251608)
[1980165.329334] Write-error on swap-device (8:16:2251616)
[1980165.329345] Write-error on swap-device (8:16:2251624)

> What kernel do you run that box? 
> uname -a
Linux picnc 4.4.4-rt9-v7+ #7 SMP PREEMPT RT Mon Mar 7 14:53:11 UTC 2016 armv7l GNU/Linux

> > Clues will be checked out.
> >
> > Thanks
>
> Sebastian

I've commented out the swap partition in the fstab, and will attempt 
another mkswap after I reboot it, brb.

This thing was originally set up for a 100meg swapfile on the u-sd card. 
So my fstab may not be correct for a partition.

And its telling me its mounted, even a mkswap -c is rejected. But "mount" 
says no swap, while htop says 99 megs. WTH? This error is occurring when 
swap is used up if its the swapFILE. Called /var/swap.

This git clone command has worked a couple times before I tried to move 
swap off the u-sd with this entry in fstab:

UUID=7b06d9bc-18f2-4c25-957d-f426141664b3 none swap   defaults,nofail 0 0

Now if I uncomment that line, I still show the swapfile of 99 megs in htop.

Call me confuzzled. Can that kernel not use a swap partition? There are 
2 similar ssd's plugged in via usb. There is this after reboot in the 
new dmesg:

[    4.738004] usb-storage 1-1.3:1.0: USB Mass Storage device detected
[    4.738399] usb-storage 1-1.3:1.0: Quirks match for vid 174c pid 55aa: 400000
[    4.738490] scsi host1: usb-storage 1-1.3:1.0
[    5.032141] scsi 0:0:0:0: Direct-Access     SPCC Sol id State Disk    0405 PQ: 0 ANSI: 6
[    5.033851] sd 0:0:0:0: [sda] 125045424 512-byte logical blocks: (64.0 GB/59.6 GiB)
[    5.034576] sd 0:0:0:0: [sda] Write Protect is off
[    5.034587] sd 0:0:0:0: [sda] Mode Sense: 47 00 00 08
[    5.035328] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.043033]  sda: sda1 sda2 sda3
[    5.050024] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.768150] scsi 1:0:0:0: Direct-Access     ADATA SU 650              0    PQ: 0 ANSI: 6
[    5.769820] sd 1:0:0:0: [sdb] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[    5.770547] sd 1:0:0:0: [sdb] Write Protect is off
[    5.770559] sd 1:0:0:0: [sdb] Mode Sense: 43 00 00 00
[    5.771290] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.783454]  sdb: sdb1 sdb2
[    5.790430] sd 1:0:0:0: [sdb] Attached SCSI disk
[...]
[    9.049887] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    9.261797] EXT4-fs (sdb2): mounted filesystem with ordered data mode. Opts: (null)
[    9.452923] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
[    9.759943] systemd-journald[177]: Received request to flush runtime journal from PID 1
[   11.240820] smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of remote wakeup
[   11.241190] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   12.845222] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   12.846880] smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xC1E1
[   15.589907] Adding 102396k swap on /var/swap.  Priority:-1 extents:9 across:9134080k SSFS
pi@picnc:~ $

So this does not look like your problem, but where should I take it?
                                                       
-- 
Cheers, Gene Heskett
--
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
