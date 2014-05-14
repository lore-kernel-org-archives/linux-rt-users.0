From: Kimmo Taskinen <kimmo.taskinen@me.com>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS:
 linux-rt-3.14 boots by reverting patches + nvidia uses __rt_mutex_init [which
 in 3.14 has been changed to EXPORT_SYMBOL_GPL]
Date: Wed, 14 May 2014 12:03:49 +0300
Message-ID: <53733175.9020300@me.com>
References: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
 <CAOcfFMynnyHL_G6Gez_AZYFky=hLYeoyY8WVHF572RZq1g_aBw@mail.gmail.com>
 <CAP=VYLrHC3TPAixV8m0u9g8ooyiE0jvS=7bFLHDdCwt3wsA1iA@mail.gmail.com>
 <CAOcfFMy_Ui94baWzuAMKOnUpcjYpnNsubdDCNTZx52XokVyN6g@mail.gmail.com>
 <535A7474.2090701@windriver.com>
 <CAOcfFMyjup8OAkxHj-hbb5rMzrPjNPpw_9Jdx-iXPi09ce-Zuw@mail.gmail.com>
 <535A9DDC.4070801@windriver.com> <5372BB0C.8030303@me.com>
 <20140514021740.GE22474@windriver.com>
 <CAOcfFMxipjwdNPOHhxgaMU_MvSKYe5bfexhn71xvx026431YDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
To: jordan <triplesquarednine@gmail.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from st11p00mm-asmtpout003.mac.com ([17.172.81.2]:41960 "EHLO
	st11p00mm-asmtp003.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751308AbaENJDx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 May 2014 05:03:53 -0400
Received: from [10.0.1.102] (cs181219184.pp.htv.fi [82.181.219.184])
 by st11p00mm-asmtp003.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0N5K00M7Y3UD2880@st11p00mm-asmtp003.mac.com> for
 linux-rt-users@vger.kernel.org; Wed, 14 May 2014 09:03:52 +0000 (GMT)
In-reply-to: <CAOcfFMxipjwdNPOHhxgaMU_MvSKYe5bfexhn71xvx026431YDA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 14.05.2014 05:47, jordan wrote:
>>> I had not been able to boot my Phenom II X4 910e PC with any of the
>>> latest RT kernels (3.12 after 3.12.5-rt7 or 3.14 or not even the
>>> latest 3.10 versions) until I today disabled AMD C1E from BIOS. An
>>> other way to get it to boot was "acpi=off" as a parameter to kernel
>>> but I need "button". I tried many others "processor.max_cstate=0",
>>> "processor.nocst", etc...
>>>
>>> Without RT patch the "AMD C1E" is not a problem.
> Kimmo, have you tried reverting the 3 patches that some of us have had
> success in using to get a booting system?
>
> you can get the patch here; http://pastebin.com/VG7X5WjK ... it
> applies over 3.14.3-rt5 [after you've already applied the -rt patch,
> you apply it]. It's yielded working AMD Phenom systems for me
> [although, i don't have the exact same H/W as you]. it might be worth
> a try, just to see if it works.
I can confirm that applying the patch in http://pastebin.com/VG7X5WjK to 
3.14.3-rt5 makes my system bootable even with AMD C1E enabled.
To clarify my previous email, those other tricks 
"processor.max_cstate=0", "processor.nocst", etc... did not help.

Kimmo
>
>> OK, so I never got back to finding a system that could reproduce this,
>> but it sounds like it is still worthwhile; thanks for the reminder and
>> I'll go see if I can reproduce this on a quad since the six core was OK.
> Hey Paul, I also forgot to get back to you ;) ... I had been carrying
> over my .config - so i tried using defconfig too [just to see] and it
> was no different. I was astonished that yours booted up just fine,
> because i know of other AMD users [aside from Kimmo] who can't boot on
> vainlla-rt... Again, 3.14.x-rtX boot and work just fine for me, by
> reverting those patches. I had thought maybe -rt5 would boot [it
> looked to have some substantial changes], but alas -rt5 also required
> the patch for a working system.
>
> Jordan
>
>> P.
>> --
>>
>>> Cheers
>>> Kimmo
>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>

