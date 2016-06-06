From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: RT, what to do about up/down_read_non_owner()
Date: Mon, 06 Jun 2016 11:07:08 +0200
Message-ID: <1465204028.11062.3.camel@gmail.com>
References: <1465109869.4263.23.camel@gmail.com>
	 <c3b6168e-dde1-fb3b-36e6-5ff4c75e7355@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38201 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbcFFJHL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2016 05:07:11 -0400
Received: by mail-wm0-f54.google.com with SMTP id m124so62832534wme.1
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jun 2016 02:07:11 -0700 (PDT)
In-Reply-To: <c3b6168e-dde1-fb3b-36e6-5ff4c75e7355@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2016-06-06 at 09:49 +0200, Sebastian Andrzej Siewior wrote:
> On 06/05/2016 08:57 AM, Mike Galbraith wrote:
> > Greetings,
> > 
> > In v4.7, Al added those buggers to NFS.  BCACHE is disabled in RT
> > because of same.. but that's a somewhat suboptimal solution for
> > something as widely used as NFS.
> > 
> > Suggestions?  I reverted the offending commit to get 4.7-rt up and
> > running, but that's not gonna fly long term.
> 
> This API should be avoided according to the comment and completions
> should be used. I am for removal of those. Were the locking people okay
> with this change in the first place or did this just sneak in?

It just snuck in.  Al reworked sillyunlink, whacking the wait_event()
stuff that was there, using annoying $subject instead.

	-Mike
