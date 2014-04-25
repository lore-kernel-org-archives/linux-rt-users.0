From: jordan <triplesquarednine@gmail.com>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS:
 linux-rt-3.14 boots by reverting patches + nvidia uses __rt_mutex_init [which
 in 3.14 has been changed to EXPORT_SYMBOL_GPL]
Date: Fri, 25 Apr 2014 13:23:27 -0400
Message-ID: <CAOcfFMyjup8OAkxHj-hbb5rMzrPjNPpw_9Jdx-iXPi09ce-Zuw@mail.gmail.com>
References: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
	<CAOcfFMynnyHL_G6Gez_AZYFky=hLYeoyY8WVHF572RZq1g_aBw@mail.gmail.com>
	<CAP=VYLrHC3TPAixV8m0u9g8ooyiE0jvS=7bFLHDdCwt3wsA1iA@mail.gmail.com>
	<CAOcfFMy_Ui94baWzuAMKOnUpcjYpnNsubdDCNTZx52XokVyN6g@mail.gmail.com>
	<535A7474.2090701@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:62420 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbaDYRX2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Apr 2014 13:23:28 -0400
Received: by mail-vc0-f182.google.com with SMTP id lf12so2955497vcb.27
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Apr 2014 10:23:27 -0700 (PDT)
In-Reply-To: <535A7474.2090701@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Apr 25, 2014 at 10:43 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On 14-04-19 10:42 AM, jordan wrote:
>> Hey Paul,
>>
>>> I've got some AMD kit that has just been freed up from winter
>>> heating duty - sometime later this week I should be able to try to
>>> reproduce what you have seen, and knowing it works w/o the above
>>> softirq patch monkeying around should be a good lead on this.
>>
>> That would be awesome! IIRC, Sebastian said that he didn't have said
>> h/w CPU kicking around to test with, at some point in my original
>> thread on this subject... and i just don't have the skill set required
>
> So I stuck the -rt patches onto 3.14.1 last night;  made a defconfig
> and then enabled RT_FULL in the resulting .config and that booted
> right up on a 1090T six core phenom, which kind of surprised me.

that surprises me too - maybe 3.14.1 fixed something? ...anyway, I am
only home for a short while [lunch] but i will try building 3.14.1-rt
when i get home and see what happens / report back.

> I should be able to dig up an athlon quad and see what it does...

worth a look, i suppose.

thanks Paul for the update

Jordan Johnston
