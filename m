From: jordan <triplesquarednine@gmail.com>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS:
 linux-rt-3.14 boots by reverting patches + nvidia uses __rt_mutex_init [which
 in 3.14 has been changed to EXPORT_SYMBOL_GPL]
Date: Wed, 14 May 2014 09:18:12 -0400
Message-ID: <CAOcfFMxLAeqqf-WuwNzE0im800EGN-=OBP06Wz0h8sUr=EKWig@mail.gmail.com>
References: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
	<CAOcfFMynnyHL_G6Gez_AZYFky=hLYeoyY8WVHF572RZq1g_aBw@mail.gmail.com>
	<CAP=VYLrHC3TPAixV8m0u9g8ooyiE0jvS=7bFLHDdCwt3wsA1iA@mail.gmail.com>
	<CAOcfFMy_Ui94baWzuAMKOnUpcjYpnNsubdDCNTZx52XokVyN6g@mail.gmail.com>
	<535A7474.2090701@windriver.com>
	<CAOcfFMyjup8OAkxHj-hbb5rMzrPjNPpw_9Jdx-iXPi09ce-Zuw@mail.gmail.com>
	<535A9DDC.4070801@windriver.com>
	<5372BB0C.8030303@me.com>
	<20140514021740.GE22474@windriver.com>
	<CAOcfFMxipjwdNPOHhxgaMU_MvSKYe5bfexhn71xvx026431YDA@mail.gmail.com>
	<53733175.9020300@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Kimmo Taskinen <kimmo.taskinen@me.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:48633 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653AbaENNSN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 May 2014 09:18:13 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so2411967vcb.29
        for <linux-rt-users@vger.kernel.org>; Wed, 14 May 2014 06:18:12 -0700 (PDT)
In-Reply-To: <53733175.9020300@me.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey Kimmo,

>> you can get the patch here; http://pastebin.com/VG7X5WjK ... it
>> applies over 3.14.3-rt5 [after you've already applied the -rt patch,
>> you apply it]. It's yielded working AMD Phenom systems for me
>> [although, i don't have the exact same H/W as you]. it might be worth
>> a try, just to see if it works.
>
> I can confirm that applying the patch in http://pastebin.com/VG7X5WjK to
> 3.14.3-rt5 makes my system bootable even with AMD C1E enabled.
> To clarify my previous email, those other tricks "processor.max_cstate=0",
> "processor.nocst", etc... did not help.

Well, it looks like you are another person who's system is unstable
when those 3 upstream -rt patches are applied. Reverting [as you have
done now] should result in a usable/stable system for you [its worked
for myself and others for a few releases now. Maybe you can post back
on how that goes for you?]. Although, depending on config; ie: if you
are using no_hz_idle/full you may see "NOHZ: softirq pending 40"
[which one of the patches we reverted fixes, IIRC]. Myself, I don't
use NO_HZ_* and use the 'periodic timers' in the kernel, instead.

anyway, I am not sure how to fix this, beyond reverting / using that
patch. I know that some of the devs have had a hard time reproducing
the problem - maybe Paul will have better luck on another AMD system
[here is hoping]. But at least for now, you should be able to use that
patch.

jordan

> Kimmo
>>
>>
>>> OK, so I never got back to finding a system that could reproduce this,
>>> but it sounds like it is still worthwhile; thanks for the reminder and
>>> I'll go see if I can reproduce this on a quad since the six core was OK.
>>
>> Hey Paul, I also forgot to get back to you ;) ... I had been carrying
>> over my .config - so i tried using defconfig too [just to see] and it
>> was no different. I was astonished that yours booted up just fine,
>> because i know of other AMD users [aside from Kimmo] who can't boot on
>> vainlla-rt... Again, 3.14.x-rtX boot and work just fine for me, by
>> reverting those patches. I had thought maybe -rt5 would boot [it
>> looked to have some substantial changes], but alas -rt5 also required
>> the patch for a working system.
>>
>> Jordan
>>
>>> P.
>>> --
>>>
>>>> Cheers
>>>> Kimmo
>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> linux-rt-users" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>
