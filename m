From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH] preempt: Debug for possible missed preemption
 checks
Date: Thu, 16 Jan 2014 21:12:14 -0800
Message-ID: <20140116211214.581197e5.akpm@linux-foundation.org>
References: <20140116235751.084728c8@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33162 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaAQFKF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Jan 2014 00:10:05 -0500
In-Reply-To: <20140116235751.084728c8@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 16 Jan 2014 23:57:51 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:

> When PROVE_LOCKING and PREEMPT is configured, the preempt state
> tracking is active. Testing this out, I added a module that did the
> following:

So I assume your kernel at least has no instances of this bug, so we
don't need the patch ;) It *is* a fairly daft thing to do.

Maybe stick it in -next for a few months, see if anyone hits it?
