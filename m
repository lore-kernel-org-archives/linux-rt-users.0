From: "Mark Knecht" <markknecht@gmail.com>
Subject: Re: 2.6.24-rc2-rt1
Date: Thu, 15 Nov 2007 13:09:28 -0800
Message-ID: <5bdc1c8b0711151309q6a6b1de6q328710a3b009b3ec@mail.gmail.com>
References: <1195152030.13982.48.camel@localhost.localdomain>
	 <5bdc1c8b0711151241j5f1b8427w38d2a286eb6ebb7f@mail.gmail.com>
	 <Pine.LNX.4.58.0711151551570.27347@gandalf.stny.rr.com>
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
Received: from wr-out-0506.google.com ([64.233.184.239]:55759 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbXKOVJa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Nov 2007 16:09:30 -0500
Received: by wr-out-0506.google.com with SMTP id 36so672269wra
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Nov 2007 13:09:29 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0711151551570.27347@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sent.

On Nov 15, 2007 12:54 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> On Thu, 15 Nov 2007, Mark Knecht wrote:
>
> > On Nov 15, 2007 10:40 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > > Finally!
> > >
> > > We are pleased to announce 2.6.24-rc2-rt1.
> > >
> > <SNIP>
> >
> > Hi Steve,
>
> <snip!>
>
> >
> >    As always thanks the the rt-kernel team for all you do.
>
> On behalf of the rt-kernel team, you are welcome ;-)
>
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
> Definitely looks like a config bug. You can send me your config off
> list.
>
> Hmm, I need to do a allyesconfig, but I'm not even sure 2.6.24-rc2 would
> compile with that.
>
> Thanks,
>
> -- Steve
>
