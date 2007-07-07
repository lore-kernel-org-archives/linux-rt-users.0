From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.21.5-rt19
Date: Sat, 7 Jul 2007 11:15:27 +0200
Message-ID: <20070707091527.GA21234@elte.hu>
References: <1183582155.3291.160.camel@chaos> <9609.194.65.103.1.1183731007.squirrel@www.rncbc.org> <1183758545.20747.34.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rui Nuno Capela <rncbc@rncbc.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"jcaceres@ccrma.Stanford.EDU" <jcaceres@ccrma.Stanford.EDU>,
	Carsten Emde <carsten.emde@osadl.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:50090 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbXGGJQO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Jul 2007 05:16:14 -0400
Content-Disposition: inline
In-Reply-To: <1183758545.20747.34.camel@cmn3.stanford.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> > Althought I'm still with my fingers crossed, I can tell the good 
> > news are that 2.6.21.5-rt19 (and -rt20) does behave far better now 
> > on the very same box.
> 
> Yes, it works much better indeed...
> 
> Ingo: is there a place where I can read about the changes in different 
> rtxx releases? What is new/better/fixed in rt20? (I see scheduler 
> stuff in a diff from rt19 to rt20 but I don't really know what it 
> means).

rt19 -> rt20 was a pure CFS update - from v18 to v19-almost-final.

	Ingo
