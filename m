From: Gregoire Gentil <gregoire@gentil.com>
Subject: Re: cpufreq + PREEMPT_RT_FULL give bad context sleeping BUG
Date: Wed, 27 Mar 2013 08:23:16 -0700
Message-ID: <51530EE4.1040600@gentil.com>
References: <alpine.LFD.2.02.1303222301010.22263@ionos> <20130323013003.GU11538@uudg.org> <514DE3BF.5010800@gentil.com> <20130326205107.GB14220@linutronix.de> <alpine.LFD.2.02.1303262203560.22263@ionos> <20130326213356.GC14220@linutronix.de> <alpine.LFD.2.02.1303262236300.22263@ionos> <alpine.LFD.2.02.1303262243540.22263@ionos>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Rob Herring <rob.herring@calxeda.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:51215 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab3C0P3z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Mar 2013 11:29:55 -0400
In-Reply-To: <alpine.LFD.2.02.1303262243540.22263@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 03/26/2013 02:44 PM, Thomas Gleixner wrote:
> On Tue, 26 Mar 2013, Thomas Gleixner wrote:
>
>> On Tue, 26 Mar 2013, Sebastian Andrzej Siewior wrote:
>>
>>> * Thomas Gleixner | 2013-03-26 22:07:45 [+0100]:
>>>
>>>>> that means it should trigger on mainline as well.
>>>>
>>>> No. It won't. Mainline uses a spinlock which gets converted to a
>>>> sleeping spinlock on rt.
>>>>
>>>>   (rt_spin_lock+0x30/0x64) from (clk_get_rate+0x30/0x54)
>>>
>>> This is true but this spinlock in only available in the OOT code
>>> Gregoire Gentil pointed out ([0]). In mainline we have a mutex in
>>> drivers/clk/clk.c and this is what my omap4 blaze is using.
>>>
>>> [0] http://dev.omapzoom.org/?p=3Dintegration/kernel-ubuntu.git;a=3D=
blob;f=3Darch/arm/plat-omap/clock.c;h=3D8c0e8fe2c5c51673e41e4304194d922=
dbfaedf38;hb=3D3e1c9f139425663ceee48f92e8d3f23158580334
>>
>> Yeah, it's that way in mainline as well.
>
> I meant, that the mutex is taken. So yes, this will cause a warning i=
n
> !RT too.
Hello,

So what could be a tentative solution? Could you advise what I could tr=
y?

Many thanks in advance,

Gr=E9goire

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
