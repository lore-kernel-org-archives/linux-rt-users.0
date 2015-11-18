From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/4] wait.[ch]: Introduce the simple waitqueue (swait)
 implementation
Date: Wed, 18 Nov 2015 11:33:04 +0100
Message-ID: <20151118103304.GD3816@twins.programming.kicks-ass.net>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1445326090-1698-2-git-send-email-daniel.wagner@bmw-carit.de>
 <alpine.DEB.2.11.1511041124530.4032@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35065 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbbKRKd6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Nov 2015 05:33:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1511041124530.4032@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Nov 04, 2015 at 11:33:51AM +0100, Thomas Gleixner wrote:
> On Tue, 20 Oct 2015, Daniel Wagner wrote:
> > +
> > +extern void swake_up(struct swait_queue_head *q);
> > +extern void swake_up_all(struct swait_queue_head *q);
> > +extern void swake_up_locked(struct swait_queue_head *q);
> 
> I intentionally named these functions swait_wake* in my initial
> implementation for two reasons:
> 
>   - typoing wake_up vs. swake_up only emits a compiler warning and does
>     not break the build

-Werror ftw, but yes good point.

>   - I really prefer new infrastructure to have a consistent prefix
>     which reflects the "subsystem". That's simpler to read and simpler
>     to grep for.

I generally agree, but seeing how this is really an 'extension' of
existing infrastructure, I went along with this.

> > +extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
> > +extern void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state);
> > +extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
> > +
> > +extern void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
> > +extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
> 
> Can we please go with the original names?
> 
> swait_prepare()
> swait_prepare_locked()
> swait_finish()
> swait_finish_locked()
> 
> Hmm?
> 
> > +#define swait_event(wq, condition)					\
> 
> Here we have the same swait vs. wait problem as above. So either we
> come up with a slightly different name or have an explicit type check
> in __swait_event event.

Type check macros, otherwise you break the naming scheme you so
adamantly push for (or end up with horrid stuff like
swait_wait_event()).

I suppose we can do the rename as you propose to avoid single letter
typoes, but it does bug me to have two nearly identical bits of infra
with such dissimilar names.
