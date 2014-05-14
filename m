From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS:
 linux-rt-3.14 boots by reverting patches + nvidia uses __rt_mutex_init
 [which in 3.14 has been changed to EXPORT_SYMBOL_GPL]
Date: Tue, 13 May 2014 22:17:40 -0400
Message-ID: <20140514021740.GE22474@windriver.com>
References: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
 <CAOcfFMynnyHL_G6Gez_AZYFky=hLYeoyY8WVHF572RZq1g_aBw@mail.gmail.com>
 <CAP=VYLrHC3TPAixV8m0u9g8ooyiE0jvS=7bFLHDdCwt3wsA1iA@mail.gmail.com>
 <CAOcfFMy_Ui94baWzuAMKOnUpcjYpnNsubdDCNTZx52XokVyN6g@mail.gmail.com>
 <535A7474.2090701@windriver.com>
 <CAOcfFMyjup8OAkxHj-hbb5rMzrPjNPpw_9Jdx-iXPi09ce-Zuw@mail.gmail.com>
 <535A9DDC.4070801@windriver.com>
 <5372BB0C.8030303@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: jordan <triplesquarednine@gmail.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Kimmo Taskinen <kimmo.taskinen@me.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:56200 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbaENCRE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 May 2014 22:17:04 -0400
Content-Disposition: inline
In-Reply-To: <5372BB0C.8030303@me.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS: linux-rt-3.14 boots by reverting patches + nvidia uses __rt_mutex_init [which in 3.14 has been changed to EXPORT_SYMBOL_GPL]] On 14/05/2014 (Wed 03:38) Kimmo Taskinen wrote:

> On 25.04.2014 20:39, Paul Gortmaker wrote:
> >On 14-04-25 01:23 PM, jordan wrote:
> >>On Fri, Apr 25, 2014 at 10:43 AM, Paul Gortmaker
> >><paul.gortmaker@windriver.com> wrote:
> >>>On 14-04-19 10:42 AM, jordan wrote:
> >>>>Hey Paul,
> >>>>
> >>>>>I've got some AMD kit that has just been freed up from winter
> >>>>>heating duty - sometime later this week I should be able to try to
> >>>>>reproduce what you have seen, and knowing it works w/o the above
> >>>>>softirq patch monkeying around should be a good lead on this.
> >>>>That would be awesome! IIRC, Sebastian said that he didn't have said
> >>>>h/w CPU kicking around to test with, at some point in my original
> >>>>thread on this subject... and i just don't have the skill set required
> >>>So I stuck the -rt patches onto 3.14.1 last night;  made a defconfig
> >>>and then enabled RT_FULL in the resulting .config and that booted
> >>>right up on a 1090T six core phenom, which kind of surprised me.
> >>that surprises me too - maybe 3.14.1 fixed something? ...anyway, I am
> >>only home for a short while [lunch] but i will try building 3.14.1-rt
> >>when i get home and see what happens / report back.
> >I had to drop one ipv6 patch that was now in stable, but otherwise
> >it was straight forward to make a 3.14.1-rt
> >
> >P.
> >--
> >
> >>>I should be able to dig up an athlon quad and see what it does...
> >>worth a look, i suppose.
> >>
> >>thanks Paul for the update
> >>
> >>Jordan Johnston
> I had not been able to boot my Phenom II X4 910e PC with any of the
> latest RT kernels (3.12 after 3.12.5-rt7 or 3.14 or not even the
> latest 3.10 versions) until I today disabled AMD C1E from BIOS. An
> other way to get it to boot was "acpi=off" as a parameter to kernel
> but I need "button". I tried many others "processor.max_cstate=0",
> "processor.nocst", etc...
> 
> Without RT patch the "AMD C1E" is not a problem.

OK, so I never got back to finding a system that could reproduce this,
but it sounds like it is still worthwhile; thanks for the reminder and
I'll go see if I can reproduce this on a quad since the six core was OK.

P.
--

> 
> Cheers
> Kimmo
> 
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
