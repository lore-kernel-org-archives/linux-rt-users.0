From: Geunsik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH RESEND] cyclictest: Fixed incorrect wakeup reset interface
Date: Wed, 9 Mar 2011 23:18:32 +0900
Message-ID: <AANLkTimao8wMvBcK-CYWM17e-dsJytdg+DK9KDBFNgJE@mail.gmail.com>
References: <1299287891-591-1-git-send-email-leemgs1@gmail.com>
	<4D769CD4.6090806@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: williams@redhat.com, jkacur@redhat.com,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59616 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250Ab1CIOSd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Mar 2011 09:18:33 -0500
Received: by qyg14 with SMTP id 14so460427qyg.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Mar 2011 06:18:32 -0800 (PST)
In-Reply-To: <4D769CD4.6090806@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 9, 2011 at 6:17 AM, Carsten Emde <C.Emde@osadl.org> wrote:
> On 03/05/2011 02:18 AM, Geunsik Lim wrote:
>>
>> When we try to run ftrace with cyclictest command of rt-test,
>> We view the error according to base kernel version.
>> We need to modify this hard coded interface.
>>
>> Signed-off-by: Geunsik Lim<geunsik.lim@samsung.com>
>> ---
>> =C2=A0src/cyclictest/cyclictest.c | =C2=A0 =C2=A03 ++-
>> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>> [..]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setkernvar("laten=
cy_hist/wakeup_latency/reset", "1");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setkernvar("laten=
cy_hist/wakeup/reset", "1");
>
> This is correct. It considers a directory name change made longtime a=
go.
>
>> [..]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setkernvar("t=
race_enabled", "1");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setkernvar("laten=
cy_hist/wakeup_latency/reset", "1");
>
> This is not correct - probably an unintended insertion of the line th=
at was
> removed above.
>
> Would you mind to resubmit the patch with the first part only?
Ok. I will resubmit this patch after modification.
Thank you for your review.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Carsten.
>



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
