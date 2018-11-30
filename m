Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from barracuda2.shentel.net ([204.111.1.145]:15691 "EHLO
        barracuda1.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725832AbeLAFOW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 1 Dec 2018 00:14:22 -0500
Received: from smtp1.edbg.cloud.shentel.net (smtp1.edbg.cloud.shentel.net [204.111.2.17]) by barracuda1.shentel.net with ESMTP id uiLJJjE351wykX3L for <linux-rt-users@vger.kernel.org>; Fri, 30 Nov 2018 13:03:34 -0500 (EST)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp1.edbg.cloud.shentel.net (Postfix) with ESMTPSA id B9A9F20343
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Nov 2018 13:03:34 -0500 (EST)
From: Gene Heskett <gheskett@shentel.net>
Subject: Re: git clone of v4.19.1-rt3 fails, unk compression mode, fatal exit twice
Date: Fri, 30 Nov 2018 13:03:34 -0500
References: <201811260830.58983.gheskett@shentel.net> <201811301052.03239.gheskett@shentel.net> <20181130170532.twosu6gdlqg6k2ja@linutronix.de>
In-Reply-To: <20181130170532.twosu6gdlqg6k2ja@linutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201811301303.34229.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

On Friday 30 November 2018 12:05:32 Sebastian Andrzej Siewior wrote:

> On 2018-11-30 10:52:03 [-0500], Gene Heskett wrote:
> > yes. I have a 60GB ssd thats usb attached, and partitioned as a swap
> > of 10GB, and 50GB of /media/slash. htop says  106 megs used, out of
> > 9,999 megs,
> > and its full of this:
> >
> > scsi_io_completion: 2 callbacks suppressed
> > [1980165.328894] sd 1:0:0:0: [sdb] tag#0 UNKNOWN(0x2003) Result:
> > hostbyte=0x00 driverbyte=0x08 [1980165.328928] sd 1:0:0:0: [sdb]
> > tag#0 Sense Key : 0xb [current] [1980165.328936] sd 1:0:0:0: [sdb]
> > tag#0 ASC=0x47 ASCQ=0x1
> > [1980165.328946] sd 1:0:0:0: [sdb] tag#0 CDB: opcode=0x2a 2a 00 00
> > 22 5a 98 00 00 f0 00 [1980165.328951] blk_update_request: 2
> > callbacks suppressed [1980165.328955] blk_update_request: I/O error,
> > dev sdb, sector 2251416 [1980165.328991] Write-error on swap-device
> > (8:16:2251424)
>
> So this does not look good.
>
> > > What kernel do you run that box?
> > > uname -a
> >
> > Linux picnc 4.4.4-rt9-v7+ #7 SMP PREEMPT RT Mon Mar 7 14:53:11 UTC
> > 2016 armv7l GNU/Linux
>
> I see.
>
> > I've commented out the swap partition in the fstab, and will attempt
> > another mkswap after I reboot it, brb.
> >
> > This thing was originally set up for a 100meg swapfile on the u-sd
> > card. So my fstab may not be correct for a partition.
> >
> > And its telling me its mounted, even a mkswap -c is rejected. But
> > "mount" says no swap, while htop says 99 megs. WTH? This error is
> > occurring when swap is used up if its the swapFILE. Called
> > /var/swap.
> >
> > This git clone command has worked a couple times before I tried to
> > move swap off the u-sd with this entry in fstab:

> >
> > UUID=7b06d9bc-18f2-4c25-957d-f426141664b3 none swap  
> > defaults,nofail 0 0
> >
> > Now if I uncomment that line, I still show the swapfile of 99 megs
> > in htop.

It must have a lot higher priority to the use of the file as opposed to 
the disk partition.
> >
> > Call me confuzzled. Can that kernel not use a swap partition? There
> > are 2 similar ssd's plugged in via usb. There is this after reboot
> > in the new dmesg:
> >
> > [    4.738004] usb-storage 1-1.3:1.0: USB Mass Storage device
> > detected [    4.738399] usb-storage 1-1.3:1.0: Quirks match for vid
> > 174c pid 55aa: 400000 [    4.738490] scsi host1: usb-storage
> > 1-1.3:1.0
> > [    5.032141] scsi 0:0:0:0: Direct-Access     SPCC Sol id State
> > Disk    0405 PQ: 0 ANSI: 6 [    5.033851] sd 0:0:0:0: [sda]
> > 125045424 512-byte logical blocks: (64.0 GB/59.6 GiB) [    5.034576]
> > sd 0:0:0:0: [sda] Write Protect is off
> > [    5.034587] sd 0:0:0:0: [sda] Mode Sense: 47 00 00 08
> > [    5.035328] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> > enabled, doesn't support DPO or FUA [    5.043033]  sda: sda1 sda2
> > sda3
> > [    5.050024] sd 0:0:0:0: [sda] Attached SCSI disk
> > [    5.768150] scsi 1:0:0:0: Direct-Access     ADATA SU 650         
> >     0    PQ: 0 ANSI: 6 [    5.769820] sd 1:0:0:0: [sdb] 234441648
> > 512-byte logical blocks: (120 GB/112 GiB) [    5.770547] sd 1:0:0:0:
> > [sdb] Write Protect is off
> > [    5.770559] sd 1:0:0:0: [sdb] Mode Sense: 43 00 00 00
> > [    5.771290] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
> > enabled, doesn't support DPO or FUA [    5.783454]  sdb: sdb1 sdb2
> > [    5.790430] sd 1:0:0:0: [sdb] Attached SCSI disk
> > [...]
> > [    9.049887] EXT4-fs (sda3): mounted filesystem with ordered data
> > mode. Opts: (null) [    9.261797] EXT4-fs (sdb2): mounted filesystem
> > with ordered data mode. Opts: (null) [    9.452923] EXT4-fs (sdb1):
> > mounted filesystem with ordered data mode. Opts: (null) [   
> > 9.759943] systemd-journald[177]: Received request to flush runtime
> > journal from PID 1 [   11.240820] smsc95xx 1-1.1:1.0 eth0: hardware
> > isn't capable of remote wakeup [   11.241190] IPv6:
> > ADDRCONF(NETDEV_UP): eth0: link is not ready [   12.845222] IPv6:
> > ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready [   12.846880]
> > smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xC1E1 [
> >   15.589907] Adding 102396k swap on /var/swap.  Priority:-1
> > extents:9 across:9134080k SSFS pi@picnc:~ $
> >
> > So this does not look like your problem, but where should I take it?
>
> You could try this with a non-RT kernel? My only fear is that v4.4
> might do something wrong with in-kernel FPU but I *think* this is
> fixed. This might corrupt your git's sha1 code if it is also using
> NEON for it.
>
> However, now that I see the SCSI errors in dmesg which suggest that
> this might something else going and your disk/swap is not working
> properly. Based on that it does look like "my problem". It might be
> the USB controller that rejects parts of the transfer because it can't
> act fast enough. If I remember correctly, the !RT version uses NMI
> like code to deal with this which does not work/is disabled on RT.
>
> You might want to enable "debug preempting kernel", "sleeping while
> atomic" and maybe lockdep and check if it complains about something.
>
> Sebastian

I'm not in a position to do that due to its being something called 
u-boot, and no one from the pi forums will tell me how to do a make 
install once I have actually built a new rt kernel, which I've done 
twice now, and since it doesn't use grub, there's no quick and dirty 
reboot to a different, good kernel. I'd have to grab another u-sd card 
and build another bootable card. Because no two cards are alike even if 
the same brand, purchased at the same time & both are marked as 32GB, I 
can't even use dd to make a backup. There are some options 
in /boot/cmdline.txt and config.txt, but I've found thats very fragile 
if I get a typu, requiring I bring the card in here to a reader, and 
edit those files insitu to fix.

This rpi-3b is actually running a mid-sized, 1500 lbs of cast iron, 
sheldon metal lathe thats around 70 yo, converted to be run by linuxcnc 
built in armhf flavor. Making it do things it couldn't do when it was 
new in the early 1950's. And there might be one other similarly wooking 
machine on the planet, I'm the testing lab rat. :)

Now, a progress report, making me think there is more than one bug, the 
other is that I've tried 3 of these realtime kernels, and found that all 
of them are quite good at throwing away keyboard/mouse events from their 
own consoles and its boot sensitive in that if I reboot, I can 
eventually reach a configuration that does work, and will work till the 
next power bump.

So I've now found that using the full UUID in my fstab generates a drive 
not found error buried in the logs, but that if a fresh 
mkswap -c /dev/sda3(takes about half an hour for a 10GB swap) is done, 
and the fstab uses PARTUUID="yadda-yadda", that error goes away.

So then I stopped the swapfile, leaving htop showing 9999 megs of swap 
and empty, then from another console login, watched the git clone run 
with htop.  It took most of an hour, got 72 megs into swap, then died 
from a bad index  compression, just like before but this time complained 
about the partition mounted as /media/slash. So I umounted it and ran 
e2fsck /dev/sda3, quiet for several minutes, and gave it a clean 
condition, no errors IOW.

Now let me make another sd card with a stock jessie lite on it, sometime 
in the next day or 3, and try it again, but first I'll pull the sdb 
cable so theres only one drive. I've found that something is mounting 
this stuff even if those lines are commented out of /etc/fstab.

I have a Dr's apt at 2ish, my saw bones wants to do a light physical 
seeing as how I am a DM-II and just turned 84. I am also the caregiver 
for a wife approaching the end from COPD.

For future reference, I have pulled and built

 linux-rpi-4.14.y-rt
and 
 linux-rt-devel-4.16.18-rt9

both untested because of the lack of a u-boot installer in the Makefile.

Many Thanks Sebastian Andrzej Siewior.

-- 
Cheers, Gene Heskett
--
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
