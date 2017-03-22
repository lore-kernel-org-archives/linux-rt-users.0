From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH RT 1/1] remoteproc: Prevent schedule while atomic
Date: Wed, 22 Mar 2017 13:30:12 -0500
Message-ID: <21d6cfe5-3263-4eeb-c35b-c75f34185526@ti.com>
References: <1490195923-9560-1-git-send-email-lionel.debieve@st.com>
 <20170322173759.GK10423@jcartwri.amer.corp.natinst.com>
 <20170322110116.4b14dafd@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lionel Debieve <lionel.debieve@st.com>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bigeasy@linutronix.de>, <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170322110116.4b14dafd@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On 03/22/2017 01:01 PM, Steven Rostedt wrote:
> On Wed, 22 Mar 2017 12:37:59 -0500
> Julia Cartwright <julia@ni.com> wrote:
>
>> Which kernel were you testing on, here?  From what I can tell, this
>> should have been fixed with Thomas's commit:
>>
>>    2a1d3ab8986d ("genirq: Handle force threading of irqs with primary
>> and thread handler")
>
> Thanks Julia for looking into this. I just looked at the code, and saw
> that it does very little with the lock held, and was fine with the
> conversion. But if that interrupt handler should be in a thread, we
> should see if that's the issue first.


It will not be threaded because there are IRQF_ONESHOT used.

	ret = devm_request_threaded_irq(&pdev->dev, irq,
					sti_mbox_irq_handler,
					sti_mbox_thread_handler,
					IRQF_ONESHOT, mdev->name, mdev);

>
>>
>> Which landed in 4.4.  It forces the primary handler to be threaded as
>> well.
>>
>
> Lionel,
>
> Can you check if this is an issue with 4.4 too?
>


-- 
regards,
-grygorii
