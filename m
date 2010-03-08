From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: Use symbolic names for scheduling policy
Date: Mon, 8 Mar 2010 13:48:40 +0100
Message-ID: <520f0cf11003080448o64b6f8b1nd43be217dcc8fcad@mail.gmail.com>
References: <1268011104-22451-1-git-send-email-jkacur@redhat.com>
	 <1268011104-22451-3-git-send-email-jkacur@redhat.com>
	 <4B94B6E1.2060400@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:41615 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab0CHMsm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Mar 2010 07:48:42 -0500
Received: by ewy8 with SMTP id 8so29395ewy.28
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Mar 2010 04:48:40 -0800 (PST)
In-Reply-To: <4B94B6E1.2060400@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 8, 2010 at 9:35 AM, Carsten Emde <Carsten.Emde@osadl.org> w=
rote:
> On 03/08/2010 02:18 AM, John Kacur wrote:
>> - Use symbolic names for scheduling policies, that is, don't assume
>> =A0 =A0 =A0 SCHED_RR is 2, use SCHED_RR instead, and so on.
>>
>> - Fix the logic in handlepolicy(char *polname)
>> =A0 =A0 =A0 - remove the test with the unreachable line,
>> =A0 =A0 =A0 - make the default SCHED_FIFO if we don't recognize the
>> =A0 =A0 =A0 requested policy.
>>
>> Signed-off-by: John Kacur <jkacur@redhat.com>
>> ---
>> =A0src/cyclictest/cyclictest.c | =A0 15 +++++----------
>> =A01 files changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest=
=2Ec
>> index d38c0a7..066ca79 100644
>> --- a/src/cyclictest/cyclictest.c
>> +++ b/src/cyclictest/cyclictest.c
>> @@ -826,13 +826,8 @@ static void handlepolicy(char *polname)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 policy =3D SCHED_FIFO;
>> =A0 =A0 =A0 else if (strncasecmp(polname, "rr", 2) =3D=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 policy =3D SCHED_RR;
>> -
>> - =A0 =A0 if (policy =3D=3D SCHED_FIFO || policy =3D=3D SCHED_RR) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (policy =3D=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 policy =3D 1;
>> - =A0 =A0 }
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 policy =3D 0;
>> + =A0 =A0 else =A0 =A0/* default policy if we don't recognize the re=
quest */
>> + =A0 =A0 =A0 =A0 =A0 =A0 policy =3D SCHED_FIFO;
>> =A0}
>>
>> =A0static char *policyname(int policy)
>> @@ -1303,9 +1298,9 @@ int main(int argc, char **argv)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 par->prio =3D priority;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (priority && !histogram && !smp && !n=
uma)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priority--;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if =A0 =A0 =A0(priority && policy <=
=3D 1) par->policy =3D SCHED_FIFO;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (priority && policy =3D=3D =
2) par->policy =3D SCHED_RR;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0par->policy =3D SCHED_OTHER;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (priority && policy =3D=3D SCHED=
_FIFO) par->policy =3D SCHED_FIFO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (priority && policy =3D=3D =
SCHED_RR) par->policy =3D SCHED_RR;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else =A0par->policy =3D SCHED_OTHER=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 par->clock =3D clocksources[clocksel];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 par->mode =3D mode;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 par->timermode =3D timermode;
> We need to adapt the help message accordingly.
>
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>
>

Hmnn, not sure if I like this one. The message is not perfect as it
stands, but I don't think this is an improvement.
The code seems to parse, fifo, rr, and other.
Internally the numbers are as specified, but we're not parsing them any=
way.

Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
