From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/4] KVM: use simple waitqueue for vcpu->wq
Date: Tue, 20 Oct 2015 17:40:36 +0200
Message-ID: <56266074.8050707@redhat.com>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1445326090-1698-3-git-send-email-daniel.wagner@bmw-carit.de>
 <20151020140031.GG17308@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbbJTPkn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Oct 2015 11:40:43 -0400
In-Reply-To: <20151020140031.GG17308@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 20/10/2015 16:00, Peter Zijlstra wrote:
>> > -		prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
>> > +		prepare_to_swait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
>> >  
>> >  		if (kvm_vcpu_check_block(vcpu) < 0)
>> >  			break;
>> > @@ -2028,7 +2027,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>> >  		schedule();
>> >  	}
>> >  
>> > -	finish_wait(&vcpu->wq, &wait);
>> > +	finish_swait(&vcpu->wq, &wait);
>> >  	cur = ktime_get();
>> >  
>> >  out:
> Should we not take this opportunity to get rid of these open-coded wait
> loops?

I find them way more readable than a 6-argument __wait_event...

I've forwarded your remark about kvmppc_vcore_blocked to the kvm-ppc
maintainers.

Thanks,

Paolo
