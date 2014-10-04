From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Sun, 5 Oct 2014 01:56:41 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1410042312440.4383@nanos>
References: <542A88A8.7060800@steinhoff.de> <alpine.DEB.2.11.1410010058160.4455@nanos> <542BACF1.3090405@steinhoff.de> <CAA7pwKPcT_YvQx9_nvSXCq3sFB3aCRZ-mGWTk4GOvLn0k7c3_w@mail.gmail.com> <542D0689.8050602@steinhoff.de> <542FD0BE.10508@osadl.org>
 <542FE9B4.3060708@steinhoff.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carsten Emde <C.Emde@osadl.org>,
	Patrik Lundquist <patrik.lundquist@gmail.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50819 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaJDX4u (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Oct 2014 19:56:50 -0400
In-Reply-To: <542FE9B4.3060708@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 4 Oct 2014, Armin Steinhoff wrote:
> 8. And your second suspicion is that the ps utility is broken.
>    The question about the operation of "ps" was just a formal one .. sorry.

Well, I'd say it's not formal. Let me cite from your previous mail:

> > > If the app "demo_mn_console" has started its first RT thread, a
> > > lot of other processes/threads are jumping to the highest RT
> > > priority 99!!

Did you ever try to invoke:

# man ps

and try to figure out what the PRI field actually means? Definitely
not.

My version of "man ps" tells me:

       pri         PRI       priority of the process.  Higher number means
                             lower priority.

Can you figure out why your problem analysis

> > > If the app "demo_mn_console" has started its first RT thread, a
> > > lot of other processes/threads are jumping to the highest RT
> > > priority 99!!

causes people on this list to assume that you either are

 - a student seeking advise for his first homework assignement

or 

 - someone completely incompetent trying to make a business by
   abusing a community?

or

 - a person with a severe drug abuse problem which causes reality
   distortion?

but definitely not a business who claims itself to be

 "the Real-Time, Fieldbus, and GUI Experts" [1]


Thanks,

	tglx

[1] http://steinhoff.de/index.htm
