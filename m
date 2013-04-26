From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT v2] x86/mce: Defer mce wakeups to threads for
 PREEMPT_RT
Date: Fri, 26 Apr 2013 10:24:07 +0200
Message-ID: <20130426082407.GB20927@linutronix.de>
References: <1365705214.9609.58.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47546 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab3DZIYI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Apr 2013 04:24:08 -0400
Content-Disposition: inline
In-Reply-To: <1365705214.9609.58.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2013-04-11 14:33:34 [-0400]:

>diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
>index e8d8ad0..060e473 100644
>--- a/arch/x86/kernel/cpu/mcheck/mce.c
>+++ b/arch/x86/kernel/cpu/mcheck/mce.c
>@@ -1308,6 +1309,61 @@ static void mce_do_trigger(struct work_struct *work)
> 
> static DECLARE_WORK(mce_trigger_work, mce_do_trigger);
> 
>+static void __mce_notify_work(void)
>+{
>+	/* Not more than two messages every minute */
>+	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
>+
>+	/* wake processes polling /dev/mcelog */
>+	wake_up_interruptible(&mce_chrdev_wait);
>+
>+	/*
>+	 * There is no risk of missing notifications because
>+	 * work_pending is always cleared before the function is
>+	 * executed.
>+	 */
>+	if (mce_helper[0] && !work_pending(&mce_trigger_work))
>+		schedule_work(&mce_trigger_work);

Why is here this work_pending() check? You can't enqueue a work item
twice.

Sebastian
