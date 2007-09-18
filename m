From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] Don't sleep in oops_begin()
Date: Mon, 17 Sep 2007 17:10:35 -0700
Message-ID: <1190074235.3253.135.camel@imap.mvista.com>
References: <200709172012.21102.ak@suse.de>
	 <1190056047.3253.104.camel@imap.mvista.com>
	 <1190057923.3615.26.camel@sven.thebigcorporation.com>
	 <200709172220.43871.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>,
	mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:58001 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbXIRANG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 20:13:06 -0400
In-Reply-To: <200709172220.43871.ak@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-09-17 at 22:20 +0200, Andi Kleen wrote:
> On Monday 17 September 2007 21:38, Sven-Thorsten Dietrich wrote:
> > On Mon, 2007-09-17 at 12:07 -0700, Daniel Walker wrote:
> > > On Mon, 2007-09-17 at 21:00 +0200, Andi Kleen wrote:
> > > > > Since it's all got "__" in the front, not good to use this method all
> > > > > over .. If you just need a real spinlock best to use
> > > > > DEFINE_RAW_SPINLOCK() unless your a special situation ..
> >
> > die_lock has been RAW for a while, see older patches...
> 
> It's definitely not in 2.6.23-rc4-rt1 and also wasn't in the oops
> trace I looked at.
> 
> > but DEFINE_RAW or DECLARE_RAW should be used when possible.
> 
> I disagree for the oops case.  You want the simplest possible code
> here.

If that's true for real time , should be true for mainline right?

Daniel
