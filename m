From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
Date: Fri, 20 Feb 2015 15:54:04 +0100
Message-ID: <54E74A8C.30802@linutronix.de>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com> <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, scottwood@freescale.com,
	mihai.caraman@freescale.com, Thomas Gleixner <tglx@linutronix.de>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <agraf@suse.de>,
	Bogdan Purcareata <bogdan.purcareata@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E740E7.5090806@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/20/2015 03:12 PM, Paolo Bonzini wrote:
>> Thomas, what is the usual approach for patches like this? Do you take
>> them into your rt tree or should they get integrated to upstream?
> 
> Patch 1 is definitely suitable for upstream, that's the reason why we
> have raw_spin_lock vs. raw_spin_unlock.

raw_spin_lock were introduced in c2f21ce2e31286a0a32 ("locking:
Implement new raw_spinlock). They are used in context which runs with
IRQs off - especially on -RT. This includes usually interrupt
controllers and related core-code pieces.

Usually you see "scheduling while atomic" on -RT and convert them to
raw locks if it is appropriate.

Bogdan wrote in 2/2 that he needs to limit the number of CPUs in oder
not cause a DoS and large latencies in the host. I haven't seen an
answer to my why question. Because if the conversation leads to
large latencies in the host then it does not look right.

Each host PIC has a rawlock and does mostly just mask/unmask and the
raw lock makes sure the value written is not mixed up due to
preemption.
This hardly increase latencies because the "locked" path is very short.
If this conversation leads to higher latencies then the locked path is
too long and hardly suitable to become a rawlock.

> Paolo
> 

Sebastian
