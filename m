From: "Bill Huey (hui)" <bill.huey@gmail.com>
Subject: Re: [PATCH [RT] 00/14] RFC - adaptive real-time locks
Date: Thu, 21 Feb 2008 13:33:34 -0800
Message-ID: <9810cff90802211333k3d19ca2exf28c18ae5a2b86a@mail.gmail.com>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>
	 <20080221212420.GA20953@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Gregory Haskins" <ghaskins@novell.com>, a.p.zijlstra@chello.nl,
	tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	ak@suse.de, gregkh@suse.de, sdietrich@novell.com,
	pmorreale@novell.com, mkohari@novell.com
To: "Ingo Molnar" <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:8356 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147AbYBUVdg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2008 16:33:36 -0500
Received: by wa-out-1112.google.com with SMTP id v27so198271wah.23
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Feb 2008 13:33:36 -0800 (PST)
In-Reply-To: <20080221212420.GA20953@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It would also help to get the lockdep/lockstat output for those runs
so that more discussion can happen. That framework can be extended to
do all sorts of contention tracking and that is why I took implemented
it in the first place to track the viability of adaptive spins. My
initial results where that about 10 percent (heavier against BKL)
where suitable for adaptive spins and 10 percent roughly for ownership
stealing. The current implementation didn't seem to have those
measurements coded in just yet (unlike my private implementation).

I came to the original conclusion that it wasn't originally worth it,
but the dbench number published say otherwise. It would be a good
thing to get both a precise chunk of instrumentation to show where the
problems are (these number could be skewed by a number of things) as
well as the specific locks that are contended against.

See ya

bill

On Thu, Feb 21, 2008 at 1:24 PM, Ingo Molnar <mingo@elte.hu> wrote:
>  regarding the concept: adaptive mutexes have been talked about in the
>  past, but their advantage is not at all clear, that's why we havent done
>  them. It's definitely not an unambigiously win-win concept.
>
>  So lets get some real marketing-free benchmarking done, and we are not
>  just interested in the workloads where a bit of polling on contended
>  locks helps, but we are also interested in workloads where the polling
>  hurts ... And lets please do the comparisons without the ticket spinlock
>  patch ...
