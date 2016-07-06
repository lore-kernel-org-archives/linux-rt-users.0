From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Wed, 6 Jul 2016 07:03:43 -0500
Message-ID: <577CF39F.5010400@mvista.com>
References: <20160630170134.GA3932@pd.tnic> <57755449.7070302@acm.org>
 <20160630172611.GC3932@pd.tnic> <57755CC6.60506@acm.org>
 <20160630182257.GD3932@pd.tnic> <577576AA.8040004@mvista.com>
 <20160630203457.GF3932@pd.tnic> <5775A181.2050404@acm.org>
 <20160701072050.GA4593@pd.tnic> <577C580F.8010004@acm.org>
 <20160706083704.GA7300@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>
To: Borislav Petkov <bp@alien8.de>, Corey Minyard <minyard@acm.org>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34649 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbcGFMDq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Jul 2016 08:03:46 -0400
Received: by mail-pa0-f46.google.com with SMTP id bz2so76224702pad.1
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Jul 2016 05:03:45 -0700 (PDT)
In-Reply-To: <20160706083704.GA7300@pd.tnic>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/06/2016 03:37 AM, Borislav Petkov wrote:
> On Tue, Jul 05, 2016 at 07:59:59PM -0500, Corey Minyard wrote:
>> I'm having our hardware people keep the system as-is until we can
>> track this down.
>>
>> A applied the above four patches and a few more support patches got that
>> were needed, but no love.  Exact same issue.  Well, almost the same, here's
>> the traceback:
>>
>> [    0.455575]  [<ffffffff810733c4>] try_to_wake_up+0x34/0x300
>> [    0.455590]  [<ffffffff81067d76>] ? __hrtimer_start_range_ns+0x226/0x3a0
>> [    0.455593]  [<ffffffff810736e0>] wake_up_process+0x10/0x20
>> [    0.455615]  [<ffffffff8101c7a8>] mce_notify_irq+0x28/0x30
>> [    0.455621]  [<ffffffff8101cbd9>] mce_irq_work_cb+0x9/0x10
>> [    0.455646]  [<ffffffff810cbb0c>] irq_work_run_list+0x3c/0x60
>> [    0.455649]  [<ffffffff810cbe97>] irq_work_tick_soft+0x27/0x30
>> [    0.455673]  [<ffffffff8104dbe4>] run_timer_softirq+0x24/0x250
>> [    0.455681]  [<ffffffff81045bce>] do_current_softirqs+0x1ae/0x250
>> [    0.455684]  [<ffffffff81045c9e>] run_ksoftirqd+0x2e/0x50
>> [    0.455697]  [<ffffffff8106c7f6>] smpboot_thread_fn+0x206/0x320
>> [    0.455700]  [<ffffffff8106c5f0>] ? lg_global_unlock+0x60/0x60
>> [    0.455720]  [<ffffffff81063cad>] kthread+0xad/0xc0
>> [    0.455740]  [<ffffffff81730303>] ? _dbgp_external_startup+0x236/0x392
>> [    0.455744]  [<ffffffff81063c00>] ? kthread_create_on_node+0x130/0x130
>> [    0.455752]  [<ffffffff8173a4be>] ret_from_fork+0x4e/0x80
>> [    0.455756]  [<ffffffff81063c00>] ? kthread_create_on_node+0x130/0x130
>>
>>
>> So it crashed in the kthread instead of the irq, but exactly the same issue,
>> that particular field is not initialized.  Not that these aren't patches
>> that look like good ideas.
> Hmm, so this looks like RT-specific now AFAICT.
>
> mce_notify_irq() calls mce_notify_work() and on RT_FULL that's
> trying to wake up mce_notify_helper which is not initialized yet -
> mce_notify_work_init() happens later in a device_initcall_sync.
>
> Would something as trivial as this work in your case?
>
> ---
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index aaf4b9b94f38..cc70d98a30f6 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -1391,7 +1391,8 @@ static int mce_notify_work_init(void)
>   
>   static void mce_notify_work(void)
>   {
> -	wake_up_process(mce_notify_helper);
> +	if (mce_notify_helper)
> +		wake_up_process(mce_notify_helper);
>   }
>   #else
>   static void mce_notify_work(void)
>
>
I did think about that option, but I'm not sure why the current RT patch
has that as a separate bool.

This appears to come in here:

http://www.spinics.net/lists/linux-rt-users/msg12779.html

I'm copying Sebastian, who appears to be the original source of this
change.

-corey
