From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: RT, what to do about up/down_read_non_owner()
Date: Tue, 07 Jun 2016 04:39:50 +0200
Message-ID: <1465267190.3931.16.camel@gmail.com>
References: <1465109869.4263.23.camel@gmail.com>
	 <c3b6168e-dde1-fb3b-36e6-5ff4c75e7355@linutronix.de>
	 <1465204028.11062.3.camel@gmail.com> <1465206604.6397.18.camel@gmail.com>
	 <20160606192446.GE14480@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34887 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbcFGCjy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2016 22:39:54 -0400
Received: by mail-wm0-f45.google.com with SMTP id n206so13586050wmf.0
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jun 2016 19:39:53 -0700 (PDT)
In-Reply-To: <20160606192446.GE14480@ZenIV.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2016-06-06 at 20:24 +0100, Al Viro wrote:
> On Mon, Jun 06, 2016 at 11:50:04AM +0200, Mike Galbraith wrote:
> > (CCs Al, who knows, maybe he'll make them go *poof*)
> > 
> > > > > In v4.7, Al added those buggers to NFS.  BCACHE is disabled in RT
> > > > > because of same.. but that's a somewhat suboptimal solution for
> > > > > something as widely used as NFS.
> > > > > 
> > > > > Suggestions?  I reverted the offending commit to get 4.7-rt up and
> > > > > running, but that's not gonna fly long term.
> > > > 
> > > > This API should be avoided according to the comment and completions
> > > > should be used. I am for removal of those. Were the locking people okay
> > > > with this change in the first place or did this just sneak in?
> > > 
> > > It just snuck in.  Al reworked sillyunlink, whacking the wait_event()
> > > stuff that was there, using annoying $subject instead.
> 
> It's more than just wait_event() crap being killed (and crap it certainly
> was).  The situation is pretty much the same as with bcache; we don't want
> readers to stick around until the initiated action has been completed.
> 
> What exactly is RT problem, just to be sure to avoid reproducing exact same
> issue in the replacement?

These primitives take a lock class that's wired for PI, and break it. 
 What RT used to do about that was to create a whole new lock type, and
inject it into the tree wherever non_owner was used.  When non_owner
was killed, RT maintainers happily trashed that workaround.. but then
bcache came along and brought the damn things back from the grave.

	-Mike
