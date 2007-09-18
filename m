From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Don't sleep in oops_begin()
Date: Tue, 18 Sep 2007 10:30:51 +0200
Message-ID: <1190104251.2995.66.camel@chaos>
References: <200709172012.21102.ak@suse.de> <200709172220.43871.ak@suse.de>
	 <1190074235.3253.135.camel@imap.mvista.com> <200709181005.49542.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Walker <dwalker@mvista.com>,
	Sven-Thorsten Dietrich <thebigcorporation@gmail.com>,
	mingo@elte.hu, linux-rt-users@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:34715 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751232AbXIRIay (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Sep 2007 04:30:54 -0400
In-Reply-To: <200709181005.49542.ak@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Tue, 2007-09-18 at 10:05 +0200, Andi Kleen wrote:
> > > I disagree for the oops case.  You want the simplest possible code
> > > here.
> >
> > If that's true for real time , should be true for mainline right?
> 
> You mean it shouldn't use lockdep etc. there? Yes good point. I can change 
> that

Yes, the oops code path should be as decoupled as possible. We want to
know what happened in the first place and not what consequential damage
is caused by the initial problem.

	tglx
