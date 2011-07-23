From: Rolando Martins <rolando.martins@gmail.com>
Subject: Re: [ANNOUNCE] 3.0-rt1
Date: Sat, 23 Jul 2011 10:38:58 +0100
Message-ID: <CABcS5h2EMMsKPw7DcQ9XdUKamOe3m4CN1A3hwRyPkfpAMO4Orw@mail.gmail.com>
References: <alpine.LFD.2.02.1107222203400.2702@ionos>
	<CABcS5h01jpOSKcKtrJ65AqNNQDCAOutQADAE_pcRp-MPBoO-VA@mail.gmail.com>
	<alpine.LFD.2.02.1107230930330.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:56411 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab1GWJi7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 05:38:59 -0400
In-Reply-To: <alpine.LFD.2.02.1107230930330.2702@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

Do you see it being fixed in a near future?

Thanks,
Rolando

On Sat, Jul 23, 2011 at 8:31 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> On Fri, 22 Jul 2011, Rolando Martins wrote:
>
>> Thanks for the great work!
>>
>> Is it possible to have RT_GROUP_SCHED and PREEMPT_RT_FULL?
>
> Not at the momenent. RT_GROUP_SCHED depends on !PREEMPT_RT_FULL
> because it leads to yet undebugged hangs and failures.
>
> Thanks,
>
> =A0 =A0 =A0 =A0tglx
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
