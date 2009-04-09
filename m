From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 2/3] kvm: convert spin-locks to raw_spinlock_t
Date: Thu, 9 Apr 2009 06:21:33 -0300
Message-ID: <20090409092133.GA30211@amt.cnet>
References: <20090407235853.309888494@suse.de> <20090407235902.400480759@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rt-users <linux-rt-users@vger.kernel.org>, kvm@vger.kernel.org
To: Jan Blunck <jblunck@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:44079 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935512AbZDIJVt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2009 05:21:49 -0400
Content-Disposition: inline
In-Reply-To: <20090407235902.400480759@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Acked-by: Marcelo Tosatti <mtosatti@redhat.com>

On Wed, Apr 08, 2009 at 01:58:55AM +0200, Jan Blunck wrote:
> This patch converts some KVM spin-locks to be of type raw_spinlock_t.
> 
> Signed-off-by: Jan Blunck <jblunck@suse.de>
> ---
>  arch/x86/kvm/i8254.h |    2 +-
>  arch/x86/kvm/irq.h   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: b/arch/x86/kvm/i8254.h
> ===================================================================
> --- a/arch/x86/kvm/i8254.h
> +++ b/arch/x86/kvm/i8254.h
> @@ -33,7 +33,7 @@ struct kvm_kpit_state {
>  	u32    speaker_data_on;
>  	struct mutex lock;
>  	struct kvm_pit *pit;
> -	spinlock_t inject_lock;
> +	raw_spinlock_t inject_lock;
>  	unsigned long irq_ack;
>  	struct kvm_irq_ack_notifier irq_ack_notifier;
>  };
> Index: b/arch/x86/kvm/irq.h
> ===================================================================
> --- a/arch/x86/kvm/irq.h
> +++ b/arch/x86/kvm/irq.h
> @@ -60,7 +60,7 @@ struct kvm_kpic_state {
>  };
>  
>  struct kvm_pic {
> -	spinlock_t lock;
> +	raw_spinlock_t lock;
>  	bool wakeup_needed;
>  	unsigned pending_acks;
>  	struct kvm *kvm;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
