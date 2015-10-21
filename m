From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 2/4] KVM: use simple waitqueue for vcpu->wq
Date: Wed, 21 Oct 2015 20:10:26 +1100
Message-ID: <20151021091026.GC15591@fergus.ozlabs.ibm.com>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1445326090-1698-3-git-send-email-daniel.wagner@bmw-carit.de>
 <20151020140031.GG17308@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:57600 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbbJUJKj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Oct 2015 05:10:39 -0400
Content-Disposition: inline
In-Reply-To: <20151020140031.GG17308@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Oct 20, 2015 at 04:00:31PM +0200, Peter Zijlstra wrote:

> @@ -2018,17 +2017,9 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  		} while (single_task_running() && ktime_before(cur, stop));
>  	}
>  
> -	for (;;) {
> -		prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
> +	___wait_event(vcpu->wq, kvm_cpu_check_block(vcpu) < 0, TASK_IDLE, 0, 0,

Needs to be kvm_vcpu_check_block not kvm_cpu_check_block (note the
extra 'v').

Paul.
