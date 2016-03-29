From: Josh Cartwright <joshc@ni.com>
Subject: Re: [4.4.4-rt11] Possiblie recursive locking detected in kswapd /
 mb_cache_shrink_scan()
Date: Tue, 29 Mar 2016 13:20:02 -0500
Message-ID: <20160329182002.GN28102@jcartwri.amer.corp.natinst.com>
References: <20160314210058.GE29798@uudg.org>
 <alpine.DEB.2.11.1603190933150.3978@nanos>
 <20160321144016.GA31276@jcartwri.amer.corp.natinst.com>
 <20160329150444.GD13334@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:34370 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751595AbcC2SUO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 14:20:14 -0400
In-Reply-To: <20160329150444.GD13334@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Mar 29, 2016 at 05:04:44PM +0200, Sebastian Andrzej Siewior wrote:
> * Josh Cartwright | 2016-03-21 09:40:16 [-0500]:
> 
> >diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
> >index 44f0b55..d13428a 100644
> >--- a/include/linux/list_bl.h
> >+++ b/include/linux/list_bl.h
> >@@ -42,13 +42,18 @@ struct hlist_bl_node {
> > 	struct hlist_bl_node *next, **pprev;
> > };
> > 
> >-static inline void INIT_HLIST_BL_HEAD(struct hlist_bl_head *h)
> >-{
> >-	h->first = NULL;
> > #ifdef CONFIG_PREEMPT_RT_BASE
> >-	raw_spin_lock_init(&h->lock);
> >+#define INIT_HLIST_BL_HEAD(h)		\
> >+do {					\
> >+	(h)->first = NULL;		\
> >+	raw_spin_lock_init(&(h)->lock);	\
> >+} while (0)
> >+#else
> >+#define INIT_HLIST_BL_HEAD(h)		\
> >+do {					\
> >+	(h)->first = NULL;		\
> >+} while (0)
> > #endif
> >-}
> 
> So we use a macro instead a "static inline" to ensure we end up with
> another lockdep class?

Yes, that was the idea.

> This surprises me because it would mean that the function wasn't
> inlined / key classed was re-used.

Hmm.  I'm not sure that's what this means.  I think it's possible that
the function _code_ is inlined, but any function static data is shared
between inlined instances.

This simple experiment seems to also confirm this:

	extern void do_something(int *x);
	
	static inline void experiment_static(void)
	{
		static int x;
		do_something(&x);
	}
	
	#define experiment_macro()		\
		do {				\
			static int x;		\
			do_something(&x);	\
		} while (0)
	
	void f(void)
	{
		asm("# static1");
		experiment_static();
		asm("# static2");
		experiment_static();
		asm("# macro1");
		experiment_macro();
		asm("# macro2");
		experiment_macro();
	}

Generated listing (cleaned up):

	f:
		subq	$8, %rsp
		# static1
		movl	$x.1835, %edi
		call	do_something

		# static2
		movl	$x.1835, %edi
		call	do_something

		# macro1
		movl	$x.1839, %edi
		call	do_something

		# macro2
		movl	$x.1840, %edi
		addq	$8, %rsp
		jmp	do_something
	[..]
		.local	x.1835
		.comm	x.1835,4,4
		.local	x.1840
		.comm	x.1840,4,4
		.local	x.1839
		.comm	x.1839,4,4
		.ident	"GCC: (GNU) 5.3.0"

You can see here that both of the static inlined instances shared the
same 'x.1835' data (and the code is inlined), whereas the macro
instances do not share data.

> Looking at the assembly I see:
> 
> |ffffffff8121fb41:       48 c7 c2 e0 bb d6 82    mov    $0xffffffff82d6bbe0,%rdx
> |ffffffff8121fb48:       48 89 df                mov    %rbx,%rdi
> |ffffffff8121fb4b:       48 c7 c6 30 2b a2 81    mov    $0xffffffff81a22b30,%rsi
> |ffffffff8121fb52:       e8 a9 0e e9 ff          callq  ffffffff810b0a00 <__raw_spin_lock_init>
> ???
> |ffffffff8121fc12:       48 c7 c2 d0 bb d6 82    mov    $0xffffffff82d6bbd0,%rdx
> |ffffffff8121fc19:       48 c7 c6 7b 2e a3 81    mov    $0xffffffff81a32e7b,%rsi
> |ffffffff8121fc20:       48 c7 07 00 00 00 00    movq   $0x0,(%rdi)
> |ffffffff8121fc27:       48 83 c7 08             add    $0x8,%rdi
> |ffffffff8121fc2b:       e8 d0 0d e9 ff          callq  ffffffff810b0a00 <__raw_spin_lock_init>
> 
> rdx holds the third parameter and it is different. What do I miss?

Hmm.  I'm not sure what's going on here for your build.

Here's the relevant listing I get for fs/mbcache.c w/ DEBUG_SPINLOCKS &
PREEMPT_RT_FULL, which shows the same thing as the experiment above (the
class object being shared amongst inline instances):

	mb_cache_create:
	[..]
		movq	$__key.15124, %rdx	#,
		movq	$.LC5, %rsi	#,
		movq	$0, (%rdi)	#, _28->first
		addq	$8, %rdi	#, D.27485
		call	__raw_spin_lock_init	#
	[..]
		movq	$__key.15124, %rdx	#,
		movq	$.LC5, %rsi	#,
		movq	$0, (%rdi)	#, _35->first
		addq	$8, %rdi	#, D.27485
		call	__raw_spin_lock_init	#
	[..]
		.local	__key.15124
		.comm	__key.15124,8,8

  Josh
