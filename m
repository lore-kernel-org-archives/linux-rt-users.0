From: Purcareata Bogdan <b43198@freescale.com>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
Date: Mon, 23 Feb 2015 09:29:06 +0200
Message-ID: <54EAD6C2.3080601@freescale.com>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com> <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com> <54E74A8C.30802@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, <scottwood@freescale.com>,
	<mihai.caraman@freescale.com>, Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <agraf@suse.de>,
	Bogdan Purcareata <bogdan.purcareata@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bl2on0117.outbound.protection.outlook.com ([65.55.169.117]:42466
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750818AbbBWH32 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2015 02:29:28 -0500
In-Reply-To: <54E74A8C.30802@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 20.02.2015 16:54, Sebastian Andrzej Siewior wrote:
> On 02/20/2015 03:12 PM, Paolo Bonzini wrote:
>>> Thomas, what is the usual approach for patches like this? Do you take
>>> them into your rt tree or should they get integrated to upstream?
>>
>> Patch 1 is definitely suitable for upstream, that's the reason why we
>> have raw_spin_lock vs. raw_spin_unlock.
>
> raw_spin_lock were introduced in c2f21ce2e31286a0a32 ("locking:
> Implement new raw_spinlock). They are used in context which runs with
> IRQs off - especially on -RT. This includes usually interrupt
> controllers and related core-code pieces.
>
> Usually you see "scheduling while atomic" on -RT and convert them to
> raw locks if it is appropriate.
>
> Bogdan wrote in 2/2 that he needs to limit the number of CPUs in oder
> not cause a DoS and large latencies in the host. I haven't seen an
> answer to my why question. Because if the conversation leads to
> large latencies in the host then it does not look right.

What I did notice were bad cyclictest results, when run in a guest with 
24 VCPUs. There were 24 netperf flows running in the guest. The max 
cyclictest latencies got up to 15ms in the guest, however I haven't 
captured any host side information related to preemptirqs off statistics.

What I was planning to do in the past days was to rerun the test and 
come up with the host preemptirqs off disabled statistics (mainly the 
max latency), so I could have a more reliable argument. I haven't had 
the time nor the setup to do that yet, and will come back with this as 
soon as I have them available.

> Each host PIC has a rawlock and does mostly just mask/unmask and the
> raw lock makes sure the value written is not mixed up due to
> preemption.
> This hardly increase latencies because the "locked" path is very short.
> If this conversation leads to higher latencies then the locked path is
> too long and hardly suitable to become a rawlock.

 From my understanding, the kvm openpic emulation code does more than 
just that - it requires to be atomic with interrupt delivery. This might 
mean the bad cyclictest max latencies visible from the guest side 
(15ms), may also have a correspondent to how much time that raw spinlock 
is taken, leading to an unresponsive host.

Best regards,
Bogdan P.

>> Paolo
>>
>
> Sebastian
>
