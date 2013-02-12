From: Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: Re: Random 3 to 4.5 second blocks of RT thread
Date: Tue, 12 Feb 2013 09:28:43 -0500
Message-ID: <CADkTA4ME9Ce1_vc8e60t_BmH5FZ55u5mYhRNCNuCRLMBOjU4Gw@mail.gmail.com>
References: <8426D3F6-9553-4B6A-B318-4983625ACC8E@bj-ig.de>
	<CADkTA4MNMCm-6T7rN+9-kujpO4hUmXJmR7hTOkVy2y4xGWX5BQ@mail.gmail.com>
	<7E3E5777-3AD4-4A87-B27D-6B3D152DE296@bj-ig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Realtime Mailinglist <linux-rt-users@vger.kernel.org>,
	Thomas Weisser <thomas@bj-ig.de>
To: =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:63077 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759654Ab3BLO2p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Feb 2013 09:28:45 -0500
Received: by mail-la0-f51.google.com with SMTP id fo13so135024lab.10
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Feb 2013 06:28:43 -0800 (PST)
In-Reply-To: <7E3E5777-3AD4-4A87-B27D-6B3D152DE296@bj-ig.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Feb 12, 2013 at 7:53 AM, Ralf M=FCller <ralf@bj-ig.de> wrote:
>
> Am 11.02.2013 um 18:08 schrieb Bruce Ashfield:
>
>> On Mon, Feb 11, 2013 at 10:54 AM, Ralf M=FCller <ralf@bj-ig.de> wrot=
e:
>>>
>>> I've got a problem with a box at a customer, where about once a day=
 (overall 20 events in 16 days) a realtime thread blocks for 3 to 4.5 s=
econds. ... It basically is a loop that wakes up every milli second ...=
 It does this quite well - except for these random multi second sleeps.
>>
>> Since you mentioned BIOS, I assume that you are running on a x86 pla=
tform.
>
> It's x86 - yes.
>
>> I noted that you didn't mention if SMIs have been ruled out as a cau=
se of the
>> latency issues. You've probably already ruled this out, but I figure=
d I'd ask
>> anyway :)
>
> The question is a good one. What I read about SMI when I started this=
 project, said that expected latencies from SMI would be something from=
 some micro- to a maximum of some milliseconds. As my latency constrain=
ts are relatively weak - I can perfectly live with 50 microseconds and =
I would not be happy, but could at least deal with 10 milliseconds ever=
y now and then - I did not follow that trail very far. When SMI can rea=
lly create 3 to 4 seconds blocks I will have to look into that deeper .=
=2E. anyway - I will have a look at SMI the next days. Thanks a lot for=
 that hint.
>

I agree that such a long SMI isn't likely, but running the hwlat
detector is a fairly simple
way to see if time is in fact being stolen from your kernel, so it's
something to look into.

> BTW: Are there any links to SMI events in a multi second range? What =
in a system is done within such a long time span?

I've never seen it first hand, but I have heard of thermal SMIs that
can "borrow" quite
a bit of time (depending on what your platform is doing). Like
anything, not all BIOS/SMIs
are created equal :) Which of course can be more of a problem in your
case, since it
sounds like you aren't on exactly the same h/w as the problematic syste=
m.

Anyway, just a thought and something to rule out.

If the customer machines can have tracing enabled, you can always set
a latency threshold
and stop tracing when it is crossed. That should get you insight into
what is happening in
the long latency case.

Cheers,

Bruce

>
> Best regards
> Ralf
>



--
"Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end"
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
