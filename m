From: jordan <triplesquarednine@gmail.com>
Subject: Solving Nvidia (blob) latency spikes + convert (nvidia's) semaphores
 into mutexes patches for 331.20 [patches and links provided]
Date: Thu, 5 Dec 2013 16:20:37 -0500
Message-ID: <CAOcfFMzTXoSBJm8Rss6XKugc5knfDfdNaYT34bV=N2qcqeKkeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:62213 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab3LEVUi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Dec 2013 16:20:38 -0500
Received: by mail-vc0-f169.google.com with SMTP id hu19so13965177vcb.0
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Dec 2013 13:20:37 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey list,

I have been experimenting with the nvidia blob, monitoring behavior /
latencies, etc. Through some experimentation, googling/research and
looking over previous nvidia-rt/compat patches from all over the
interwebs; I've put together a few patches for the latest
nvidia-331.20 driver. (probably portable to older 3xx.xx series too).
You can obtain the patches from my Archlinux package (Arch User Repo)
- download the package and extract the patches from the tarball.

https://aur.archlinux.org/packages/nvidia-l-pa/

the PKGBUILD file, (which is a build script (for Arch/ABS pakcages)
much like bsd/ports, gentoo /portage for those unfamiliar) shows how I
patch/install the driver For Archlinux - although, obviously different
distros do this different - so; DISCLAIMER: I'm not the person to ask
for help :)
---

1. nvidia-rt_no_wbinvd.patch - It turns out that nvidia uses wbinvdt()
<An intel instruction> that through it's operations, in a nutshell,
ends up halting all cpus - which is the source of nearly all pain when
using nvidia-rt. :\  ...

WBINVD: http://www.jaist.ac.jp/iscenter-new/mpc/altix/altixdata/opt/intel/vtune/doc/users_guide/mergedProjects/analyzer_ec/mergedProjects/reference_olh/mergedProjects/instructions/instruct32_hh/vc323.htm

nvidia-rt_no_wbinvd.patch disables that behavior. The patch is used
along with (2.) nvidia-rt_explicit.patch <failing to do so will result
in X not starting>, but the kernel module will still load.

* expect an nvidia-rt/linux-rt system to report VERY impressive
results in Cyclictest. (any places you used to see latency spikes
should be reduced to almost (or) nothing. (ie: competative with OSS
drivers).
----

2. nvidia-rt_explicit.patch - i wrote this patch for nvidia-325.xx
because skipping the PREEMPT_RT_FULL check, while resulting in a
driver that could compile/install - it still deadlocked. So this patch
just explicitly sets CONFIG_PREEMPT_RT_FULL (1). (which also allows
the 1st patch to work).

Lastly (but not needed to test the latency spikes, just use the above two);
----

3. nvidia-rt_mutexes.patch - Lastly, as the name of the patch implies;
this patch converts all of the semaphores in the nvidia driver into
(regular) mutexes. Nvidia had moved some around some of the semaphore
code in the 3xx.xx series, but i found them all.   1st off - * this
patch will likely kill any scheduling type-bugs encountered when using
the semaphore version. (i have yet to see any 'complaints' in the last
few days of uptime).

* (especially) this last patch I would (Please!) like someone with
more experience to look at for me, if at all possible? It would be
greatly appreciated -> I hack a bit, but am not an accomplished
programmer, so making a rookie mistake is not out of the question. ~
That is why i do not have the feature enabled for users, as it is
commented out.). That being said; I have tortured/tested the hell out
of my system using the nvidia-rt_mutexes (all patches combined) and
nvidia. (very deterministic,  great cyclictest results, just
fantastic).

Anyway, I thought i should share, as i know there are some nvidia-rt
users subbed to the list and my hope is someone can also review these
patches, help fix them up, etc... as like i said - not much of a
programmer, so expertise would be helpful ;)

cheerz

Jordan

PS: I've also taken the time to 'rattle nvidia's cage' on this issue,
feel free to pipe in on my thread, if you like;
https://devtalk.nvidia.com/default/topic/654639/linux/nvidia-using-wbinvdt-lt-an-intel-instruction-gt-causes-huge-latency-spikes-/
