From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.25.4-rt2
Date: Mon, 19 May 2008 21:21:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805192116390.4125@gandalf.stny.rr.com>
References: <1211237032.14697.76.camel@localhost.localdomain>
 <1211242757.19845.48.camel@localhost>  <Pine.LNX.4.58.0805192047060.4125@gandalf.stny.rr.com>
 <1211244545.19845.51.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Kasper Sandberg <lkml@metanurb.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:33477 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbYETBV2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 May 2008 21:21:28 -0400
In-Reply-To: <1211244545.19845.51.camel@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 20 May 2008, Kasper Sandberg wrote:
> >
> > Also could you try this:
> >
> >  # sysctl kernel.sched_nr_migrate = 4
> >
> > or try 2.
> I am afraid i do not have this proc entry.
>
> my .config is as follows:

You need to set SCHED_DEBUG which is dependent on DEBUG_KERNEL.

-- Steve

