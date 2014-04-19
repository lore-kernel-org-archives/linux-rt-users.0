From: jordan <triplesquarednine@gmail.com>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS:
 linux-rt-3.14 boots by reverting patches + nvidia uses __rt_mutex_init [which
 in 3.14 has been changed to EXPORT_SYMBOL_GPL]
Date: Sat, 19 Apr 2014 10:42:30 -0400
Message-ID: <CAOcfFMy_Ui94baWzuAMKOnUpcjYpnNsubdDCNTZx52XokVyN6g@mail.gmail.com>
References: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
	<CAOcfFMynnyHL_G6Gez_AZYFky=hLYeoyY8WVHF572RZq1g_aBw@mail.gmail.com>
	<CAP=VYLrHC3TPAixV8m0u9g8ooyiE0jvS=7bFLHDdCwt3wsA1iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:61910 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbaDSOmc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Apr 2014 10:42:32 -0400
Received: by mail-ve0-f171.google.com with SMTP id jy13so4823160veb.2
        for <linux-rt-users@vger.kernel.org>; Sat, 19 Apr 2014 07:42:31 -0700 (PDT)
In-Reply-To: <CAP=VYLrHC3TPAixV8m0u9g8ooyiE0jvS=7bFLHDdCwt3wsA1iA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey Paul,

> I've got some AMD kit that has just been freed up from winter
> heating duty - sometime later this week I should be able to try to
> reproduce what you have seen, and knowing it works w/o the above
> softirq patch monkeying around should be a good lead on this.

That would be awesome! IIRC, Sebastian said that he didn't have said
h/w CPU kicking around to test with, at some point in my original
thread on this subject... and i just don't have the skill set required
[so i am very appreciative of anything you can do].  I don't know if
you caught it, but slavo also saw this thread, which led him to try
reverting those patches, which also allowed his arm platform to boot;
http://www.spinics.net/lists/linux-rt-users/msg11655.html ...
Eventually, after sorting out another issue he had [possible
mis-patching, KernelStack problem], slavo posted the same reverse-rt
timer code patch that i am using [applies after unified rt patch] that
works; http://pastebin.com/MYLqbmZw ... So this isn't just an AMD
problem [and i am not sure what amd cpus are affected, other than
'positively' Phenom branded cpus - which are generally fairly decent
on -rt, in my use. likewise i am not sure what other ARM platforms are
affected - maybe someone else can speak up/take a look].

* Also, [i have had several users report this to me] NO_HZ_FULL on
3.14-rt can be problematic / lead to serious instability. [on amd
Phenom anyway]. One person i know was getting lockups just by
connecting Pulseaudio to his USB soundcard, i even had one lockup
[nothing to do with PA]. Switching to periodic timers [old tick] fixed
everything for everyone. the newer  no_hz_ code is still a little
dicey on -rt.

anyway, give it a try, when you get a chance. In my own builds, for
now - i am good to go [as far as performance / stability]. But i
obviously had to; 1). revert the rt timer changes/commits, 2). switch
to preiodic timers ...which was enough for 3.14-rt to work okay, but
3). Picked up the softirq-resurrect-threads.patch [IIRC, Steven
forward ported mingo's softirq split from 2.6.xx-rt to 3.2-rt or
3.4-rt], but i grabbed it from Mike Galbraith's post;
http://www.spinics.net/lists/linux-rt-users/msg11204.html ~ I wish
this patch was in linux-rt/upstream. [actually, both].

now 3.14-rt is a happy camper ;)

Jordan

> Paul.
> --
>
>> look at those patches again - and i am more than willing to test
>> subsequent revisions to see if we can get these troublesome AMD
>> machines to boot with them applied..
>>
>> ...regarding nvidia on PREEMPT_RT_FULL / EXPORT_SYMBOL_GPL for
>> __rt_mutex_init - i notified nvidia of the problem [although, it is an
>> upstream linux problem]. Interestingly, this problem has already
>> cropped up during 3.0 development cycle on PREEMPT_RT_FULL - where the
>> __rt_mutex_init was changed to gpl-only symbol - only to be changed
>> back to SYMBOL_EXPORT shortly thereafter.... and yes, i realize
>> 'everybody hates nvidia' - but i have to imagine there might be an MIT
>> licensed out-of-tree module or two [or other gpl-compatible license]
>> that might rely on being able to use __rt_mutex_init and now can't...
>> meaning i doubt this is _just_ an nvidia problem :\
>>
>> as it stands, one must either change nvidia's licenses to GPL [makeing
>> nvidia non-distibutable]...
>>
>> or change 'kernel/locking/rtmutex.c' ~
>> EXPORT_SYMBOL_GPL(__rt_mutex_init) to EXPORT_SYMBOL(__rt_mutex_init)
>>
>> ...which obviously makes the kernel GPL-incompatible / non-distributable.
>>
>> I may hit LKML on this issue too, as something needs to happen here -
>> but i thought i would wait and see if i got a response from someone
>> here, first. [being as rt-devs have a little more direct contact with
>> Ingo / subsystem maintainers than i do [ and i am not even subbed to
>> that list].
>>
>> Jordan
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
