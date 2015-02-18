From: Purcareata Bogdan <b43198@freescale.com>
Subject: Re: [PATCH] KVM: PPC: Convert openpic lock to raw_spinlock
Date: Wed, 18 Feb 2015 10:31:52 +0200
Message-ID: <54E44DF8.1080906@freescale.com>
References: <1421919555-11631-1-git-send-email-bogdan.purcareata@freescale.com> <54CF44EC.3050007@freescale.com> <54E333C0.5000908@freescale.com> <20150217175317.GB26177@linutronix.de> <20150217175922.GC26177@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <scottwood@freescale.com>,
	Mihai Caraman <mihai.caraman@freescale.com>,
	<linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150217175922.GC26177@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 17.02.2015 19:59, Sebastian Andrzej Siewior wrote:
> * Sebastian Andrzej Siewior | 2015-02-17 18:53:17 [+0100]:
>
>> * Purcareata Bogdan | 2015-02-17 14:27:44 [+0200]:
>>
>>> Ping?
>>>
>>> On 02.02.2015 11:35, Purcareata Bogdan wrote:
>>>> Ping?
>>
>> No body?
> bah! That mutt thing is too fast.
>
> The raw conversation looks sane and could go upstream. This other chunk:
>
> |+#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_KVM_MPIC)
> |+/* Limit the number of vcpus due to in-kernel mpic concurrency */
> |+#define KVM_MAX_VCPUS          4
> |+#define KVM_MAX_VCORES         4
> |+#else
> | #define KVM_MAX_VCPUS          NR_CPUS
> | #define KVM_MAX_VCORES         NR_CPUS
> |+#endif
>
> should be a separate patch. Please repost including ppc ml.

Thanks! Will send a patchset separating these 2 functional changes - the 
openpic raw_spinlock for upstream ppc (since it doesn't bring any 
changes anyway), and the MAX_VCPUS limitation for the RT tree.

> This remains of my multiple-MSI patch which someone other posted a while
> ago. What happend to it?

I'm not aware of this patch, could you give more details, please?

Bogdan P.
