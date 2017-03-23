From: Lionel DEBIEVE <lionel.debieve@st.com>
Subject: Re: [PATCH RT 1/1] remoteproc: Prevent schedule while atomic
Date: Thu, 23 Mar 2017 08:28:51 +0000
Message-ID: <7b1ffee6-1f78-7b9f-206e-27a9b6cd967f@st.com>
References: <1490195923-9560-1-git-send-email-lionel.debieve@st.com>
 <20170322173759.GK10423@jcartwri.amer.corp.natinst.com>
 <20170322110116.4b14dafd@vmware.local.home>
 <21d6cfe5-3263-4eeb-c35b-c75f34185526@ti.com>
 <20170322184733.GL10423@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Cc: Steven Rostedt <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>
To: Julia Cartwright <julia@ni.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lee Jones <lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170322184733.GL10423@jcartwri.amer.corp.natinst.com>
Content-Language: en-US
Content-ID: <E91C1F77F6357B43ABDBAF866AAB2660@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/22/2017 07:47 PM, Julia Cartwright wrote:
> On Wed, Mar 22, 2017 at 01:30:12PM -0500, Grygorii Strashko wrote:
>> On 03/22/2017 01:01 PM, Steven Rostedt wrote:
>>> On Wed, 22 Mar 2017 12:37:59 -0500
>>> Julia Cartwright <julia@ni.com> wrote:
>>>
>>>> Which kernel were you testing on, here?  From what I can tell, this
>>>> should have been fixed with Thomas's commit:
>>>>
>>>>     2a1d3ab8986d ("genirq: Handle force threading of irqs with primary
>>>> and thread handler")
>>> Thanks Julia for looking into this. I just looked at the code, and saw
>>> that it does very little with the lock held, and was fine with the
>>> conversion. But if that interrupt handler should be in a thread, we
>>> should see if that's the issue first.
>>
>> It will not be threaded because there are IRQF_ONESHOT used.
>>
>> 	ret = devm_request_threaded_irq(&pdev->dev, irq,
>> 					sti_mbox_irq_handler,
>> 					sti_mbox_thread_handler,
>> 					IRQF_ONESHOT, mdev->name, mdev);
> Indeed.  I had skipped over this important detail when I was skimming
> through the code.
>
> Thanks for clarifying!
>
> Is IRQF_ONESHOT really necessary for this device?  The primary handler
> invokes sti_mbox_disable_channel() on the interrupting channel, which I
> would hope would acquiesce the pending interrupt at the device-level?
>
> Also, as written there are num_inst reads of STI_IRQ_VAL_OFFSET in the
> primary handler, which seems inefficient...(unless of course reading
> incurs side effects, here).
>
>     Julia

First to reply Julia, test was made using 4.9.y kernel branch.
For the IRQF_ONESHOT, I rely on Lee (adding in mail thread) that was at the device driver origin.

Steven, you're also right as the patch can be also pushed in mainline too.

Lionel
