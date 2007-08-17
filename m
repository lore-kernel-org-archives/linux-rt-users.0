From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Fixes spurious system load spikes in /proc/loadavgrt
Date: Sat, 18 Aug 2007 00:21:06 +0200
Message-ID: <1187389266.7007.119.camel@chaos>
References: <20070817003751.GN3954@unix.sh>
	 <1187323117.23789.55.camel@imap.mvista.com>
	 <1187339967.7007.71.camel@chaos>
	 <1187367845.23789.62.camel@imap.mvista.com>
	 <1187386632.7007.100.camel@chaos>
	 <1187386993.23789.92.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:57987 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754016AbXHQWVM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Aug 2007 18:21:12 -0400
In-Reply-To: <1187386993.23789.92.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-08-17 at 14:43 -0700, Daniel Walker wrote:
> On Fri, 2007-08-17 at 23:37 +0200, Thomas Gleixner wrote:
> 
> > You really start to annoy me. There was a detailed bug description and
> > the code defect is easy to see. If you neither have the interest nor the
> > time to look at the actual _trivial_ _self explaining_ patch, then
> > please look for some other playground to live out your wisenheimer airs
> > and graces.
> 
> I'm not you, and you can't force your opinion of the code on someone
> else. _I_ don't think it was trivial .. I really couldn't care less if
> your annoyed or not .. 

Why is it relevant that you are not me ? 

I do not force my opinion on someone else, but I simply request that
you do not force _your_ rules  based on your personal world view on
people who send _valid_ and _useful_ patches

Also you as the -rt expert who "releases" his own -rt queues should be
able to recognize the value and correctness of such a patch despite the
possibly enhanceable text description. If your only comment on such a
patch consist of your self defined nitpick rules, then you should go
back and read your own mails where you accused others of scaring off
developers instead of embracing them.

Keep this tone up and you are right on the way to make the second entry
of my kernel related kill file right behind the lonely dude who managed
to make it there in 10 years:

http://lkml.org/lkml/2007/4/30/157

> > > If your just going to start flames Thomas take it off list.
> > 
> > Flames are only flames when they happen in public.
> 
> Not really, but either way flames are _bad_ for business.

I don't have any business with you.

	tglx
