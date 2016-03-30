From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC v1] sched/completion: convert completions to use simple wait
 queues
Date: Wed, 30 Mar 2016 17:29:45 +0200
Message-ID: <56FBF0E9.40203@monom.org>
References: <1459349585-6527-1-git-send-email-wagi@monom.org>
 <1459349585-6527-2-git-send-email-wagi@monom.org>
 <20160330150747.GY3408@twins.programming.kicks-ass.net>
 <56FBEE09.9080607@linutronix.de>
 <20160330152155.GZ3408@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160330152155.GZ3408@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/30/2016 05:21 PM, Peter Zijlstra wrote:
> On Wed, Mar 30, 2016 at 05:17:29PM +0200, Sebastian Andrzej Siewior wrote:
>> On 03/30/2016 05:07 PM, Peter Zijlstra wrote:
>>> On Wed, Mar 30, 2016 at 04:53:05PM +0200, Daniel Wagner wrote:
>>>> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
>>>>
>>>> Completions have no long lasting callbacks and therefore do not need
>>>> the complex waitqueue variant.  Use simple waitqueues which reduces
>>>> the contention on the waitqueue lock.
>>>
>>> Changelog really should have talk about the determinism thing. The last
>>> time you posted this the point was raised that we should wake the
>>> highest prio waiter in the defer case, you did not address this.
>>
>> So we really want to go this road? 
> 
> Dunno, but at least mention why it wouldn't matter.

It seems I put to much effort into the cover letter. I should have spent
that time in the changelog. Anyway, I am going through the users of
complete_all() and it looks like most of them are either some setup code
paths and the other bunch of calls are just making sure the single
waiter really wakes up.

>> I didn't find any numbers what the
>> highest count of queued sleepers was in Daniel's complete_all() testing.
>>
>> As for the latest -RT I received only one report from Clark Williams
>> with something like 3 to 9 sleepers waked up during one complete_all()
>> and this happens in the resume code.
>> Based on this, deferring wake-ups from IRQ-context and a RB-tree (or
>> something like that for priority sorting) looks like a lot of complexity
>> and it does not look like we gain much.
> 
> Sure, but that equally puts the whole defer thing into question, if we
> can put a hard cap on the max number (and WARN when exceeded) we're also
> good.
> 
>>> Also, you make no mention of the reduction of UINT_MAX to USHORT_MAX and
>>> the implications of that.
>>
>> Wasn't this
>> |To avoid a size increase of struct completion, I spitted the done
>> |field into two half.
>>
>> later he mentions that we can't have 2M sleepers anymore.
> 
> That wasn't in this changelog, therefore it wasn't read ;-)

Got it, next version has all info in the changelog and not in the cover
letter.
