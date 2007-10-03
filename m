From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.23-rc9-rt1
Date: Wed, 3 Oct 2007 13:28:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710031327160.31726@gandalf.stny.rr.com>
References: <1191341473.5642.36.camel@localhost.localdomain>
 <4702EA31.4020102@redhat.com> <Pine.LNX.4.58.0710022134430.16284@gandalf.stny.rr.com>
 <47039D4E.7090206@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:33176 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbXJCR3H (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Oct 2007 13:29:07 -0400
In-Reply-To: <47039D4E.7090206@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--

On Wed, 3 Oct 2007, Clark Williams wrote:

> >
> > I could put a hack in that fixes the issue when detected, and still prints
> > out a warning. I'll do that for now, until we find the problem area. I
> > think the first warning probably had the want that corrupted us, and then
> > we got flooded with warnings because we never fixed the situation.
> >
> > Patch coming soon.
> >
> > -- Steve
> >> Ad infinitum. Not sure what you're looking for to be cleared in the enter and exit
> >> functions, but it doesn't look like it's happening after a resume. Didn't seem to
> >> affect the behavior of the kernel, since the network came up and I was able to
> >> function normally (or as normally as I can function).
> >
> > I'd reboot if I were you ;-)
>
> Oh, I did :)
>
> I've since suspended and resumed a couple of more times and have not seen your RCU
> warnings, so it's not completely reproduceable.
>
> Got any debugging code you want me to add, in case it pops up again?
>

OK here's the patch to give a warning and temporarily fix the issue.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.23-rc9-rt1/include/linux/rcupreempt.h
===================================================================
--- linux-2.6.23-rc9-rt1.orig/include/linux/rcupreempt.h
+++ linux-2.6.23-rc9-rt1/include/linux/rcupreempt.h
@@ -108,7 +108,13 @@ DECLARE_PER_CPU(long, dynticks_progress_
 static inline void rcu_enter_nohz(void)
 {
 	__get_cpu_var(dynticks_progress_counter)++;
-	WARN_ON(__get_cpu_var(dynticks_progress_counter) & 0x1);
+	if (unlikely(__get_cpu_var(dynticks_progress_counter) & 0x1)) {
+		printk("BUG: bad accounting of dynamic ticks\n");
+		printk("   will try to fix, but it is best to reboot\n");
+		WARN_ON(1);
+		/* try to fix it */
+		__get_cpu_var(dynticks_progress_counter)++;
+	}
 	mb();
 }

@@ -116,7 +122,13 @@ static inline void rcu_exit_nohz(void)
 {
 	mb();
 	__get_cpu_var(dynticks_progress_counter)++;
-	WARN_ON(!(__get_cpu_var(dynticks_progress_counter) & 0x1));
+	if (unlikely(!(__get_cpu_var(dynticks_progress_counter) & 0x1))) {
+		printk("BUG: bad accounting of dynamic ticks\n");
+		printk("   will try to fix, but it is best to reboot\n");
+		WARN_ON(1);
+		/* try to fix it */
+		__get_cpu_var(dynticks_progress_counter)++;
+	}
 }

 #else /* CONFIG_NO_HZ */
