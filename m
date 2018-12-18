From: He Zhe <zhe.he@windriver.com>
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of memory
 allocated in cpu hotplug prepare state
Date: Tue, 18 Dec 2018 20:45:32 +0800
Message-ID: <b8f1f75c-bb8e-3b07-b113-32d1ff70fd3e@windriver.com>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
 <20181218110209.GD15430@hirez.programming.kicks-ass.net>
 <20181218111637.b53u5pi3nxnyldaq@linutronix.de>
 <20181218113119.GG15430@hirez.programming.kicks-ass.net>
 <20181218113700.GC16284@hirez.programming.kicks-ass.net>
 <20181218114708.p6fpz447brob4kzz@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: <acme@kernel.org>, <ak@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <jolsa@kernel.org>, <jolsa@redhat.com>,
        <kan.liang@linux.intel.com>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <tglx@linutronix.de>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218114708.p6fpz447brob4kzz@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 2018/12/18 19:47, Sebastian Andrzej Siewior wrote:
> On 2018-12-18 12:37:00 [+0100], Peter Zijlstra wrote:
>> On Tue, Dec 18, 2018 at 12:31:19PM +0100, Peter Zijlstra wrote:
>>> On Tue, Dec 18, 2018 at 12:16:37PM +0100, Sebastian Andrzej Siewior wrote:
>>>> On 2018-12-18 12:02:09 [+0100], Peter Zijlstra wrote:
>>>>> On Tue, Dec 18, 2018 at 06:30:33PM +0800, zhe.he@windriver.com wrote:
>>>>>> Besides, in preempt-rt full mode, the freeing can happen in atomic context and
>>>>>> thus cause the following BUG.
>>>>> Hurm, I though we fixed all those long ago..
>>>>>
>>>>> And no, the patch is horrible; that's what we have things like
>>>>> x86_pmu::cpu_dead() for.
>>>> ehm, you say we keep memory allocation +free on CPU up/down?
>>> Sure, why not?
> It does not seem to be useful to allocate & free memory which you need
> anyway. So you could avoid the refcnt for instance.
> Also I doubt the memory will remain unallocated for a longer period of
> time (like you would remove the CPU for good and not boot it again a
> minute later).
> *Maybe* it is different in cloud environment where you attach vcpus
> depending on guest load at runtime but still…
>
>> I suspect the below is all we really need.
> Zhe, could you please have a look?

This works in my environment, taking CPUs offline and online many times.

Zhe

>
> Sebastian
>
