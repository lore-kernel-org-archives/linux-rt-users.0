From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] sched: prioritize non-migratable tasks over migratable
 ones
Date: Wed, 23 Apr 2008 08:58:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0804230854210.23815@gandalf.stny.rr.com>
References: <20080423111313.4981.37345.stgit@novell1.haskins.net>
 <20080423111334.4981.19638.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:51314 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbYDWM6w (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Apr 2008 08:58:52 -0400
In-Reply-To: <20080423111334.4981.19638.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 23 Apr 2008, Gregory Haskins wrote:

>
> There are several details for utilizing this properly.
>
> 1) During task-wake-up, we not only need to check if the priority
>    preempts the current task, but we also need to check for this
>    non-migratable condition.  Therefore, if a non-migratable task wakes
>    up and sees an equal priority migratable task already running, it
>    will attempt to preempt it *if* there is a likelyhood that the
>    current task will find an immediate home.
>
> 2) Tasks only get this non-migratable "priority boost" on wake-up.  Any
>    requeuing will result in the non-migratable task being queued to the
>    end of the shared queue.  This is an attempt to prevent the system
>    from being completely unfair to migratable tasks during things like
>    SCHED_RR timeslicing.
>
> I am sure this patch introduces potentially "odd" behavior if you
> concoct a scenario where a bunch of non-migratable threads could starve
> migratable ones given the right pattern.  I am not yet convinced that
> this is a problem since we are talking about tasks of equal RT priority
> anyway, and there never is much in the way of guarantees against
> starvation under that scenario anyway. (e.g. you could come up with a
> similar scenario with a specific timing environment verses an affinity
> environment).  I can be convinced otherwise, but for now I think this is
> "ok".
>

I'm not giving an Ack on this patch (not yet). My main concern here is
that this is performing on a verge of policy change. As you stated, this
is a known issue. One that can be avoided by giving RT tasks different
priorities.  It is known that two tasks with the same priority fighting
for the same CPUS (even if one is migratable and one is not) has
non-deterministic behaviour.

This patch needs a bit of running through the grind to see what effects it
has before going in.

-- Steve

