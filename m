From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 7/9][RFC] [PATCH 7/9] cpu/rt: Rework cpu down for
 PREEMPT_RT
Date: Fri, 2 Mar 2012 15:52:06 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1203021518501.2742@ionos>
References: <20120301185527.064629423@goodmis.org> <20120301190346.172835662@goodmis.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43185 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010Ab2CBOwJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Mar 2012 09:52:09 -0500
In-Reply-To: <20120301190346.172835662@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 1 Mar 2012, Steven Rostedt wrote:
> Bringing a CPU down is a pain with the PREEMPT_RT kernel because
> tasks can be preempted in many more places than in non-RT. In
> order to handle per_cpu variables, tasks may be pinned to a CPU
> for a while, and even sleep. But these tasks need to be off the CPU
> if that CPU is going down.
> 
> Several synchronization methods have been tried, but when stressed
> they failed. This is a new approach.

OMG! That hotplug stuff has been ugly as hell already, but you managed
to make it exponentially worse. That's really an achievement.
 
Instead of adding more mess, we should simply fix hotplug. 

We can migrate away all tasks _before_ we run stomp-machine and
prevent that any new tasks go on the cpu which is about to be taken
down. Once all migratable tasks are gone, we only have to deal with
the cpu bound ones, which is not causing such headaches.

So no, I rather keep the current problem than applying that insanity.

Thanks,

	tglx
