From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH RT] push waiting rt tasks to cpus with lower prios.
Date: Tue, 9 Oct 2007 14:14:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710091413290.23629@gandalf.stny.rr.com>
References: <20071009142044.4941.65189.stgit@novell1.haskins.net>
 <Pine.LNX.4.58.0710091054430.21404@gandalf.stny.rr.com>
 <1191944024.4281.72.camel@ghaskins-t60p.haskins.net>
 <1191952777.23198.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	kravetz@us.ibm.com, LKML <linux-kernel@vger.kernel.org>,
	pmorreale@novell.com, sdietrich@novell.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:37042 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbXJISO5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 14:14:57 -0400
In-Reply-To: <1191952777.23198.8.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Tue, 9 Oct 2007, Steven Rostedt wrote:

> This has been complied tested (and no more ;-)
>
>
> The idea here is when we find a situation that we just scheduled in an
> RT task and we either pushed a lesser RT task away or more than one RT
> task was scheduled on this CPU before scheduling occurred.
>
> The answer that this patch does is to do a O(n) search of CPUs for the
> CPU with the lowest prio task running. When that CPU is found the next
> highest RT task is pushed to that CPU.

I don't want that O(n) to scare anyone. It really is a O(1) but with a
K = NR_CPUS. I was saying if you grow the NR_CPUS the search grows too.

-- Steve
