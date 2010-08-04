From: jordan johnston <triplesquarednine@gmail.com>
Subject: advanced tips for reducing latency?
Date: Wed, 4 Aug 2010 07:03:39 -0400
Message-ID: <AANLkTikqLyNuPgjDhLfVjrhUWzCxocPkM=dh6yAJKq7Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57685 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab0HDLDk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Aug 2010 07:03:40 -0400
Received: by ewy23 with SMTP id 23so1939008ewy.19
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Aug 2010 04:03:39 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hello,

I am new to the list, but not new to using linux for pro-audio and
thus the rt-patches...
I'm looking for possibly some advanced tweaks to further reduce
latency on my system.
things i am already aware of;

1. use a lighter WM

2. reduce disk writes / fine-tune using hdparm, etc.

3. Custom kernel + rt-patch + rtirq(tuned)....

made using Zen-kernel with additional patches, compiled with ICC with
CFLAGS(optimized within reason). Also using a 'Kernel Seed' for lowest
possible footprint i could get.

4. CFQ tunables        ie:  /sys/block/sda/queue/iosched/slice_async
                                      /sys/block/sda/queue/iosched/slice_sync

/sys/block/sda/queue/iosched/quantum , etc....

6. CFS tunables ----> ie:  /proc/sys/kernel/sched_latency_ns

/proc/sys/kernel/sched_min_granularity_ns

/proc/sys/kernel/sched_wakeup_granularity_ns , etc...

(with these three alone, i cut latency in half....)

7. other kernel tunables -----> ie:

/proc/sys/vm/dirty_writeback_centisecs (increased to 15000 for better
IO management)

various controls in /etc/sysctl.conf as well as
/etc/fstab <-----noatime, etc.

also a decent partition scheme, not everything under " / "
which seems to affect performance.

8. Disable unwanted services

9. minimize logging to almost nothing

10. disable/inhibit polling udev (i don't use Hal at all)

11. irq + cpu_affinity (i balance manually)

12. diable hardware not being used including Wifi.

13. removing all "bloat".

Obviously i am aware that with new hardware, faster drive/ram/cpu i
could further reduce latency. But what i am trying
to do is compare several things. CFQ vs. BFQ . CFS vs. BFS, etc. As
well as get the best performance even on crappy hardware.
So for production, as in the setup i use to jam with live and record
with, surprisingly i am not using the rt-patches. Instead i am using
BFS scheduler and BFQ IO scheduler with 2.6.34-zen. I use 32bit Fedora
13, Dell Inspiron 6400 CoreDuo 1.6ghz 1g RAM, 320g SATA... (just my
testing ground, not what i plan to use in the future!)

I am awaiting Planet CCRMA for Fedora 13, but have been testing the
"not so ready" rt-kernel. With my production 2.6.34(BFS/BFQ) kernel. I
am using 128 frames/2 period with no xruns running several VSTi, using
my cheap internal STAC9200 intelHDA card. However, i would like to
chop that number in half, using 64 instead. I believe this should be
possible, as with the "not so ready CCRMA kernel" i was able to get it
down to that, but that kernel isn't solid or reliable as of yet.
(which doesn't have to do with me lowering the latency, it hasn't been
debugged yet. dmesg is filled with errors/warnings). the sound was
fine though.

I also haven't heard of 2.6.34-rt being released. 2.6.34 is a much
better kernel though, so i am hoping i will be able to test it out
soon, and also maybe learn another trick or two along the way. I have
also purchased a firewire audio card, that will arrive nextweek, so
most of this stuff should apply there as well...

anyway, if anyone has any ideas on how i can lower latencies, in a
stable way, not already covered here, then drop me a line!
The idea here is that i will be shortly migrating everything into a 2u
rackmount VSTi/looper/DAW. So i am able to achieve as low of latencies
as the Receptor2 (made by muse research) or say the V-machine, BUT to
not only utilize Wine and VST. I plan to also integrate linux audio
apps as well, such as sooperlooper, ardour and hopefully Loomer's
VST's once i purchase them.

This way i can re-create studio recorded sounds, off-the-floor improv
and looping, but also be able to "switch modes"
and use my rack as a standalone DAW solution.

again, any tips/hacks/tricks are welcome

thanks..

jordan
