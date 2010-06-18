From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: [PATCH 2/6: v4] lockdep: Make MAX_STACK_TRACE_ENTRIES
 configurable.
Date: Thu, 17 Jun 2010 20:56:11 -0700
Message-ID: <1276833371.16751.9.camel@sven.thebigcorporation.com>
References: <1276554087-3632-1-git-send-email-jkacur@redhat.com>
	 <1276554087-3632-3-git-send-email-jkacur@redhat.com>
	 <1276714154.1745.623.camel@laptop>
	 <alpine.LFD.2.00.1006162213220.28756@localhost.localdomain>
	 <1276723008.2077.9574.camel@twins>
	 <1276723773.3556.65.camel@gandalf.stny.rr.com>
	 <1276763719.27822.3.camel@twins>
	 <alpine.LFD.2.00.1006171039050.22185@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, ghaskins@novell.com
To: John Kacur <jkacur@redhat.com>, mgalbraith@suse.de
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006171039050.22185@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2010-06-17 at 10:46 +0200, John Kacur wrote:
>  Also as I pointed out, in Sven's case it sounds like they may 
> have had a build where they even wanted to decrease it.
> 

I hacked the patch below for SLERT 10 a few years ago, and that's
shipping still.

As you can see from the comment in the patch header, I was aware that
this wasn't a closed case, but rather a stop-gap.

I think if I had spent any more time on it, or run into the issue
repeatedly, my first instinct would have been to do what John did, i.e.
make it configurable.

However, I think that fundamentally, if nesting goes that deep, simply
increasing this define would lead to masking real problems.

So while I hacked this up for a shipping product, with intention to
debug this later, I'd probably favor a proper fix of the offending call
chain upstream.

I do not recall ever trying to decrease it, other than to reproduce the
issue a few times. I never did have time to dig into it further, and we
closed the bug as won't fix for this particular product.

Regards,

Sven


Subject: Increase lockdep's MAX_STACK_TRACE_ENTRIES
From: Sven-Thorsten Dietrich <sdietrich@suse.de>

For large SMP systems, MAX_STACK_TRACE_ENTRIES was too low, and
lockdep would complain. This change addresses the issue on systems
we have tested.

It remains to be determined whether other bugs (e.g. scheduler
balancing issues led to unreasonably deep call chains)

Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>

Index: linux-2.6.22/kernel/lockdep_internals.h
===================================================================
--- linux-2.6.22.orig/kernel/lockdep_internals.h
+++ linux-2.6.22/kernel/lockdep_internals.h
@@ -27,7 +27,7 @@
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the hash_lock.
  */
-#define MAX_STACK_TRACE_ENTRIES	262144UL
+#define MAX_STACK_TRACE_ENTRIES	524288UL
 
 extern struct list_head all_lock_classes;
 
