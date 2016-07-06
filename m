From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Wed, 6 Jul 2016 10:37:04 +0200
Message-ID: <20160706083704.GA7300@pd.tnic>
References: <20160630170134.GA3932@pd.tnic>
 <57755449.7070302@acm.org>
 <20160630172611.GC3932@pd.tnic>
 <57755CC6.60506@acm.org>
 <20160630182257.GD3932@pd.tnic>
 <577576AA.8040004@mvista.com>
 <20160630203457.GF3932@pd.tnic>
 <5775A181.2050404@acm.org>
 <20160701072050.GA4593@pd.tnic>
 <577C580F.8010004@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Corey Minyard <cminyard@mvista.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Corey Minyard <minyard@acm.org>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:58168 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbcGFIhS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Jul 2016 04:37:18 -0400
Content-Disposition: inline
In-Reply-To: <577C580F.8010004@acm.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jul 05, 2016 at 07:59:59PM -0500, Corey Minyard wrote:
> I'm having our hardware people keep the system as-is until we can
> track this down.
> 
> A applied the above four patches and a few more support patches got that
> were needed, but no love.  Exact same issue.  Well, almost the same, here's
> the traceback:
> 
> [    0.455575]  [<ffffffff810733c4>] try_to_wake_up+0x34/0x300
> [    0.455590]  [<ffffffff81067d76>] ? __hrtimer_start_range_ns+0x226/0x3a0
> [    0.455593]  [<ffffffff810736e0>] wake_up_process+0x10/0x20
> [    0.455615]  [<ffffffff8101c7a8>] mce_notify_irq+0x28/0x30
> [    0.455621]  [<ffffffff8101cbd9>] mce_irq_work_cb+0x9/0x10
> [    0.455646]  [<ffffffff810cbb0c>] irq_work_run_list+0x3c/0x60
> [    0.455649]  [<ffffffff810cbe97>] irq_work_tick_soft+0x27/0x30
> [    0.455673]  [<ffffffff8104dbe4>] run_timer_softirq+0x24/0x250
> [    0.455681]  [<ffffffff81045bce>] do_current_softirqs+0x1ae/0x250
> [    0.455684]  [<ffffffff81045c9e>] run_ksoftirqd+0x2e/0x50
> [    0.455697]  [<ffffffff8106c7f6>] smpboot_thread_fn+0x206/0x320
> [    0.455700]  [<ffffffff8106c5f0>] ? lg_global_unlock+0x60/0x60
> [    0.455720]  [<ffffffff81063cad>] kthread+0xad/0xc0
> [    0.455740]  [<ffffffff81730303>] ? _dbgp_external_startup+0x236/0x392
> [    0.455744]  [<ffffffff81063c00>] ? kthread_create_on_node+0x130/0x130
> [    0.455752]  [<ffffffff8173a4be>] ret_from_fork+0x4e/0x80
> [    0.455756]  [<ffffffff81063c00>] ? kthread_create_on_node+0x130/0x130
> 
> 
> So it crashed in the kthread instead of the irq, but exactly the same issue,
> that particular field is not initialized.  Not that these aren't patches
> that look like good ideas.

Hmm, so this looks like RT-specific now AFAICT.

mce_notify_irq() calls mce_notify_work() and on RT_FULL that's
trying to wake up mce_notify_helper which is not initialized yet -
mce_notify_work_init() happens later in a device_initcall_sync.

Would something as trivial as this work in your case?

---
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index aaf4b9b94f38..cc70d98a30f6 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1391,7 +1391,8 @@ static int mce_notify_work_init(void)
 
 static void mce_notify_work(void)
 {
-	wake_up_process(mce_notify_helper);
+	if (mce_notify_helper)
+		wake_up_process(mce_notify_helper);
 }
 #else
 static void mce_notify_work(void)


-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
