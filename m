From: Geunsik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH RESEND v2] cyclictest: Fixed incorrect wakeup reset interface
Date: Thu, 10 Mar 2011 08:32:31 +0900
Message-ID: <AANLkTinLRcaK5fspLRuxdKZ2VgeUjYaYwhMsJ9OnMW-C@mail.gmail.com>
References: <1299683339-14381-1-git-send-email-leemgs1@gmail.com>
	<4D779D0F.8020003@osadl.org>
	<AANLkTinQD_X8-66FU01eFdFdFh7gAY1CfwQSopQkteYZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carsten Emde <C.Emde@osadl.org>, williams@redhat.com,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49608 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1CIXcd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Mar 2011 18:32:33 -0500
Received: by qyg14 with SMTP id 14so958315qyg.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Mar 2011 15:32:32 -0800 (PST)
In-Reply-To: <AANLkTinQD_X8-66FU01eFdFdFh7gAY1CfwQSopQkteYZ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Mar 10, 2011 at 5:26 AM, John Kacur <jkacur@redhat.com> wrote:
>
>
> On Wed, Mar 9, 2011 at 4:30 PM, Carsten Emde <C.Emde@osadl.org> wrote=
:
>>
>> On 03/09/2011 04:08 PM, Geunsik Lim wrote:
>>>
>>> When we try to run ftrace with cyclictest command of rt-test,
>>> We view the error according to base kernel version.
>>> We need to modify this hard coded interface.
>>>
>>> Signed-off-by: Geunsik Lim<geunsik.lim@samsung.com>
>>
>> We need a space here: Geunsik Lim <geunsik.lim@samsung.com>
>>
>>> ---
>>> =C2=A0src/cyclictest/cyclictest.c | =C2=A0 =C2=A03 ++-
>>> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>>
>> Oops, this is still old, it's only 1 insertion now. You could have
>> produced a real patch, couldn't you?
>>
>>> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictes=
t.c
>>> index 0847aed..abc0b4e 100644
>>> --- a/src/cyclictest/cyclictest.c
>>> +++ b/src/cyclictest/cyclictest.c
>>> @@ -487,7 +487,7 @@ static void setup_tracer(void)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setkernvar(traceroptions, tra=
ceptr[i]);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setkernvar("=
tracing_max_latency", "0");
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setkernvar("late=
ncy_hist/wakeup_latency/reset", "1");
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setkernvar("late=
ncy_hist/wakeup/reset", "1");
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setkernvar("=
trace_all_cpus", "1");
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setkernvar("=
trace_freerunning", "1");
>>
>> Acked-by: Carsten Emde <C.Emde@osadl.org>
>
> Did it used to be wakeup_latency in an older version that we still ne=
ed to
> support?
At first, I sent patch file to support both old version(e.g: 2.6.24
and current version(e.g: 2.6.33)
And then, I resent this patch file after update according to the
review of Carsten Emde.
> This is not correct - probably an unintended insertion of the line th=
at was removed abov
At that time, I think that We,may support latest Linux version. So, I
agreed with
Carsten's review. But, I understood incorrectly the reply of Carsten Em=
de about
my initial patch content.

Belows is wakeup interface per each Linus version.  I summarized to und=
erstand
the goal of original patch file.

2.6.24.7-rt23      /sys/kernel/debug/tracing/latency_hist/wakeup_latenc=
y/reset
2.6.31-rc9-rt9.1  /sys/kernel/debug/tracing/latency_hist/wakeup/reset
2.6.33.7.2-rt30   /sys/kernel/debug/tracing/latency_hist/wakeup/reset

John. You are right.  In my case, I am using RHEL5-MRG(2.6.24) and
RHEL6(2.6.32).
We have to support for software compatibility both previous Linux versi=
on
and current Linux version.

John, Please, apply the previous original patch.

Or If Carsten Emde agree with this explanation for consensus,
I will resend  the original patch including additional reviewers like
John , Carsten


file.


--=20
Regards,
Geunsik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 leemgs@gmail.com , leemgs1@gma=
il.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.html
Please read the FAQ at=C2=A0 http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
