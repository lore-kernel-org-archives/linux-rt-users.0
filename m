From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] RESEND: fix cpus_allowed settings
Date: Fri, 7 Mar 2008 10:27:52 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0803071027260.24694@gandalf.stny.rr.com>
References: <20080307120644.7031.14474.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:35287 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbYCGP1z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Mar 2008 10:27:55 -0500
In-Reply-To: <20080307120644.7031.14474.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Fri, 7 Mar 2008, Gregory Haskins wrote:

> Hi Ingo, Steve,
>   I sent this patch a few weeks ago along with the migration_disable
> series.  I think the controversy with the migration_disable feature
> may have resulted in this fix being overlooked.  This patch is against
> -rt, but the bug theoretically affects both -rt and sched-devel/mainline.
> I can also whip up a sched-devel based patch if you like, but I think it
> will apply trivially to both places.
>
> Please consider it for inclusion.
>

Acked-by: Steven Rostedt <srostedt@redhat.com>

-- Steve

