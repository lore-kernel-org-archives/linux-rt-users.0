From: Mike Galbraith <mgalbraith@suse.de>
Subject: Re: SUSE question wrt RT locking primitives
Date: Fri, 13 Apr 2012 16:53:39 +0200
Message-ID: <1334328819.13006.24.camel@marge.simpson.net>
References: <1321235083-21756-1-git-send-email-jkacur@redhat.com>
	 <1321235083-21756-2-git-send-email-jkacur@redhat.com>
	 <20111114165148.GB2372@linux.vnet.ibm.com>
	 <alpine.LFD.2.00.1111141837100.6707@localhost6.localdomain6>
	 <1321303871.5011.6.camel@frodo>
	 <1334295256.9525.60.camel@marge.simpson.net>
	 <1334321895.23924.356.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47362 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111Ab2DMOx6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Apr 2012 10:53:58 -0400
In-Reply-To: <1334321895.23924.356.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-04-13 at 08:58 -0400, Steven Rostedt wrote: 
> On Fri, 2012-04-13 at 07:34 +0200, Mike Galbraith wrote:

> > So that's where the question comes from.  Life would be easier if RT
> > didn't trigger the Dr. Jeckle -> Mr. Hyde thing.  You know all about
> > where what happens to which locks, so I'll just snip what I had quoted
> > and needlessly commented on to keep this as short as possible ;-)
> 
> I have no problem with making those non-GPL, as the original stance of
> -rt back in 2005 was to not have -rt be any different than the vanilla
> kernel in that regards. But I don't know if that policy changed since
> then, nor am I the one that has the authority to remove the GPL tags
> from those functions.

As timing would have it, Thomas changed to ones that the nVidia driver
griped about before I even got the query sent.  I just built and ran it,
it's happy in unmolested form.  Dunno if this will make all RT module
grumbles go away, but the nVidia ones should be toast.

-Mike

