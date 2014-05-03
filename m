From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch 0/6] 3.14-rt1 fixes
Date: Sat, 03 May 2014 17:24:15 +0200
Message-ID: <1399130655.5326.174.camel@marge.simpson.net>
References: <1399029159.5233.124.camel@marge.simpson.net>
	 <5363840B.6020402@pavlinux.ru>
	 <1399031023.5233.145.camel@marge.simpson.net>
	 <20140503083257.GA16242@opentech.at>
	 <1399113657.5326.58.camel@marge.simpson.net>
	 <20140503123146.GB15945@opentech.at>
	 <1399125807.5326.128.camel@marge.simpson.net>
	 <20140503141901.GA20210@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: pavel@pavlinux.ru, RT <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:50176 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbaECPYT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 May 2014 11:24:19 -0400
Received: by mail-ee0-f43.google.com with SMTP id e51so4006786eek.30
        for <linux-rt-users@vger.kernel.org>; Sat, 03 May 2014 08:24:18 -0700 (PDT)
In-Reply-To: <20140503141901.GA20210@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2014-05-03 at 16:19 +0200, Nicholas Mc Guire wrote: 
> On Sat, 03 May 2014, Mike Galbraith wrote:
> 
> > On Sat, 2014-05-03 at 14:31 +0200, Nicholas Mc Guire wrote: 
> > > On Sat, 03 May 2014, Mike Galbraith wrote:
> > 
> > > > If this is in fact safe, you should be able to move each and every
> > > > migrate_disable() to post acquisition.
> > > 
> > > yup
> > 
> > Having just seen working -> brick transition, color me skeptical.
> > 
> > > > I have a virtual nickle that
> > > > says your box will have a severe allergic reaction to such a patch.
> > > >
> > > Actually that is what the pushdowns in the read_lock/write_lock api did and
> > > I did not notice any of the systems having problems with that.
> > 
> > If you had tested hotplug, you would have met the deadlock, and would
> > have verified that the change to read_lock() was the culprit instead of
> > me doing that.  Steven also verified that.  You too can flip back and
> > forth, drive boxen into the wall as many times as it take to convince
> > yourself that that change really really did induce the breakage.
> >
> 
> I did not test hotplug - I did try and understand the code to

Not testing hotplug was obviously a mistake given what you were
changing.  Nor is that a tiny change, it's a glaringly huge order
change... for read_lock(), with no order change to write_lock().

Things that make ya go hmmm.

> verify the assumptions - but before looking at details of some code
> path (which in my opinion has a few problems of its own) I think it
> would be best to clarify first if the assumptions made for the
> migrate pushdown patches is right or not - if it is not there is no point
> in discussing individual code paths but then that patch set simply needs to 
> go out, if the assumptions are right then we can discuss where the fix is 
> needed.

If your assumptions were correct, there would have been no breakage.

-Mike

