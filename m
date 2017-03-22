From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 1/1] remoteproc: Prevent schedule while atomic
Date: Wed, 22 Mar 2017 09:05:58 -0700
Message-ID: <20170322090558.72064144@vmware.local.home>
References: <1490195923-9560-1-git-send-email-lionel.debieve@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bigeasy@linutronix.de>, <tglx@linutronix.de>
To: Lionel Debieve <lionel.debieve@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490195923-9560-1-git-send-email-lionel.debieve@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 22 Mar 2017 16:18:43 +0100
Lionel Debieve <lionel.debieve@st.com> wrote:

> Use raw_spin_lock in enable/disable channel as it comes from
> interrupt context.
> 
> BUG: sleeping function called from invalid context at
> kernel/locking/rtmutex.c:995
> in_atomic(): 1, irqs_disabled(): 128, pid: 307, name: pulseaudio
> Preemption disabled at:
> [<c01790fc>] __handle_domain_irq+0x4c/0xec
> CPU: 0 PID: 307 Comm: pulseaudio
> Hardware name: STi SoC with Flattened Device Tree
> [<c011046c>] (unwind_backtrace)
> [<c010c7f4>] (show_stack)
> [<c03d1578>] (dump_stack)
> [<c014e440>] (___might_sleep)
> [<c08e7f24>] (rt_spin_lock)
> [<c069bb04>] (sti_mbox_disable_channel)
> [<c069befc>] (sti_mbox_irq_handler)
> [<c0179900>] (__handle_irq_event_percpu)
> [<c01799dc>] (handle_irq_event_percpu)
> [<c0179a78>] (handle_irq_event)
> [<c017d1c8>] (handle_fasteoi_irq)
> [<c0178c08>] (generic_handle_irq)
> [<c017912c>] (__handle_domain_irq)
> [<c0101488>] (gic_handle_irq)
> 
> Signed-off-by: Lionel Debieve <lionel.debieve@st.com>

Looks fine to me. Should this go to mainline?

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  drivers/mailbox/mailbox-sti.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mailbox/mailbox-sti.c
> b/drivers/mailbox/mailbox-sti.c index 41bcd33..f9674ca 100644
> --- a/drivers/mailbox/mailbox-sti.c
> +++ b/drivers/mailbox/mailbox-sti.c
> @@ -60,7 +60,7 @@ struct sti_mbox_device {
>  	void __iomem		*base;
>  	const char		*name;
>  	u32			enabled[STI_MBOX_INST_MAX];
> -	spinlock_t		lock;
> +	raw_spinlock_t		lock;
>  };
>  
>  /**
> @@ -129,10 +129,10 @@ static void sti_mbox_enable_channel(struct
> mbox_chan *chan) unsigned long flags;
>  	void __iomem *base = MBOX_BASE(mdev, instance);
>  
> -	spin_lock_irqsave(&mdev->lock, flags);
> +	raw_spin_lock_irqsave(&mdev->lock, flags);
>  	mdev->enabled[instance] |= BIT(channel);
>  	writel_relaxed(BIT(channel), base + STI_ENA_SET_OFFSET);
> -	spin_unlock_irqrestore(&mdev->lock, flags);
> +	raw_spin_unlock_irqrestore(&mdev->lock, flags);
>  }
>  
>  static void sti_mbox_disable_channel(struct mbox_chan *chan)
> @@ -144,10 +144,10 @@ static void sti_mbox_disable_channel(struct
> mbox_chan *chan) unsigned long flags;
>  	void __iomem *base = MBOX_BASE(mdev, instance);
>  
> -	spin_lock_irqsave(&mdev->lock, flags);
> +	raw_spin_lock_irqsave(&mdev->lock, flags);
>  	mdev->enabled[instance] &= ~BIT(channel);
>  	writel_relaxed(BIT(channel), base + STI_ENA_CLR_OFFSET);
> -	spin_unlock_irqrestore(&mdev->lock, flags);
> +	raw_spin_unlock_irqrestore(&mdev->lock, flags);
>  }
>  
>  static void sti_mbox_clear_irq(struct mbox_chan *chan)
> @@ -450,7 +450,7 @@ static int sti_mbox_probe(struct platform_device
> *pdev) mdev->dev		= &pdev->dev;
>  	mdev->mbox		= mbox;
>  
> -	spin_lock_init(&mdev->lock);
> +	raw_spin_lock_init(&mdev->lock);
>  
>  	/* STi Mailbox does not have a Tx-Done or Tx-Ready IRQ */
>  	mbox->txdone_irq	= false;
