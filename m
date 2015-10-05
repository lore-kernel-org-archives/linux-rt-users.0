From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: [v2 PATCH] arm64: replace read_lock to rcu lock in call_break_hook
Date: Mon, 05 Oct 2015 13:08:01 -0700
Message-ID: <5612D8A1.6060505@linaro.org>
References: <1443717457-31461-1-git-send-email-yang.shi@linaro.org> <20151001130819.5080bc24@gandalf.local.home> <560D9D5F.70403@linaro.org> <20151001212702.GM4043@linux.vnet.ibm.com> <560DB067.3060908@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, catalin.marinas@arm.com,
	will.deacon@arm.com, dave.long@linaro.org, panand@redhat.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33881 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbbJEUIF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 16:08:05 -0400
Received: by padhy16 with SMTP id hy16so45748434pad.1
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2015 13:08:03 -0700 (PDT)
In-Reply-To: <560DB067.3060908@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/1/2015 3:15 PM, Shi, Yang wrote:
> On 10/1/2015 2:27 PM, Paul E. McKenney wrote:
>> On Thu, Oct 01, 2015 at 01:53:51PM -0700, Shi, Yang wrote:
>>> On 10/1/2015 10:08 AM, Steven Rostedt wrote:
>>>> On Thu,  1 Oct 2015 09:37:37 -0700
>>>> Yang Shi <yang.shi@linaro.org> wrote:
>>>>
>>>>> BUG: sleeping function called from invalid context at
>>>>> kernel/locking/rtmutex.c:917
>>>>> in_atomic(): 0, irqs_disabled(): 128, pid: 342, name: perf
>>>>> 1 lock held by perf/342:
>>>>>   #0:  (break_hook_lock){+.+...}, at: [<ffffffc0000851ac>]
>>>>> call_break_hook+0x34/0xd0
>>>>> irq event stamp: 62224
>>>>> hardirqs last  enabled at (62223): [<ffffffc00010b7bc>]
>>>>> __call_rcu.constprop.59+0x104/0x270
>>>>> hardirqs last disabled at (62224): [<ffffffc0000fbe20>]
>>>>> vprintk_emit+0x68/0x640
>>>>> softirqs last  enabled at (0): [<ffffffc000097928>]
>>>>> copy_process.part.8+0x428/0x17f8
>>>>> softirqs last disabled at (0): [<          (null)>]           (null)
>>>>> CPU: 0 PID: 342 Comm: perf Not tainted 4.1.6-rt5 #4
>>>>> Hardware name: linux,dummy-virt (DT)
>>>>> Call trace:
>>>>> [<ffffffc000089968>] dump_backtrace+0x0/0x128
>>>>> [<ffffffc000089ab0>] show_stack+0x20/0x30
>>>>> [<ffffffc0007030d0>] dump_stack+0x7c/0xa0
>>>>> [<ffffffc0000c878c>] ___might_sleep+0x174/0x260
>>>>> [<ffffffc000708ac8>] __rt_spin_lock+0x28/0x40
>>>>> [<ffffffc000708db0>] rt_read_lock+0x60/0x80
>>>>> [<ffffffc0000851a8>] call_break_hook+0x30/0xd0
>>>>> [<ffffffc000085a70>] brk_handler+0x30/0x98
>>>>> [<ffffffc000082248>] do_debug_exception+0x50/0xb8
>>>>> Exception stack(0xffffffc00514fe30 to 0xffffffc00514ff50)
>>>>> fe20:                                     00000000 00000000
>>>>> c1594680 0000007f
>>>>> fe40: ffffffff ffffffff 92063940 0000007f 0550dcd8 ffffffc0
>>>>> 00000000 00000000
>>>>> fe60: 0514fe70 ffffffc0 000be1f8 ffffffc0 0514feb0 ffffffc0
>>>>> 0008948c ffffffc0
>>>>> fe80: 00000004 00000000 0514fed0 ffffffc0 ffffffff ffffffff
>>>>> 9282a948 0000007f
>>>>> fea0: 00000000 00000000 9282b708 0000007f c1592820 0000007f
>>>>> 00083914 ffffffc0
>>>>> fec0: 00000000 00000000 00000010 00000000 00000064 00000000
>>>>> 00000001 00000000
>>>>> fee0: 005101e0 00000000 c1594680 0000007f c1594740 0000007f
>>>>> ffffffd8 ffffff80
>>>>> ff00: 00000000 00000000 00000000 00000000 c1594770 0000007f
>>>>> c1594770 0000007f
>>>>> ff20: 00665e10 00000000 7f7f7f7f 7f7f7f7f 01010101 01010101
>>>>> 00000000 00000000
>>>>> ff40: 928e4cc0 0000007f 91ff11e8 0000007f
>>>>>
>>>>> call_break_hook is called in atomic context (hard irq disabled), so
>>>>> replace
>>>>> the sleepable lock to rcu lock and replace relevant list operations
>>>>> to rcu
>>>>> version.
>>>>>
>>>>> Signed-off-by: Yang Shi <yang.shi@linaro.org>
>>>>> ---
>>>>> v1-> v2
>>>>> Replace list operations to rcu version.
>>>>>
>>>>>   arch/arm64/kernel/debug-monitors.c | 10 +++++-----
>>>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/debug-monitors.c
>>>>> b/arch/arm64/kernel/debug-monitors.c
>>>>> index cebf786..cf0e4fc 100644
>>>>> --- a/arch/arm64/kernel/debug-monitors.c
>>>>> +++ b/arch/arm64/kernel/debug-monitors.c
>>>>> @@ -276,14 +276,14 @@ static DEFINE_RWLOCK(break_hook_lock);
>>>>>   void register_break_hook(struct break_hook *hook)
>>>>>   {
>>>>>       write_lock(&break_hook_lock);
>>>>> -    list_add(&hook->node, &break_hook);
>>>>> +    list_add_rcu(&hook->node, &break_hook);
>>>>>       write_unlock(&break_hook_lock);
>>>>>   }
>>>>>
>>>>>   void unregister_break_hook(struct break_hook *hook)
>>>>>   {
>>>>>       write_lock(&break_hook_lock);
>>>>> -    list_del(&hook->node);
>>>>> +    list_del_rcu(&hook->node);
>>>>>       write_unlock(&break_hook_lock);
>>>>>   }
>>>>
>>>> Shouldn't there be a synchronize_rcu() somewhere?
>>>
>>> So far kgdb is the only user of unregister_break_hook in mainline
>>> kernel.
>>>
>>> Just read Documentation/RCU/checklist.txt, it says:
>>>
>>> Note that synchronize_rcu() -only- guarantees to wait until
>>> all currently executing rcu_read_lock()-protected RCU read-side
>>> critical sections complete.
>>>
>>> For kgdb, the unregister is just called in kgdb_arch_exit by
>>> kgdb_unregister_io_module, which is called when rmmod kgdb module.
>>>
>>> The break point handler is done synchronously. So, it sounds should
>>> be not a problem without calling synchronize_rcu().
>>
>> OK, I will bite...  What does "synchronously" mean here?  Unless you
>> have somehow guaranteed that all current readers in call_break_hook()
>> are done between the time you call unregister_break_hook() to remove a
>> given break_hook structure and the time you call register_break_hook()
>> to add that same structure back in, you have a problem.
>
> For kgdb usecase, this might be guaranteed.
>
> Generally, kgdb module is loaded then register_break_hook() is called.
> Then connect kgdb from host or via kdb, set breakpoint, wait for the
> break point is hit, run some commands to debug. Then finish debug, rmmod
> kgdb which will call unregister_break_hook().
>
> It sounds the current readers in call_break_hook() could be done during
> the time otherwise I won't be able to continue my debug when break point
> is hit.
>
>>
>> What you have now only protects against invoking register_break_hook()
>> on newly allocated and initialized break_hook structure.  But the only
>> calls to register_break_hook() that I see in v4.2 use compile-time
>> initialized structures.  So the only failure from using non-RCU list
>> primitives would be due to the list_head's ->next pointer initialization.
>> This could momentarily make the list appear to have only the new element,
>> but not the old element.
>>
>> Unless you do a series of register_break_hook() and
>> unregister_break_hook()
>> calls, in which case a previously deleted structure could momentarily
>> appear to already (or still) be in the list.

This might be a problem. Just thought of the below senario.

1. load kgdb module
2. do some debugging
3. unload kgdb module <-- the hook pointer may be still in the list
4. load kgdb module again <-- there may be two hook pointers
5. do some debugging <-- it may call them twice

Although my test didn't catch this problem, it still sounds like a 
potential issue.

Preparing for v3 with synchronize_rcu() added.

Thanks,
Yang

>
> They are called in series:
>
> In kgdb_arch_init
>      register_break_hook(&kgdb_brkpt_hook);
>          register_break_hook(&kgdb_compiled_brkpt_hook);
>
> In kgdb_arch_exit
>      unregister_break_hook(&kgdb_brkpt_hook);
>          unregister_break_hook(&kgdb_compiled_brkpt_hook);
>
> Yang
>
>
>
>>
>> Are those the sorts of failures you are seeing?
>>
>>                             Thanx, Paul
>>
>>> Yang
>>>
>>>> -- Steve
>>>>
>>>>>
>>>>> @@ -292,11 +292,11 @@ static int call_break_hook(struct pt_regs
>>>>> *regs, unsigned int esr)
>>>>>       struct break_hook *hook;
>>>>>       int (*fn)(struct pt_regs *regs, unsigned int esr) = NULL;
>>>>>
>>>>> -    read_lock(&break_hook_lock);
>>>>> -    list_for_each_entry(hook, &break_hook, node)
>>>>> +    rcu_read_lock();
>>>>> +    list_for_each_entry_rcu(hook, &break_hook, node)
>>>>>           if ((esr & hook->esr_mask) == hook->esr_val)
>>>>>               fn = hook->fn;
>>>>> -    read_unlock(&break_hook_lock);
>>>>> +    rcu_read_unlock();
>>>>>
>>>>>       return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
>>>>>   }
>>>>
>>>
>>
>

