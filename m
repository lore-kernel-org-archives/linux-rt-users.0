From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Tue, 5 Jul 2016 19:59:59 -0500
Message-ID: <577C580F.8010004@acm.org>
References: <3908561D78D1C84285E8C5FCA982C28F3A14CDB9@ORSMSX114.amr.corp.intel.com>
 <57754B71.2000108@acm.org> <20160630170134.GA3932@pd.tnic>
 <57755449.7070302@acm.org> <20160630172611.GC3932@pd.tnic>
 <57755CC6.60506@acm.org> <20160630182257.GD3932@pd.tnic>
 <577576AA.8040004@mvista.com> <20160630203457.GF3932@pd.tnic>
 <5775A181.2050404@acm.org> <20160701072050.GA4593@pd.tnic>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Corey Minyard <cminyard@mvista.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35511 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcGFBAD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jul 2016 21:00:03 -0400
Received: by mail-pf0-f172.google.com with SMTP id c2so74954031pfa.2
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Jul 2016 18:00:02 -0700 (PDT)
In-Reply-To: <20160701072050.GA4593@pd.tnic>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/01/2016 02:20 AM, Borislav Petkov wrote:
>> That sounds like a bit much.
> Actually, you probably would need only a couple:
>
> 1. 648ed94038c0 ("x86/mce: Provide a lockless memory pool to save error records")
>
> 2. 061120aed708 ("x86/mce: Don't use percpu workqueues")
>   - that one is unrelated but should be nice for RT as it gets rid of percpu
>     workqueues and I know RT hates them :)
>
> 3. fd4cf79fcc4b ("x86/mce: Remove the MCE ring for Action Optional errors")
>   - this one connects the genpool to MCE
>
> 4. f29a7aff4bd6 ("x86/mce: Avoid potential deadlock due to printk() in MCE context")
>   - and this is the last one which I meant earlier.
>
> So that's 4 patches, more or less.
>
> Now, you're in the perfect position to test those because you *actually*
> have a real-life system which generates those errors so it is the
> perfect candidate for testing the backports. And you should test them
> with the failing DIMM still in place, of course.

I'm having our hardware people keep the system as-is until we can
track this down.

A applied the above four patches and a few more support patches got that
were needed, but no love.  Exact same issue.  Well, almost the same, here's
the traceback:

[    0.455575]  [<ffffffff810733c4>] try_to_wake_up+0x34/0x300
[    0.455590]  [<ffffffff81067d76>] ? __hrtimer_start_range_ns+0x226/0x3a0
[    0.455593]  [<ffffffff810736e0>] wake_up_process+0x10/0x20
[    0.455615]  [<ffffffff8101c7a8>] mce_notify_irq+0x28/0x30
[    0.455621]  [<ffffffff8101cbd9>] mce_irq_work_cb+0x9/0x10
[    0.455646]  [<ffffffff810cbb0c>] irq_work_run_list+0x3c/0x60
[    0.455649]  [<ffffffff810cbe97>] irq_work_tick_soft+0x27/0x30
[    0.455673]  [<ffffffff8104dbe4>] run_timer_softirq+0x24/0x250
[    0.455681]  [<ffffffff81045bce>] do_current_softirqs+0x1ae/0x250
[    0.455684]  [<ffffffff81045c9e>] run_ksoftirqd+0x2e/0x50
[    0.455697]  [<ffffffff8106c7f6>] smpboot_thread_fn+0x206/0x320
[    0.455700]  [<ffffffff8106c5f0>] ? lg_global_unlock+0x60/0x60
[    0.455720]  [<ffffffff81063cad>] kthread+0xad/0xc0
[    0.455740]  [<ffffffff81730303>] ? _dbgp_external_startup+0x236/0x392
[    0.455744]  [<ffffffff81063c00>] ? kthread_create_on_node+0x130/0x130
[    0.455752]  [<ffffffff8173a4be>] ret_from_fork+0x4e/0x80
[    0.455756]  [<ffffffff81063c00>] ? kthread_create_on_node+0x130/0x130


So it crashed in the kthread instead of the irq, but exactly the same issue,
that particular field is not initialized.  Not that these aren't patches 
that look
like good ideas.

-corey
