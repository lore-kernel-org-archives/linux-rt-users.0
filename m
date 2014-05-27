From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] arm: Set hardirq tracing to on when idling
Date: Tue, 27 May 2014 08:21:43 -0500
Message-ID: <53849167.1000309@mvista.com>
References: <1401045323-7116-1-git-send-email-minyard@acm.org> <4559339.apo3Fd10HK@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: minyard@acm.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4559339.apo3Fd10HK@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 05/26/2014 04:26 AM, Arnd Bergmann wrote:
> On Sunday 25 May 2014 14:15:23 minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> The CPU will go to idle with interrupts off, but the interrupts
>> will wake up the idle.  This was causing very long irqsoff trace
>> values because, basically, the whole idle time was traces with
>> irqs off, even though they weren't really off.  Rework the idle
>> code to turn hardirq tracing to on befor calling idle.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>  arch/arm/kernel/process.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> I'm not sure this is correct for all ARM boards, but it fixes the
>> issue for the Vexpress board I have.  No more 4 second irqsoff
>> times.
> If this patch is correct for ARM, I wonder if it should be done
> in architecture independent code instead. Do you see the same
> thing on x86? If not, do you know what's different?

MIPS doesn't idle with IRQs disabled.

x86 calls trace_cpu_idle_rcuidle, but it doesn't re-enable interrupts at
the end of the idle routine.  Adding those trace calls to ARM doesn't
seem to make any difference, though.

> It seems like the right thing to do, I just don't understand
> why nobody hit this before.

Yeah, I'm a little confused by that, too.  The RT guys use ARM
extensively, why haven't they seen this?  Of course, if you run your RT
tests under heavy load, you won't see this since you will never go idle.

-corey
