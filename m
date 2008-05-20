From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.25.4-rt2
Date: Mon, 19 May 2008 20:48:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805192047060.4125@gandalf.stny.rr.com>
References: <1211237032.14697.76.camel@localhost.localdomain>
 <1211242757.19845.48.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Kasper Sandberg <lkml@metanurb.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:54877 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYETAsM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 May 2008 20:48:12 -0400
In-Reply-To: <1211242757.19845.48.camel@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 20 May 2008, Kasper Sandberg wrote:

> On Mon, 2008-05-19 at 18:43 -0400, Steven Rostedt wrote:
> > We are pleased to announce the 2.6.25.4-rt2 tree, which can be
> <snip>
>
> I have just tested this, and it breaks jackd horribly, no matter the
> settings, jack ALWAYS underruns.
>
> What information do you need me to provide?
>

Did it work with 2.6.25.4-rt1?

Also could you try this:

 # sysctl kernel.sched_nr_migrate = 4

or try 2.

Thanks,

-- Steve

