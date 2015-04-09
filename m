From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch -rt 0/2] use simple waitqueue for kvm vcpu waitqueue (v5)
Date: Thu, 9 Apr 2015 15:18:21 +0200
Message-ID: <20150409131821.GA1160@linutronix.de>
References: <20150408233323.842124241@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rik van Riel <riel@redhat.com>,
	Luiz Capitulino <lcapitulino@redhat.com>,
	linux-rt-users@vger.kernel.org, kvm@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150408233323.842124241@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Marcelo Tosatti | 2015-04-08 20:33:23 [-0300]:

>Sebastian,
Hi Marcelo,

>rebased against v3.18.7-rt2 as requested.
>
>The problem:
>
>On -RT, an emulated LAPIC timer instance has the following path:
>
>1) hard interrupt
>2) ksoftirqd is scheduled
>3) ksoftirqd wakes up vcpu thread
>4) vcpu thread is scheduled
>
>This extra context switch introduces unnecessary latency in the
>LAPIC path for a KVM guest.
>
>The solution:
>
>Allow waking up vcpu thread from hardirq context,
>thus avoiding the need for ksoftirqd to be scheduled.
>
>Normal waitqueues make use of spinlocks, which on -RT
>are sleepable locks. Therefore, waking up a waitqueue
>waiter involves locking a sleeping lock, which
>is not allowed from hard interrupt context.

Applied, thanks.

Sebastian
