From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] x86: kvm: Convert i8254/i8259 locks to raw_spinlocks
Date: Tue, 23 Feb 2010 23:23:37 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1002232321320.3232@localhost.localdomain>
References: <20100217135901.331576359@linutronix.de> <4B842A1F.50601@siemens.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avi Kivity <avi@redhat.com>, KVM <kvm@vger.kernel.org>,
	Gleb Natapov <gleb@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B842A1F.50601@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 23 Feb 2010, Jan Kiszka wrote:

> Thomas Gleixner wrote:
> > The i8254/i8259 locks need to be real spinlocks on preempt-rt. Convert
> > them to raw_spinlock. No change for !RT kernels.
> 
> Doesn't fly for -rt anymore: pic_irq_update runs under this raw lock and
> calls kvm_vcpu_kick which tries to wake_up some thread -> scheduling
> while atomic.

Hmm, a wakeup itself is fine. Is that code waking a wake queue ?
 
> This used to work up to 956f97cf. -rt for 2.6.31 is not yet affected,
> but 2.6.33 should be broken (haven't checked, using kvm-kmod over 2.6.31
> ATM). I can provide a patch that restores the deferred kicking if it's
> acceptable for upstream.

Well, at least is would be nice to have one for -rt.

Thanks,

	tglx
