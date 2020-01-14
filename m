Return-Path: <SRS0=TWee=3D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109DAC33CB2
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACA924690
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 21:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgANVEC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:04:02 -0500
Received: from barracuda2.shentel.net ([204.111.1.145]:59065 "EHLO
        barracuda4.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729039AbgANVDp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:45 -0500
X-ASG-Debug-ID: 1579035822-0ea5c17130cdd4690001-YwjLzG
Received: from mta-out1.edbg.va.oss.shentel.net ([172.26.51.4]) by barracuda4.shentel.net with ESMTP id JZJS2nz3FU5rGCvd for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2020 16:03:42 -0500 (EST)
X-Barracuda-Envelope-From: gheskett@shentel.net
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by mta-out1.edbg.va.oss.shentel.net (Postfix) with ESMTPSA id E453910019C
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2020 16:03:42 -0500 (EST)
From:   Gene Heskett <gheskett@shentel.net>
X-Barracuda-Effective-Source-IP: UNKNOWN[204.111.64.149]
X-Barracuda-Apparent-Source-IP: 204.111.64.149
Organization: none,nada,zip
To:     "linux-rt-users" <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] v5.4.10-rt5
Date:   Tue, 14 Jan 2020 16:03:42 -0500
X-ASG-Orig-Subj: Re: [ANNOUNCE] v5.4.10-rt5
User-Agent: KMail/1.9.10
References: <20200110201430.vl3sxiwntj5o4z74@linutronix.de> <202001141123.29884.gheskett@shentel.net> <CAD56B7dJiZmHHe8AEabXhVq+ugChHgDPqo4YToJr0iycL090jA@mail.gmail.com>
In-Reply-To: <CAD56B7dJiZmHHe8AEabXhVq+ugChHgDPqo4YToJr0iycL090jA@mail.gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202001141603.42585.gheskett@shentel.net>
X-Barracuda-Connect: UNKNOWN[172.26.51.4]
X-Barracuda-Start-Time: 1579035822
X-Barracuda-URL: https://172.26.193.44:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at shentel.net
X-Barracuda-Scan-Msg-Size: 6353
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=WEIRD_PORT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79339
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 WEIRD_PORT             URI: Uses non-standard port number for HTTP
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tuesday 14 January 2020 12:15:37 Paul Thomas wrote:

> On Tue, Jan 14, 2020 at 11:24 AM Gene Heskett <gheskett@shentel.net> 
wrote:
> > On Tuesday 14 January 2020 08:54:30 Paul Thomas wrote:
> > > On Sun, Jan 12, 2020 at 9:44 PM Gene Heskett
> > > <gheskett@shentel.net>
> >
> > wrote:
> > > > On Friday 10 January 2020 15:14:30 Sebastian Andrzej Siewior 
wrote:
> > > > > Dear RT folks!
> > > > >
> > > > > I'm pleased to announce the v5.4.10-rt5 patch set.
> > > > >
> > > > > Changes since v5.4.10-rt4:
> > > > >
> > > > >   - Dick Hollenbeck reported that the printk rework had a
> > > > > negative impact on the 8250 driver if not used as a console.
> > > > > Patch by John Ogness.
> > > > >
> > > > > Known issues
> > > > >      - None
> > > > >
> > > > > The delta patch against v5.4.10-rt4 is appended below and can
> > > > > be found here:
> > > > >
> > > > >
> > > > > https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/p
> > > > >atch -5.4 .10-rt4-rt5.patch.xz
> > > > >
> > > > > You can get this release via the git tree at:
> > > > >
> > > > >
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-deve
> > > > >l.gi t v5.4.10-rt5
> > > >
> > > > I grabbed a copy of this, then turned off anything not needed to
> > > > run LinuxCNC on an rpi4 in armhf config.  Then I noted its make
> > > > had a make deb-pkg option.  But it isn't making what I told it
> > > > to make as I'm sitting here watching it ALL go by. Did I miss
> > > > something in  a make menuconfig that triggered a make all? It
> > > > was supposedly set for armhf. But I'm even seeing x86 stuff go
> > > > by. Obviously I know just enough to screw it up. Point me at the
> > > > right docs for arm builds please.
> > > >
> > > > Hi Gene,
> > >
> > > I recently stumbled into deb-pkg, and it's awesome building up the
> > > source and standard debian packages all in one command, but it
> > > takes the same arguments as a standard make. For rpi4 this is
> > > arm64 not armhf so you probably want something like below to
> > > configure for arm64
> >
> > armhf (32 bit) runs fine in on an RPI4, been doing it for a couple
> > months now. With a 32 bit stack frame, context switch latencies are
> > several microseconds better which linuxcnc loves. However with mesa
> > interface cards handling all the sub-millisecond stuffs and using
> > preempt-rt running in userspace, it all works quite well as the  max
> > latency stays below 200 microseconds 99.99% of the time. Thats well
> > within the servo-thread time of 1 millisecond the mesa cards need.
>
> Ah, makes sense.
>
> > > If you are doing this on the rpi4 you don't need the
> > > CROSS_COMPILE= option.[1][2] make -j4 ARCH=arm64
> > > CROSS_COMPILE=aarch64-elf- defconfig
> > > Or if the kernel you're already running has a /proc/config.gz you
> > > can use that directly (zcat /proc/config.gz > .config).
> > > Then you can use the main make.
> >
> > The kernel I an running was built, by me (queue the raspberry
> > noises), with only the ondemand governer so while its working, its
> > stuck in low gear. And the pi has plenty of cooling.
> >
> > that kernel running now is a 4.19.71-rt24-v7l+ #1 SMP PREEMPT RT,
> > but there has since been added another video speedup option, so ATM
> > I am trying to build a 4.19.94-rt38 announced last week. But the git
> > clone I pulled doesn't have the rt patch. And pulling that patch
> > with curl today fails:
> >
> > pi@rpi4:/media/pi/workspace $ curl
> > http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.9
> >4-rt38.patch.xz
>
> Hmm, this seems fine for me:
>  wget
> https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.94.tar.xz 
> tar xf linux-4.19.94.tar.xz
> cd linux-4.19.94/
>  wget
> http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.94-
>rt38.patch.xz 
> unxz patch-4.19.94-rt38.patch.xz 
> patch -p1 < patch-4.19.94-rt38.patch
I blew away my git clone and followed this, which all worked to here, 
but:
>  make ARCH=armhf defconfig

Makefile:527: arch/armhf/Makefile: No such file or directory
make: *** No rule to make target 'arch/armhf/Makefile'.  Stop.

There is an arch/arm/configs/bcm2835_defconfig however, trying several 
variations of that went all aglay:

pi@rpi4:/media/pi/workspace/linux-4.19.94 $ make ARCH=arm/config/bcm2835 
defconfig
Makefile:527: arch/arm/configs/bcm2835/Makefile: No such file or 
directory
make: *** No rule to make target 'arch/arm/congigs/bcm2835/Makefile'.  
Stop.
pi@rpi4:/media/pi/workspace/linux-4.19.94 $ make 
ARCH=arm/bcm2835_defconfig
Makefile:527: arch/arm/bcm2835_defconfig/Makefile: No such file or 
directory
make[1]: *** No rule to make 
target 'arch/arm/bcm2835_defconfig/Makefile'.  Stop.
Makefile:621: include/config/auto.conf.cmd: No such file or directory
make: *** [Makefile:633: include/config/auto.conf.cmd] Error 2
pi@rpi4:/media/pi/workspace/linux-4.19.94 $ make 
ARCH=arm/bcm2835_defconfig defconfig
Makefile:527: arch/arm/bcm2835_defconfig/Makefile: No such file or 
directory
make: *** No rule to make target 'arch/arm/bcm2835_defconfig/Makefile'.  
Stop.

That msg is not explicit enough for my ancient wet ram to go much 
further.

I can pull in the older .config its running on now, but the last time it 
stripped the whole timers menu with all the preempt-rt stuffs out when I 
did a make menuconfig.

So I'll quit putzing and await instructions before I screw it up again.

Thanks Paul
> > > Hope this helps.
> > >
> > > thanks,
> > > Paul
> >
> > I have a recipe that installs to a u-boot already.
> >
> > Cheers, Gene Heskett
> > --
> > "There are four boxes to be used in defense of liberty:
> >  soap, ballot, jury, and ammo. Please use in that order."
> > -Ed Howdershelt (Author)
> > If we desire respect for the law, we must first make the law
> > respectable. - Louis D. Brandeis
> > Genes Web page <http://geneslinuxbox.net:6309/gene>


Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>
