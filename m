Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from barracuda2.shentel.net ([204.111.1.145]:38988 "EHLO
        barracuda4.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728617AbeHWRO5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Aug 2018 13:14:57 -0400
Received: from smtp1.edbg.cloud.shentel.net (smtp1.edbg.cloud.shentel.net [204.111.2.17]) by barracuda4.shentel.net with ESMTP id 8XacAh2cDOzqrysV for <linux-rt-users@vger.kernel.org>; Thu, 23 Aug 2018 09:45:02 -0400 (EDT)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp1.edbg.cloud.shentel.net (Postfix) with ESMTPSA id D70522248A
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Aug 2018 09:45:02 -0400 (EDT)
From: Gene Heskett <gheskett@shentel.net>
Subject: Re: SCHED_DEADLINE as user
Date: Thu, 23 Aug 2018 09:45:02 -0400
References: <pl0fsj$ohn$1@blaine.gmane.org> <20180823123739.GC31443@localhost.localdomain> <20180823150040.7da1624f@luca64>
In-Reply-To: <20180823150040.7da1624f@luca64>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201808230945.02854.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

On Thursday 23 August 2018 09:00:40 luca abeni wrote:

> On Thu, 23 Aug 2018 14:37:39 +0200
> Juri Lelli <juri.lelli@gmail.com> wrote:
> [...]
>
> > > > Maybe the existing system wide sched_rt_{period,
> > > > runtime}_us are enough?
> > >
> > > I do not know... A cgroup-based interface looks more powerful (and
> > > not so difficult to implement... :), and would allow the sysadmin
> > > to decide which users can use SCHED_DEADLINE, how much
> > > SCHED_DEADLINE bandwidth can each user/group use, etc...
> >
> > How about extending PAM limits instead? It looks like it's what
> > (e.g.) audio users rely on already [1]. It is maybe possible to add
> > dlruntime, dlperiod, dldeadline parameters in there?
>
> Ok, I do not know much about these PAM limits... Where can I find more
> information? What do we need to implement exactly, to add these
> dlruntime, dlperiod, dldeadline parameters?
>
>
> 			Thanks,
> 				Luca

Are you folks interested in input from a real world user? On who at the 
moment is building about half these kernels as you announce them on a 
pi-3b, the same pi-3b running 1500 lbs of a Sheldon 11"x36" lathe.

I am running linuxcnc on both x86 and armhf machinery, two lathes and two 
milling machines, all being moved by stepper motors.

Steppers, if the steps are being software generated, are very sensitive 
to timing wibbles in a stream of steps, with a 5 microsecond wobble in 
the timing haveing serious effects on the available torque by causing a 
speedup and slowdown.  This severely limits the speed at which the motor 
can be driven without stalling or losing steps, which in a stepper 
system is the equivalent of losing its home reference which=wrecked 
part. I have one machine still depending on software stepping. I could 
easily triple the speed of that machine by spending another 100 dollars 
to offload that to an fpga based interface card. As it is the base 
thread runs at about 28 microseconds. That also represents the 
granularity of a speed change. So it of late has been relegated to doing 
very precise work via EDM, which is slow anyway.

In short, linuxcnc, and its best rtai kernels can do pergaps 10"/minute 
whereas the fpga cards can move that same machine at 100 ipm. Any help 
in getting the latency down means we can do things faster.

LinuxCNC is also run as a common user, never as root.  Thats my $0.02 
from a users viewpoint.

-- 
Cheers, Gene Heskett
--
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
