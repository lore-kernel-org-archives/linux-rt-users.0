From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [patch] x86: kvm: Convert i8254/i8259 locks to raw_spinlocks
Date: Tue, 23 Feb 2010 20:18:55 +0100
Message-ID: <4B842A1F.50601@siemens.com>
References: <20100217135901.331576359@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Avi Kivity <avi@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100217135901.331576359@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas Gleixner wrote:
> The i8254/i8259 locks need to be real spinlocks on preempt-rt. Convert
> them to raw_spinlock. No change for !RT kernels.

Doesn't fly for -rt anymore: pic_irq_update runs under this raw lock and
calls kvm_vcpu_kick which tries to wake_up some thread -> scheduling
while atomic.

This used to work up to 956f97cf. -rt for 2.6.31 is not yet affected,
but 2.6.33 should be broken (haven't checked, using kvm-kmod over 2.6.31
ATM). I can provide a patch that restores the deferred kicking if it's
acceptable for upstream.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux
