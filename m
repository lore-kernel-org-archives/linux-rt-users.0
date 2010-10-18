From: John Kacur <jkacur@redhat.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Mon, 18 Oct 2010 02:16:07 -0400 (EDT)
Message-ID: <309019044.619711287382567906.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
References: <AANLkTi=Z2gOMi1=FtX6vbJUw68deVRyN7wfMV1jA-0qz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	Daniel James <daniel@64studio.com>,
	Gautam Thaker <gautam.h.thaker@lmco.com>,
	linux-rt-users@vger.kernel.org,
	Bernardo Barros <bernardobarros2@gmail.com>
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:34589 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab0JRGQZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Oct 2010 02:16:25 -0400
In-Reply-To: <AANLkTi=Z2gOMi1=FtX6vbJUw68deVRyN7wfMV1jA-0qz@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


----- "jordan" <triplesquarednine@gmail.com> wrote:

> Hey bernardo,
> 
> i forgot to get back to you, as i have been a bit busy. sorry.
> 
> > Hey jordan,
> >
> > Could you share your optimizations with us? I'm also runnins 2.6.34
> > here (2.6.34.6-54.fc13.x86_64),
> > I have problems with my rt-kernel, it freezes my system (thinkpad
> > w510). Maybe something with video card or whatever, but I don't
> have
> > the time to really investigate what is happening, so I must get the
> > best from the generic kernel for now :-)
> 
> So as i said before, you should check out Zen-kernel.org.... You will
> need to use GIT to get the sources. There are great instructions in
> their documentation section, for both installation on a Fedora system
> and on how to use GIT properly (if you don't know how).
> 
> Once you have gotten the sources, and picked what branch to checkout.
> Run "make localmodconfig" from the kernel's directory. This will trim
> off most of the fat in the kernel.  After that, type "make
> menuconfig", now you will be able to select what other features to
> use
> in your kernel.  I typically disable anything that i don't need.
> 
> The most important things to use for low latency are these:
> 
> BFS scheduler (CPU)  -   this will provide low latency
> BFQ scheduler (IO)  -     this will help tune your io-scheduling
> 
> (there are others, like using 1000hz and making sure "preemption" is
> checked off. but i believe that these should be setup by default,
> have
> a look around the kernel configuration, most settings will have an
> explanation if you select them and then use "help"). you can also
> type
> "?"  and search for a setting which can be very helpful.
> 
> both of these schedulers have tunables. you can reduce latency
> (sometimes at the cost of through put)
> and BFS provides a feature called SCHED_ISO, which can be used with
> the utility "schedtools".   SCHED_ISO can be used to raise priorites
> of an application, for example when i start Jackd (using qjackctl), i
> will start it with:
> 
> schedtools -I -e qjackctl
> 
> This will give all of jack's threads a higher priority, minus the
> main
> jackd thread which will be using FIFO.
> This should give your audio a little more importance than every other
> process running.
> 
> One important note! :    In Zen-kernel's "menuconfig" under general
> setup, there is an option to "automatically use SCHED_ISO for X"  -
> make sure that is disabled, otherwise X might screw with Jackd, and
> you might get xruns.  Usually, this setting is used to speed up the
> desktop experience. Using low latency for audio, you should care more
> about making sure your audio is Number 1!!! (and not X).
> 
> You will also want to optimize the kernel as best as you can, and try
> using CFLAGS. I use some pretty harsh optimizations, that i can't
> really recommend, But try things out for yourself. Read up on GCC and
> how to use CFLAGS (there is good documentation in the gentoo
> handbook), then when you are going to compile specify your flags -
> there is also a section in Zen-kernel called "custom CFLAGS" or
> something like that.
> 
> again some of this you will need to read up on, and experiment with.
> 
> once you have your kernel configured it should be as simple as
> 
> 1. running "make rpm" then,
> 2. installing those rpm's using "rpm -ivh yourkernel.rpm",
> 3. then running "dracut /boot/initramfs-yourkernel.img" and then
> 4. modifying your grub/add your new kernel to it. then reboot.
> 
> Once, you do have a running kernel, you will want to adjust BFS and
> BFQ's tunables. I will show you some examples.  To make things easy
> on
> myself, i just put these into /etc/rc.local (this way they execute on
> startup, and are easily modified, and easy to track changes)::
> 
> echo bfq > /sys/block/sda/queue/scheduler
> 
> # BFQ
> 
> echo 0 > /sys/block/sda/queue/iosched/low_latency       (this one is
> really important)
> 
> echo 8 > /sys/block/sda/queue/iosched/quantum
> 
> echo 140 > /sys/block/sda/queue/iosched/timeout_sync
> 
> echo 200 > /sys/block/sda/queue/iosched/timeout_async
> 
> echo 8 > /sys/block/sda/queue/iosched/max_budget_async_rq
> 
> My BFQ settings may not be optimal for your system, my system is
> junk,
> but after a lot of trial and error
> these values seem to work best for me.
> 
> # BFS
> 
> echo 90 > /proc/sys/kernel/iso_cpu
> 
> echo 2 > /proc/sys/kernel/rr_interval
> 
> BFS only has 2 useful tunables. again play around a bit, but these
> work best for me, by far!
> 
> # Other Kernel settings
> 
> echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
> 
> echo 0 > /proc/sys/vm/laptop_mode
> 
> echo 0 >> /sys/module/snd_hda_intel/parameters/power_save
> 
> echo 64 >> /proc/sys/dev/hpet/max-user-freq
> 
> echo 2048 >> /sys/class/rtc/rtc0/max_user_freq
> 
> hdparm -m16 -B255 --yes-i-know-what-i-am-doing /dev/sda
> 
> Do NOT just copy these, especially my setting for "hdparm" could harm
> your system and cause you problems!
> my setting for hdparm are very specific - hence the
> "--yes-i-know-what-i-am-doing" flag, lol.
> 
> however, the rest are probably okay, or might not apply to your
> hardware.
> 
> I also have other tweaks that i use, in my case i am using Fedora 13,
> so many parts of the system have been recompiled, or taken out. I
> obviously disable compositing desktop, as well as any and all
> services
> that i do not use, i also ditch any and all software i don't use and
> their dependencies. i also modify /etc/fstab using things like the
> "noatime" parameter.  I will show you how mine looks (i'll attach a
> screenshot).
> You will also notice my partition map - everything was divided on
> install. seperate /home, /usr , /var, /tmp and of course / (root).
> this way i can specify different parameters and most importantly home
> and root are seperate!
> 
>  The end result is good though:
> 
> Dell Inspiron 6400
> CoreDuo 1.6ghz
> 1 gig RAM
> ATI x1300
> IntelHDA
> 320gig 5400 rpm HDD
> 
> In the case of Jackd, will have 128 frames with a period of 2.   I
> could run say Ardour with 10-20 tracks, no xruns. I can run many VST
> instruments (using wine) with FX chains, or substantial routings, and
> the only xruns i will get are usually on startup of a given plugin.
> 
> When i am doing post-production, i simply change the frames to 1024,
> then ardour with a boat load or plugins, still wont cause xruns.  In
> my case it has worked out really well.  I am currently using:
> 
> 2.6.35-zen2+
> 
> which works better than the planet CCRMA rt-kernel.  it also works
> better than the puppy linux rt-kernel and better than ubuntu's
> rt-kernel on my hardware. this crappy old dell, actually works quite
> nicely for pro-audio and i have squeezed out a lot of extra
> performance.  I will have to think about what else i am using in the
> kernel that may boost performance, but this should give you a decent
> start.
> 
> Soon this machine will be retired as i only need 2-3 more components
> for my AMD Phenom x4 965 3.40ghz system with 8gig ram DDR3 and a
> 7200rpm HDD - Which will be plenty fast. (especially once i optimize
> it with Open64 compiler).
> 
> if you have any questions, just ask, and again sorry for forgetting
> to
> reply, i have been a busy boy!


It sounds like Jordan is having fun, and that is okay, but for newbies on this list, they should understand that what he is doing, has absolutely nothing to do with the real-time kernel, and the PREEMPT_RT patch.

Thanks
