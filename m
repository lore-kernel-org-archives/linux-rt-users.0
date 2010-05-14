From: ratheesh k <ratheesh.ksz@gmail.com>
Subject: Re: preempt_disable and sleep()
Date: Fri, 14 May 2010 08:16:07 +0530
Message-ID: <AANLkTilMrwdaLrTAUVETYZLYSpoqVFVXfKZ2lZit6uG3@mail.gmail.com>
References: <AANLkTinbwZK5Tp6aI4ja38XaiiB5aIyECzHPdMpvkaIy@mail.gmail.com>
	 <1273776201.11899.23.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:65163 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab0ENCqI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 May 2010 22:46:08 -0400
In-Reply-To: <1273776201.11899.23.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, May 14, 2010 at 12:13 AM, Sven-Thorsten Dietrich
<thebigcorporation@gmail.com> wrote:

> Why would you do this?
I was reading some linux kernel journel about preempt_disable() . This
a doubt came to me .


> If you had tried this code, you would have seen the corresponding sta=
ck
> dump on the console.


Why it so .? could you explain a little more ? .sleep() will schedule
() , which inturn give back control to kernel .

Thank,
Ratheesh

On Fri, May 14, 2010 at 12:13 AM, Sven-Thorsten Dietrich
<thebigcorporation@gmail.com> wrote:
> On Fri, 2010-05-14 at 00:02 +0530, ratheesh k wrote:
>> I am running RT linux .
>>
>> /* code snippet */
>>
>> preempt_disable()
>> ...........
>> sleep(10);
>> '............
>> preempt_enable()
>>
>>
>> will this sleep() will cause reschedule ?.
>>
>
> Why would you do this?
>
> If you had tried this code, you would have seen the corresponding sta=
ck
> dump on the console.
>
>> if an interrupt comes =A0while premption is disabled , how it is han=
dled ?.
>>
>
> Depends on the number of (idle) cores, the setting of CONFIG_PREEMPT_=
[]
> and the type of interrupt.
>
> RT threaded IRQs would not run until preemption is enabled on a singl=
e
> core system.
>
>
>
>> Thanks,
>> Ratheesh
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
