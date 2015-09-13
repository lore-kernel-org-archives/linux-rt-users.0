From: Dave Chinner <david@fromorbit.com>
Subject: Re: [RT XFS] BUG from lockdep in xfs
Date: Mon, 14 Sep 2015 09:50:59 +1000
Message-ID: <20150913235059.GU26895@dastard>
References: <CANGgnMa7jXARYkfCKOgvphunKvVaxRWZcSFgGC1b2m74Dgt+jQ@mail.gmail.com>
 <20150909114451.GA30015@bfoster.bfoster>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Austin Schuh <austin@peloton-tech.com>,
	rt-users <linux-rt-users@vger.kernel.org>, xfs <xfs@oss.sgi.com>,
	Philipp Schrader <philipp@peloton-tech.com>,
	Brian Silverman <brian@peloton-tech.com>
To: Brian Foster <bfoster@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:35281 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753573AbbIMXvD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Sep 2015 19:51:03 -0400
Content-Disposition: inline
In-Reply-To: <20150909114451.GA30015@bfoster.bfoster>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Sep 09, 2015 at 07:44:51AM -0400, Brian Foster wrote:
> On Tue, Sep 08, 2015 at 11:54:07PM -0700, Austin Schuh wrote:
> > I'm running xfstests and got the following BUG with lockdep enabled.
> > I'm running the 4.1.6-rt5 kernel from TI's tree on a TI ARM chip.
> > 
> > Any ideas on what could be causing it, or if it is a real problem?
> > 
> > I see some patches in Dave's latest 4.3 pull request that discuss
> > lockdep.  Are there any ones there that are worth backporting to my
> > 4.1.6 kernel?
> > 
> 
> I suspect Dave's recent rework of the lockdep namespace bits is what you
> want:
> 
> 	0952c818 xfs: clean up inode lockdep annotations

Yes, that works around the issue that causes this:

> > [ 4357.394974] BUG: looking up invalid subclass: 8

i.e. that we have about 15 different subclass annotations for
different inode locking situations we need to shoe horn into 8
subclasses...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
