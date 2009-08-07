From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RT] Lockdep warning on boot with 2.6.31-rc5-rt1.1
Date: Fri, 07 Aug 2009 18:49:45 +0200
Message-ID: <1249663785.32113.754.camel@twins>
References: <Pine.LNX.4.44L0.0908071241170.4758-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"greg@kroah.com" <greg@kroah.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Kay Sievers <kay.sievers@vrfy.org>
To: Alan Stern <stern@rowland.harvard.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:53407 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbZHGQuH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Aug 2009 12:50:07 -0400
In-Reply-To: <Pine.LNX.4.44L0.0908071241170.4758-100000@iolanthe.rowland.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-08-07 at 12:45 -0400, Alan Stern wrote:
> On Fri, 7 Aug 2009, Peter Zijlstra wrote:

> > The other proposal was creating a fixed list of classes and register
> > each device at a class corresponding to its depth in the tree. I can't
> > remember what was wrong with that, but I seem to have been persuaded
> > that that was hard too.
> 
> It probably would work for the most part.  However a possible scenario
> involves first locking a parent and then locking all its children.  (I
> don't know if this ever happens anywhere, but it might.)  This can't
> cause a deadlock but it would run into trouble with depth-based
> classes.

If you know which parent is locked, we can solve that with
mutex_lock_nest_lock() [ doesn't currently exist, but is analogous to
spin_lock_nest_lock() ] and together with
http://lkml.org/lkml/2009/7/23/222 that would allow you to lock up to
2048 children.

Would something like that work?

