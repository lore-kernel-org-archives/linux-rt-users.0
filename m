From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
Date: Fri, 20 Feb 2015 16:06:06 +0100
Message-ID: <54E74D5E.1050209@linutronix.de>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com> <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com> <54E74A8C.30802@linutronix.de> <54E74B58.90706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, scottwood@freescale.com,
	mihai.caraman@freescale.com, Thomas Gleixner <tglx@linutronix.de>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <agraf@suse.de>,
	Bogdan Purcareata <bogdan.purcareata@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56802 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbbBTPGK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Feb 2015 10:06:10 -0500
In-Reply-To: <54E74B58.90706@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/20/2015 03:57 PM, Paolo Bonzini wrote:
> 
> 
> On 20/02/2015 15:54, Sebastian Andrzej Siewior wrote:
>> Usually you see "scheduling while atomic" on -RT and convert them to
>> raw locks if it is appropriate.
>>
>> Bogdan wrote in 2/2 that he needs to limit the number of CPUs in oder
>> not cause a DoS and large latencies in the host. I haven't seen an
>> answer to my why question. Because if the conversation leads to
>> large latencies in the host then it does not look right.
>>
>> Each host PIC has a rawlock and does mostly just mask/unmask and the
>> raw lock makes sure the value written is not mixed up due to
>> preemption.
>> This hardly increase latencies because the "locked" path is very short.
>> If this conversation leads to higher latencies then the locked path is
>> too long and hardly suitable to become a rawlock.
> 
> Yes, but large latencies just mean the code has to be rewritten (x86
> doesn't anymore do event injection in an atomic regions for example).
> Until it is, using raw_spin_lock is correct.

It does not sound like it. It sounds more like disabling interrupts to
get things run faster and then limit it on a different corner to not
blow up everything.
Max latencies was decreased "Max latency (us)  70        62" and that
is why this is done? For 8 us and possible DoS in case there are too
many cpus?

> Paolo
> 

Sebastian
