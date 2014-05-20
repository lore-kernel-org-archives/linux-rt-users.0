From: jordan <triplesquarednine@gmail.com>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS:
 linux-rt-3.14 boots by reverting patches + nvidia uses __rt_mutex_init [which
 in 3.14 has been changed to EXPORT_SYMBOL_GPL]
Date: Tue, 20 May 2014 16:27:08 -0400
Message-ID: <CAOcfFMyUfrwbctn6Zezs5pWuNX1=Gnc+CS-dAkNO9_xn+6hdsA@mail.gmail.com>
References: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
	<CAOcfFMynnyHL_G6Gez_AZYFky=hLYeoyY8WVHF572RZq1g_aBw@mail.gmail.com>
	<CAP=VYLrHC3TPAixV8m0u9g8ooyiE0jvS=7bFLHDdCwt3wsA1iA@mail.gmail.com>
	<CAOcfFMy_Ui94baWzuAMKOnUpcjYpnNsubdDCNTZx52XokVyN6g@mail.gmail.com>
	<535A7474.2090701@windriver.com>
	<CAOcfFMyjup8OAkxHj-hbb5rMzrPjNPpw_9Jdx-iXPi09ce-Zuw@mail.gmail.com>
	<535A9DDC.4070801@windriver.com>
	<5372BB0C.8030303@me.com>
	<1400505275.3482.5.camel@archlinux>
	<1400505358.3482.6.camel@archlinux>
	<20140519171603.6c0c2ec2@tor.valhalla.alchemy.lu>
	<1400526129.839.10.camel@archlinux>
	<20140520203655.307d2e38@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joakim Hernberg <jbh@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:49191 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbaETU1K (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 May 2014 16:27:10 -0400
Received: by mail-ve0-f169.google.com with SMTP id jx11so1327031veb.28
        for <linux-rt-users@vger.kernel.org>; Tue, 20 May 2014 13:27:09 -0700 (PDT)
In-Reply-To: <20140520203655.307d2e38@tor.valhalla.alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey guys,

>> I tried both rt-lts and rt from the repo, not from AUR, for a x86_64
>> install.
>>
>> $ pacman -Q linux-rt-lts
>> linux-rt-lts 3.10.39_rt40-1
>>
>> I only tried to boot it one time.
>> Startup finished with a black screen, the display manager wasn't
>> visible.
>>
>> $ pacman -Q linux-rt
>> linux-rt 3.14.3_rt5-1
>>
>> The first time I booted it, a restart happened during startup.
>> The second time I booted it, startup hung.
>>
>
> If so I have no idea...  Maybe ask Jordan, as he has been having a
> similar problem with AMD.  Maybe try his linux-l-pa kernel from the AUR.

No, what Ralf is describing sounds different to me, for a couple of reasons;

1). I've never had a restart during startup.
2). I never had a blank screen on startup
3). I never had a problem with 3.10-rt [although, i suppose if the 3
RT patches have been backported, then 3.10-lts wouldn't boot for me,
either. - haven't used 3.10-rt since 3.12-rt came out.]

My Phenom just doesn't boot on -rt [3.12.x-rt9+], unless i revert the
3 problematic patches. Ralf seems to have something else happening.  I
know that a couple of weeks ago, Pawel [on this list] also tried
reverting the same patches on one of his problematic AMD systems,
which did not yield a working system for him, either. IIRC, he could
only boot into that kernel by passing some kernel paramters, disabling
SMP, etc. [and like Ralf, the symptoms didn't seem quite the same as
mine, or other AMD users who's systems don't work, without reverting
said patches.].

but everyone [that i know] who couldn't boot on 3.12.x-rt9+ can boot
just fine, when ditching those 3 rt patches. - So again, i think it is
likely that Pawel and Ralf's problem[s] may not be the same, as the
"revert_timers-dont_raise_softirq_unconditionally_and_fixes.patch"
resolves.

Jordan

> --
>
>    Joakim
