From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [(RT RFC) PATCH v2 1/9] allow rt-mutex lock-stealing to
 includelateral priority
Date: Mon, 3 Mar 2008 10:55:09 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0803031051410.19405@gandalf.stny.rr.com>
References: <20080225155959.11268.35541.stgit@novell1.haskins.net>
 <20080225160043.11268.83915.stgit@novell1.haskins.net>
 <Pine.LNX.4.58.0803030944530.18766@gandalf.stny.rr.com> <47CBD5CD.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, bill.huey@gmail.com,
	kevin@hilman.org, tglx@linutronix.de, cminyard@mvista.com,
	dsingleton@mvista.com, dwalker@mvista.com,
	Moiz Kohari <MKohari@novell.com>,
	Peter Morreale <PMorreale@novell.com>,
	Sven Dietrich <SDietrich@novell.com>, dsaxena@plexity.net,
	acme@redhat.com, ak@suse.de, gregkh@suse.de, npiggin@suse.de,
	pavel@ucw.cz, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:65152 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029AbYCCPzM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Mar 2008 10:55:12 -0500
In-Reply-To: <47CBD5CD.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 3 Mar 2008, Gregory Haskins wrote:

> >>> On Mon, Mar 3, 2008 at 10:13 AM, in message
> >
> > See the issue. The RT task on CPU0 may experience huge latencies.
>
> Agreed, but equal priority threads can always cause unbounded latencies by definition.  I.e. we only guarantee to the highest thread.

It should not when they are bounded to two separate CPUs, and are the
highest priority tasks on those CPUS.  That will be hard to explain, how a
the highest prio tasks bounded to a single CPU had an unbounded latency.
With the patches presented, this can happen.

>
> > Remember, RT is worried about latencies over performance.
> > If we can not ***guarantee*** a bounded latency, then, I don't care
> > how good the perfomance is, it is not good enough for RT.
> >
> >
> > That said, here's the compromise.
> >
> > Non-RT tasks care more about overall perfomance than worst case latencies.
> > So.... See imbedded:
>
> This isn't a bad idea, but note that it means RT tasks will not get a performance boost, which is quite substantial.

Again, no performance is good enough for an RT task if it risks the
slightest chance of causing an unbounded latency.

-- Steve

>
> Note that I have substantially cleaned up this patch for the drop I will make later this week (v3).
