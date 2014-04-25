From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS: linux-rt-3.14
 boots by reverting patches + nvidia uses __rt_mutex_init [which in 3.14 has
 been changed to EXPORT_SYMBOL_GPL]
Date: Fri, 25 Apr 2014 13:39:40 -0400
Message-ID: <535A9DDC.4070801@windriver.com>
References: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>	<CAOcfFMynnyHL_G6Gez_AZYFky=hLYeoyY8WVHF572RZq1g_aBw@mail.gmail.com>	<CAP=VYLrHC3TPAixV8m0u9g8ooyiE0jvS=7bFLHDdCwt3wsA1iA@mail.gmail.com>	<CAOcfFMy_Ui94baWzuAMKOnUpcjYpnNsubdDCNTZx52XokVyN6g@mail.gmail.com>	<535A7474.2090701@windriver.com> <CAOcfFMyjup8OAkxHj-hbb5rMzrPjNPpw_9Jdx-iXPi09ce-Zuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:64570 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbaDYRjV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Apr 2014 13:39:21 -0400
In-Reply-To: <CAOcfFMyjup8OAkxHj-hbb5rMzrPjNPpw_9Jdx-iXPi09ce-Zuw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 14-04-25 01:23 PM, jordan wrote:
> On Fri, Apr 25, 2014 at 10:43 AM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
>> On 14-04-19 10:42 AM, jordan wrote:
>>> Hey Paul,
>>>
>>>> I've got some AMD kit that has just been freed up from winter
>>>> heating duty - sometime later this week I should be able to try to
>>>> reproduce what you have seen, and knowing it works w/o the above
>>>> softirq patch monkeying around should be a good lead on this.
>>>
>>> That would be awesome! IIRC, Sebastian said that he didn't have said
>>> h/w CPU kicking around to test with, at some point in my original
>>> thread on this subject... and i just don't have the skill set required
>>
>> So I stuck the -rt patches onto 3.14.1 last night;  made a defconfig
>> and then enabled RT_FULL in the resulting .config and that booted
>> right up on a 1090T six core phenom, which kind of surprised me.
> 
> that surprises me too - maybe 3.14.1 fixed something? ...anyway, I am
> only home for a short while [lunch] but i will try building 3.14.1-rt
> when i get home and see what happens / report back.

I had to drop one ipv6 patch that was now in stable, but otherwise
it was straight forward to make a 3.14.1-rt

P.
--

> 
>> I should be able to dig up an athlon quad and see what it does...
> 
> worth a look, i suppose.
> 
> thanks Paul for the update
> 
> Jordan Johnston
> 
