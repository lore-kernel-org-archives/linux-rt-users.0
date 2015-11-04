From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/4] wait.[ch]: Introduce the simple waitqueue (swait)
 implementation
Date: Wed, 4 Nov 2015 11:33:51 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511041124530.4032@nanos>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de> <1445326090-1698-2-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445326090-1698-2-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 20 Oct 2015, Daniel Wagner wrote:
> +
> +extern void swake_up(struct swait_queue_head *q);
> +extern void swake_up_all(struct swait_queue_head *q);
> +extern void swake_up_locked(struct swait_queue_head *q);

I intentionally named these functions swait_wake* in my initial
implementation for two reasons:

  - typoing wake_up vs. swake_up only emits a compiler warning and does
    not break the build
    
  - I really prefer new infrastructure to have a consistent prefix
    which reflects the "subsystem". That's simpler to read and simpler
    to grep for.

> +extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
> +extern void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state);
> +extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
> +
> +extern void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
> +extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);

Can we please go with the original names?

swait_prepare()
swait_prepare_locked()
swait_finish()
swait_finish_locked()

Hmm?

> +#define swait_event(wq, condition)					\

Here we have the same swait vs. wait problem as above. So either we
come up with a slightly different name or have an explicit type check
in __swait_event event.

Thanks,

	tglx
