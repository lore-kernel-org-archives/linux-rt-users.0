From: Vivek Satpute <vivek@linsyssoft.com>
Subject: Re: hrtimer problem on AT91RM9200
Date: Mon, 24 Aug 2009 12:00:13 +0530
Message-ID: <fae6a9700908232330g40a01698s4785689af7942c2e@mail.gmail.com>
References: <4A8BEF09.2080300@newtec.dk> <20090820195200.GA3331@pengutronix.de>
	 <4A8E99C7.6080106@newtec.dk>
	 <fae6a9700908232327u65fca65bt97bb8c43a91345cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Bo Hansen <bh@newtec.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:47369 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbZHXGaM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Aug 2009 02:30:12 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1224272qwh.37
        for <linux-rt-users@vger.kernel.org>; Sun, 23 Aug 2009 23:30:13 -0700 (PDT)
In-Reply-To: <fae6a9700908232327u65fca65bt97bb8c43a91345cd@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Adding RT-mailing list..

2009/8/24 Vivek Satpute <vivek@linsyssoft.com>:
> Hi Bo,
>
> 2009/8/21 Bo Hansen <bh@newtec.dk>
>>
>> Hi Uwe,
>>
>> I cannot find anything in the dmesg or serial output regarding the
>> WARN_ON_ONCE(...)
>> I guess the WARN_ON_ONCE(...) should show up in dmesg output?
>
> I am not sure that it is directly shown up in dmesg output, but you c=
an
> add printks to verify whether WARN_ON_ONCE() code path hits or not.
>>
>> What puzzles me is that I tried the CONFIG_DEBUG_BUGVERBOSE=3Dy
>> also when I enabled CONFIG_DEBUG_INFO. When I do
>> this I don't get the kernel panic. Is this somehow related to the
>> WARN_ON_ONCE?
>
> I have encountered this scenario. If there is any race condition in c=
ode
> then it might get suppressed when debugging options are enabled and
> kernel does not panic.
>>
>> Attachments only sent to Uwe - anybody are welcome to get a copy.
>>
>> Best regards,
>> Bo
>
> Thanks,
> Vivek Satpute
>>
>>
>> Uwe Kleine-K=F6nig wrote:
>>>
>>> Hello,
>>>
>>>
>>>>
>>>> PC is at clkevt32k_next_event+0x70/0xac
>>>>
>>>
>>> This function has a WARN_ON_ONCE(...). =A0Can you check if this tri=
ggers?
>>>
>>> Can you provide me a kernel image with CONFIG_DEBUG_INFO=3Dy and a
>>> matching oops?
>>>
>>> Best regards
>>> Uwe
>>>
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
