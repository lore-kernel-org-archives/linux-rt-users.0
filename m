Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48315 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeIXNZl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Sep 2018 09:25:41 -0400
References: <73d0tbdjqz.fsf@pengutronix.de> <714e73d5-f7ce-bdcf-b7fd-fc9f02b12693@roeck-us.net> <20180919064619.soi27bbq3xtatpxp@pengutronix.de> <20180919194303.GA5033@roeck-us.net> <20180920204843.GY23084@jcartwri.amer.corp.natinst.com>
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [BUG] dw_wdt watchdog on linux-rt 4.18.5-rt4 not triggering
In-reply-to: <20180920204843.GY23084@jcartwri.amer.corp.natinst.com>
Date: Mon, 24 Sep 2018 09:24:52 +0200
Message-ID: <73in2vl5mj.fsf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Christophe Leroy <christophe.leroy@c-s.fr>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>


Hi!

Julia Cartwright <julia@ni.com> writes:

> Hello all-
>
> On Wed, Sep 19, 2018 at 12:43:03PM -0700, Guenter Roeck wrote:
>> On Wed, Sep 19, 2018 at 08:46:19AM +0200, Steffen Trumtrar 
>> wrote:
>> > On Tue, Sep 18, 2018 at 06:46:15AM -0700, Guenter Roeck 
>> > wrote:
> [..]
>> > The problem I observe, is that the watchdog is trigged, 
>> > because it doesn't get pinged.
>> > The ksoftirqd seems to be blocked although it runs at a much 
>> > higher priority than the
>> > blocking userspace task.
>> >
>> Are you sure about that ? The other email seemed to suggest 
>> that the userspace
>> task is running at higher priority.
>
> Also: ksoftirqd is irrelevant on RT for the kernel watchdog 
> thread.  The
> relevant thread is ktimersoftd, which is the thread responsible 
> for
> invoking hrtimer expiry functions, like what's being used for 
> watchdogd.
>
> [..]
>> Overall, we have a number possibilities to consider:
>>
>> - The kernel watchdog timer thread is not triggered at all 
>> under some
>>   circumstances, meaning it is not set properly. So far we have 
>>   no real
>>   indication that this is the case (since the code works fine 
>>   unless some
>>   userspace task takes all available CPU time).
>
> What do you mean by "not triggered".  Do you mean 
> woken-up/activated
> from a scheduling perspective?  In the case I identified in my 
> other
> email, the watchdogd thread wakeup doesn't even occur, even when 
> the
> periodic ping timer expires, because ktimersoftd has been 
> starved.
>
> I suspect that's what's going on for Steffen, but am not yet 
> sure.
>
>> - The watchdog device is closed. The kernel watchdog timer 
>> thread is
>>   starved and does not get to run. The question is what to do 
>>   in this
>>   situation. In a real time system, this is almost always a 
>>   fatal
>>   condition. Should the system really be kept alive in this 
>>   situation ?
>
> Sometimes its the right decision, sometimes its not.  The only 
> sensible
> thing to do is to allow the user make the decision that's right 
> for
> their application needs by allowing the relative prioritization 
> of
> watchdogd and their application threads.
>
> ...which they can do now, but it's not effective on RT because 
> of the
> timer deferral through ktimersoftd.
>
> The solution, in my mind, and like I mentioned in my other 
> email, is to
> opt-out of the ktimersoftd-deferral mechanism.  This requires 
> some
> tweaking with the kthread_worker bits to ensure safety in 
> hardirq
> context, but that seems straightforward.  See the below.
>

I just tested your patch and it works for me \o/


Thanks,
Steffen

-- 
Pengutronix e.K.                          | Steffen Trumtrar 
|
Industrial Linux Solutions                | 
http://www.pengutronix.de/ |
Peiner Str. 6-8, 31137 Hildesheim, Germany| Phone: 
+49-5121-206917-0   |
Amtsgericht Hildesheim, HRA 2686          | Fax: 
+49-5121-206917-5555|
