From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] Fix compilation of 2.6.23rc4-rt1 without
	CONFIG_PREEMPT_RT
Date: Mon, 17 Sep 2007 09:37:00 -0700
Message-ID: <1190047020.3253.18.camel@imap.mvista.com>
References: <200709171752.37772.ak@suse.de>
	 <1190044974.4374.80.camel@sven.thebigcorporation.com>
	 <200709171827.25378.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sven-Thorsten Dietrich <sdietrich@novell.com>, mingo@elte.hu,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:1695 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbXIQQjM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 12:39:12 -0400
In-Reply-To: <200709171827.25378.ak@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-09-17 at 18:27 +0200, Andi Kleen wrote:
> On Monday 17 September 2007 18:02:54 Sven-Thorsten Dietrich wrote:
> > On Mon, 2007-09-17 at 17:52 +0200, Andi Kleen wrote:
> > > count_active_rt_tasks() is undefined otherwise.
> > > 
> > 
> > This does fix the compile issue, but RT tasks can exist in !PREEMPT_RT
> > as well.
> 
> That might be, but neither rt_nr_running nor rt_nr_uninterruptible
> exist in a !PREEMPT_RT kernel. So they are presumably managed in a different way.

I think this is the 3rd or 4th fix for this same issue .. It's too bad
the -rt tree doesn't get updated more frequently ..

Daniel
