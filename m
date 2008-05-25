From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] x86: enable preemption in delay
Date: Sun, 25 May 2008 11:53:05 -0700
Message-ID: <20080525115305.79c12c8c@infradead.org>
References: <Pine.LNX.4.58.0805242306280.3977@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>, akpm@osdl.org,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark.williams@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Gregory Haskins <ghaskins@novell.com>, Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:46022 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756800AbYEYSzH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 May 2008 14:55:07 -0400
In-Reply-To: <Pine.LNX.4.58.0805242306280.3977@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 24 May 2008 23:11:20 -0400 (EDT)
Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> In git commit 35d5d08a085c56f153458c3f5d8ce24123617faf, Andrew Morton
> placed preempt_disable around the entire delay due to TSC's not
> working nicely on SMP.  Unfortunately for those that care about
> latencies this is devastating! Especially when we have callers to
> mdelay(8).

we used to have a WARN_ON if mdelay was called while preemptable..
maybe we should put that back in?
