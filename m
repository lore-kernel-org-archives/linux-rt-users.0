From: "Mark Knecht" <markknecht@gmail.com>
Subject: Re: 2.6.24-rc2-rt1
Date: Thu, 15 Nov 2007 20:42:10 -0800
Message-ID: <5bdc1c8b0711152042y7d3fcb2cv1161db5a67c391b@mail.gmail.com>
References: <1195152030.13982.48.camel@localhost.localdomain>
	 <5bdc1c8b0711151241j5f1b8427w38d2a286eb6ebb7f@mail.gmail.com>
	 <Pine.LNX.4.58.0711152232100.31778@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Gregory Haskins" <ghaskins@novell.com>,
	"Peter Zijlstra" <a.p.zijlstra@chello.nl>,
	"Daniel Walker" <dwalker@mvista.com>,
	"Paul E. McKenney" <paulmck@us.ibm.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:32518 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269AbXKPEmL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Nov 2007 23:42:11 -0500
Received: by wr-out-0506.google.com with SMTP id 36so773618wra
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Nov 2007 20:42:10 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0711152232100.31778@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Nov 15, 2007 7:39 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 15 Nov 2007, Mark Knecht wrote:
>
>
> > On Nov 15, 2007 10:40 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > > Finally!
> > >
> > > We are pleased to announce 2.6.24-rc2-rt1.
> > >
> > <SNIP>
> >
> > Hi Steve,
> >    Not sure I've ever posted on this list. Always looking to help out
> > at my low level.
> >
> >    Anyway, I tried building the kernel. My 1st two attempts, done
> > running make menuconfig from scratch, didn't boot. I gave up on that
> > for now and tried using make oldconfig from my 2.6.23-rt1 kernel (I'm
> > so far behind!!) and ended up with this error. Not sure it's enough
> > for you to find the bug. If you want/need more or want the config file
> > let me know.
> >
> >    I'm sure this is just me setting inappropriate bits but I figured I
> > might as well send along the info. >/dev/null if it's inappropriate
> > but let me know how to move forward if possible.
> >
> >    As always thanks the the rt-kernel team for all you do.
> >
> > Cheers,
> > Mark
> >
> >   CC      ipc/mqueue.o
> >   CC      ipc/compat_mq.o
> >   LD      ipc/built-in.o
> >   CC      security/security.o
> >   CC      security/dummy.o
> >   CC      security/inode.o
> >   LD      security/built-in.o
> >   CC [M]  security/commoncap.o
> >   CC [M]  security/realcap.o
> > security/realcap.c: In function 'realtime_exit':
> > security/realcap.c:129: error: implicit declaration of function
> > 'mod_unreg_security'
> > security/realcap.c:133: error: implicit declaration of function
> > 'unregister_security'
> > make[1]: *** [security/realcap.o] Error 1
> > make: *** [security] Error 2
> > lightning linux #
>
> Hi Mark,
>
> I guess you enabled the realtime capabilities (Realtime-LSM - Obsolete -)
>
> You could disable that, and try again. I'm not sending a fix (yet)
> because ...
>
>
> Ingo,
>
> Do we still need to have the realtime-lsm.patch? It has been considered
> obsolete for over a year now. Can we finally remove it.
>
> -- Steve
>

Steve,
   I'd forgotten about that package going away. I think I've been
building the interface forever in the kernel but then not actually
using it. I haven't loaded the realtime_lsm driver in a long time.
Certainly back in the 2.6.22 past somewhere since I stopped.

   Anyway, with that change to the config the rest of my old .config
file seems to have worked. The kernel boots. I have Jack running
realtime. No xruns in the few minutes I have left with this task
tonight.

mark@lightning ~ $ uname -a
Linux lightning 2.6.24-rc2-rt1 #4 PREEMPT RT Thu Nov 15 20:33:15 PST
2007 x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
mark@lightning ~ $

   Very good so far. I'll continue to run the kernel over the next few
days and see how things go. Nothing I do these days is a heavy load.
Just desktop work with a little bit of audio but I still run the
realtime kernel.

   Great work!

Cheers,
Mark
