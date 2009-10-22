From: yi li <liyi.dev@gmail.com>
Subject: Re: A question about cpu_idle()
Date: Fri, 23 Oct 2009 00:24:24 +0800
Message-ID: <a0e7fce50910220924s4b640cbi51af6d7e791e98e9@mail.gmail.com>
References: <a0e7fce50910202007l587d2cfcu91b455ff0486110b@mail.gmail.com>
	 <4ADE5A2B0200005A00057082@sinclair.provo.novell.com>
	 <a0e7fce50910212130h385cdbe1ucbb4fe00233eb0bb@mail.gmail.com>
	 <4AE019210200005A00057226@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:59658 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407AbZJVQYU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 12:24:20 -0400
Received: by yxe17 with SMTP id 17so7130001yxe.33
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 09:24:24 -0700 (PDT)
In-Reply-To: <4AE019210200005A00057226@sinclair.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Oct 22, 2009 at 8:34 PM, Gregory Haskins <ghaskins@novell.com> =
wrote:
> Yes, that is right. =A0irq_disable is a effective superset of preempt=
-disable() in this context because it also blocks those RESCHED_IPI eve=
nts from being received. =A0Of course, disabling interrupts also has ot=
her side effects since it also disables *all* interrupts (like timers, =
etc) so it should be used sparingly. =A0In this case, we are simply bri=
dging the preempt_enable_no_resched() and schedule() to make sure it is=
 truly an atomic transition to a sleep state, so its use is justified.
>
> I hope this helps, and feel free to ask any more questions you wish.

Thanks. Yes it make sense to me.

Another question may be basic - but I just cannot figure out.

Why PREEMPT_RT patch disables local irq (with local_irq_disable())
before __schedule()? Is it to ensure atomic excution of __schedule()?
If so, does that mean, linux kernel without PREEMPT_RT patch suffers
from racy problem in schedule()?

asmlinkage void __sched schedule(void)
{
  need_resched:
         local_irq_disable();
         __schedule();
         local_irq_enable();

        if (need_resched())
                goto need_resched;
}

I saw similiar code in preempt_schedule(), __cond_schedule() and
preempt_schedule_irq().

Regards,
-Yi
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
