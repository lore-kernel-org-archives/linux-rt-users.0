From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: RT, what to do about up/down_read_non_owner()
Date: Mon, 06 Jun 2016 11:50:04 +0200
Message-ID: <1465206604.6397.18.camel@gmail.com>
References: <1465109869.4263.23.camel@gmail.com>
	 <c3b6168e-dde1-fb3b-36e6-5ff4c75e7355@linutronix.de>
	 <1465204028.11062.3.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Al Viro <viro@ZenIV.linux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37457 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbcFFJuI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2016 05:50:08 -0400
Received: by mail-wm0-f54.google.com with SMTP id k204so19170038wmk.0
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jun 2016 02:50:06 -0700 (PDT)
In-Reply-To: <1465204028.11062.3.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

(CCs Al, who knows, maybe he'll make them go *poof*)

On Mon, 2016-06-06 at 11:07 +0200, Mike Galbraith wrote:
> On Mon, 2016-06-06 at 09:49 +0200, Sebastian Andrzej Siewior wrote:
> > On 06/05/2016 08:57 AM, Mike Galbraith wrote:
> > > Greetings,
> > > 
> > > In v4.7, Al added those buggers to NFS.  BCACHE is disabled in RT
> > > because of same.. but that's a somewhat suboptimal solution for
> > > something as widely used as NFS.
> > > 
> > > Suggestions?  I reverted the offending commit to get 4.7-rt up and
> > > running, but that's not gonna fly long term.
> > 
> > This API should be avoided according to the comment and completions
> > should be used. I am for removal of those. Were the locking people okay
> > with this change in the first place or did this just sneak in?
> 
> It just snuck in.  Al reworked sillyunlink, whacking the wait_event()
> stuff that was there, using annoying $subject instead.
> 
> 	> -Mike
