From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: Hang on 8-way with 2.6.23-rc2-rt2
Date: Tue, 07 Aug 2007 13:27:57 -0400
Message-ID: <1186507677.21381.191.camel@ghaskins-t60p.haskins.net>
References: <1186427253.21381.135.camel@ghaskins-t60p.haskins.net>
	 <1186506217.22044.38.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:32926 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756964AbXHGR3t (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Aug 2007 13:29:49 -0400
In-Reply-To: <1186506217.22044.38.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-08-07 at 10:03 -0700, Daniel Walker wrote:

> Could you drop the following config options and test again?
> 
> #
> # Processor type and features
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> 

Will do.

I have a patch which works around the issue too, which I will forward
momentarily.  It appears as though there is a deadlock either between
two task_rq_locks, or between a task_rq_lock and something else.  The
patch I wrote changes the "double_lock_balance()" function to a full DP
algorithm under contention.  Technically I think the original
implementation was correct which is why my patch is really a workaround:
I think its just plastering over the real issue.  But in any case, the
8-way system is no longer slow and no longer nmi_watchdog/softlockups on
me(*).  Perhaps it will at least help in finding the root cause.

Regards,
-Greg

(*) There are still issues on the 8-way once we get passed this
scheduler problem, however.
