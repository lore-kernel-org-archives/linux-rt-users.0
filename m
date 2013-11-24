From: Michael Langfinger <linux-rt-users@langfinger.org>
Subject: Re: [ANNOUNCE] 3.12.0-rt2
Date: Sun, 24 Nov 2013 11:15:59 +0100
Message-ID: <3e7db7696ffd6cc78182421c0c436a20-EhVcX1hHQARfWkQdAQYAWQoDGQlVS19cWF9EAVxEXEI3UlEWXV5/H1ZVQ15fQioDXFJcQlBdWQ1W-webmailer2@server02.webmailer.hosteurope.de>
References: <20131116194633.GD11518@linutronix.de>
 <EBD2DE4ADA47B94E831AED12A4B0CADA67EE68DA@edb0.wapice.localdomain>
 <20131122142345.GC8698@linutronix.de>
Reply-To: linux-rt-users@langfinger.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Sami_Pietik=C3=A4inen?= <Sami.Pietikainen@wapice.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout02.webmailer.hosteurope.de ([80.237.138.58]:45033 "EHLO
	mailout02.webmailer.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120Ab3KXKQB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 24 Nov 2013 05:16:01 -0500
In-Reply-To: <20131122142345.GC8698@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Hello Sami, hello Sebastian,

 unfortunately I don't have access to the AT91 at the moment, so I can'=
t=20
 test the config myself. But I built the kernel 3.12.0-rt2 and gave my=20
 former colleague with whom I worked on the AT91 a copy of it. I also=20
 updated the build scripts that we used for our specific setup with the=
=20
 AT91, so he will be able to build the kernel himself and test the two=20
 config options Sami posted. I will tell you about his results as soon =
as=20
 I hear from him!

 Kind regards,
 Michael Langfinger

 On Fri, 22 Nov 2013 15:23:45 +0100, Sebastian Andrzej Siewior=20
 <bigeasy@linutronix.de> wrote:
> * Sami Pietik=C3=A4inen | 2013-11-19 07:38:27 [+0000]:
>
>>> - tried to fix AT91's "already-free IRQ" and highres problem.=20
>>> Michael
>>>   Langfinge reported it initially and Sami Pietik=C3=A4inen sent a =
patch=20
>>> for
>>>   the "already-free IRQ" problem. Based on another patch I looked=20
>>> at the
>>>   highres patch and tried to fix it. As I don't have the hardware,=20
>>> some
>>>   feedback would be nice.
>>
>>I did a quick test run with the 3.12.0-rt2 kernel. There are no=20
>> "Trying to free already free IRQ 1" warnings anymore so that issue=20
>> seems to be fixed. However, the system still hangs.
>>
>>CONFIG_HIGH_RES_TIMERS=3Dy
>>CONFIG_ATMEL_TCB_CLKSRC=3Dy
>>Hangs (or resets if the WD is enabled)
>>
>>CONFIG_HIGH_RES_TIMERS=3Dy
>>CONFIG_ATMEL_TCB_CLKSRC=3Dn
>>Boots ok.
>>
>>Now the kernel boots with the CONFIG_HIGH_RES_TIMERS enabled, but=20
>> hangs when I enable the TCB clock source.
>>Michael, if you have spare time, maybe you could also test these=20
>> configs to see if you have similar behavior.
> Okay. So in the working variant with TCB=3Dn, do you have high res=20
> timers
> available?
>
>>BR,
>>Sami Pietik=C3=A4inen
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
