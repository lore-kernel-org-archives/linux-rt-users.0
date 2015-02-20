From: Jason Low <jason.low2@hp.com>
Subject: Re: [PATCH RT 1/2] rwsem-rt: Do not allow readers to nest
Date: Thu, 19 Feb 2015 21:07:56 -0800
Message-ID: <CAGQ1y=7h3Y8E90VFqjnqh00zOA1UKsLMZtfnasEvZbOiifxWqQ@mail.gmail.com>
References: <20140409024700.702797305@goodmis.org>
	<20140409025231.998774075@goodmis.org>
	<20150218195710.GH28763@linutronix.de>
	<20150218151352.2968cf06@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"H. Peter Anvin" <hpa@zytor.com>, Jason Low <jason.low2@hp.com>,
	juerg.haefliger@hp.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150218151352.2968cf06@grimm.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Feb 18, 2015 at 12:13 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 18 Feb 2015 20:57:10 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>
>> * Steven Rostedt | 2014-04-08 22:47:01 [-0400]:
>>
>> >From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
>> >
>> >The readers of mainline rwsems are not allowed to nest, the rwsems in the
>> >PREEMPT_RT kernel should not nest either.
>>
>> I applied this and this is the reason why cpufreq isn't working. What I
>> see in cpufreq is:
>> |         test.sh-788   [004] .......    61.416288: store: down_read_try
>> |         test.sh-788   [004] .......    61.416296: cpufreq_cpu_get: down_read_try
>> |         test.sh-788   [004] .......    61.416301: cpufreq_cpu_put.part.6: up_read
>> |         test.sh-788   [004] .......    61.416332: store: up_read
>>
>> as you see, one code path takes the read path of rw_sema twice.
>>
>> Looking at the generic implementation, we have:
>> |#define RWSEM_UNLOCKED_VALUE            0x00000000L
>> |#define RWSEM_ACTIVE_BIAS               0x00000001L
>> |#define RWSEM_WAITING_BIAS              (-RWSEM_ACTIVE_MASK-1)
>>
>> | static inline int __down_read_trylock(struct rw_semaphore *sem)
>> | {
>> |         long tmp;
>> |
>> |         while ((tmp = sem->count) >= 0) {
>> |                 if (tmp == cmpxchg(&sem->count, tmp,
>> |                                    tmp + RWSEM_ACTIVE_READ_BIAS)) {
>> |                         return 1;
>> |                 }
>> |         }
>> |         return 0;
>> | }
>>
>> While sem->count is >= 0 we loop and take the semaphore. So we can have
>> five readers at once. The first writer would set count to a negative
>> value resulting in trylock failure.
>>
>> |static inline void __down_read(struct rw_semaphore *sem)
>> |{
>> |        if (unlikely(atomic_long_inc_return((atomic_long_t*)&sem->count) <= 0))
>> |                rwsem_down_read_failed(sem);
>> |}
>>
>> Here the same thing but without cmpxchg(). _If_ after an increment the
>> value is negative then we take slowpath. Otherwise we have the lock.
>
> OK, so I need to make it so it can nest with trylock. I have to look at
> the patch again because it has been a while.

When we reported this a few months ago, Thomas provided the following
patch to fix the issue (which essentially reverted the patch) and
appeared to be agreed on:

https://lkml.org/lkml/2014/11/5/844
