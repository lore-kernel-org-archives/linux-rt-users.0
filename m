From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH RESEND v2] cyclictest: Fixed incorrect wakeup reset interface
Date: Wed, 9 Mar 2011 21:27:40 +0100
Message-ID: <AANLkTi=43h0zYwrzMa-asC4ygsqwCiu+ciBOSq7PBTYz@mail.gmail.com>
References: <1299683339-14381-1-git-send-email-leemgs1@gmail.com>
	<4D779D0F.8020003@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geunsik Lim <leemgs1@gmail.com>, williams@redhat.com,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57823 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245Ab1CIU1l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Mar 2011 15:27:41 -0500
Received: by qwd7 with SMTP id 7so701266qwd.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Mar 2011 12:27:40 -0800 (PST)
In-Reply-To: <4D779D0F.8020003@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 9, 2011 at 4:30 PM, Carsten Emde <C.Emde@osadl.org> wrote:
>
> On 03/09/2011 04:08 PM, Geunsik Lim wrote:
>>
>> When we try to run ftrace with cyclictest command of rt-test,
>> We view the error according to base kernel version.
>> We need to modify this hard coded interface.
>>
>> Signed-off-by: Geunsik Lim<geunsik.lim@samsung.com>
>
> We need a space here: Geunsik Lim <geunsik.lim@samsung.com>
>
>> ---
>> =A0src/cyclictest/cyclictest.c | =A0 =A03 ++-
>> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> Oops, this is still old, it's only 1 insertion now. You could have pr=
oduced a real patch, couldn't you?
>
>> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest=
=2Ec
>> index 0847aed..abc0b4e 100644
>> --- a/src/cyclictest/cyclictest.c
>> +++ b/src/cyclictest/cyclictest.c
>> @@ -487,7 +487,7 @@ static void setup_tracer(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setke=
rnvar(traceroptions, traceptr[i]);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setkernvar("tracing_max_latency", "0"=
);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 setkernvar("latency_hist/wakeup_latenc=
y/reset", "1");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setkernvar("latency_hist/wakeup/reset"=
, "1");
>> =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setkernvar("trace_all_cpus", "1");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setkernvar("trace_freerunning", "1");
>
> Acked-by: Carsten Emde <C.Emde@osadl.org>

Did it used to be wakeup_latency in an older version that we still need=
 to
support?
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
