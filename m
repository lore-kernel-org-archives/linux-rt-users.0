From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
Date: Thu, 26 Feb 2015 14:31:17 +0100
Message-ID: <54EF2025.80404@linutronix.de>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>	 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>	 <54E74A8C.30802@linutronix.de> <1424734051.4698.17.camel@freescale.com> <54EF196E.4090805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Alexander Graf <agraf@suse.de>,
	Bogdan Purcareata <bogdan.purcareata@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, mihai.caraman@freescale.com,
	Thomas Gleixner <tglx@linutronix.de>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Scott Wood <scottwood@freescale.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EF196E.4090805@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/26/2015 02:02 PM, Paolo Bonzini wrote:
> 
> 
> On 24/02/2015 00:27, Scott Wood wrote:
>> This isn't a host PIC driver.  It's guest PIC emulation, some of which
>> is indeed not suitable for a rawlock (in particular, openpic_update_irq
>> which loops on the number of vcpus, with a loop body that calls
>> IRQ_check() which loops over all pending IRQs).
> 
> The question is what behavior is wanted of code that isn't quite
> RT-ready.  What is preferred, bugs or bad latency?
> 
> If the answer is bad latency (which can be avoided simply by not running
> KVM on a RT kernel in production), patch 1 can be applied.  If the
can be applied *but* makes no difference if applied or not.

> answer is bugs, patch 1 is not upstream material.
> 
> I myself prefer to have bad latency; if something takes a spinlock in
> atomic context, that spinlock should be raw.  If it hurts (latency),
> don't do it (use the affected code).

The problem, that is fixed by this s/spin_lock/raw_spin_lock/, exists
only in -RT. There is no change upstream. In general we fix such things
in -RT first and forward the patches upstream if possible. This convert
thingy would be possible.
Bug fixing comes before latency no matter if RT or not. Converting
every lock into a rawlock is not always the answer.
Last thing I read from Scott is that he is not entirely sure if this is
the right approach or not and patch #1 was not acked-by him either.

So for now I wait for Scott's feedback and maybe a backtrace :)

> 
> Paolo

Sebastian
