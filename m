From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Old split quilt queues
Date: Sun, 6 Mar 2016 22:42:18 -0500
Message-ID: <CAP=VYLo5HxhWhxzSNoFki4Wb7maSOduWnNHMpzZja3Hdu7=k5g@mail.gmail.com>
References: <569D6AE1.2090301@ramses-pyramidenbau.de> <alpine.DEB.2.11.1601202151200.3575@nanos>
 <56AA25D6.3070701@ramses-pyramidenbau.de> <alpine.DEB.2.11.1601291210330.3886@nanos>
 <56ABAE2A.2030902@ramses-pyramidenbau.de> <alpine.DEB.2.11.1601292053330.3886@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34061 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbcCGDmt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 6 Mar 2016 22:42:49 -0500
Received: by mail-wm0-f45.google.com with SMTP id p65so91201478wmp.1
        for <linux-rt-users@vger.kernel.org>; Sun, 06 Mar 2016 19:42:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601292053330.3886@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jan 29, 2016 at 2:56 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 29 Jan 2016, Ralf Ramsauer wrote:
>> As I expected, inside that repo are a lot of tags for the various -rt
>> versions.
>> First I thought, RT would make use of rebasing, like:
>>   - Rebase onto the next kernel version and drop unnecessary commits
>> (e.g. patches that went upstream)
>>   - Do some additional changes
>>   - Export vA.B.C...vA.B.C-rtX as split quilt queue
>>
>> But afaict, (at least on the old rt-history), you made a lot of merges
>> from rt/* branches and added tags describing the -rt version. Then you
>> went on merging against master in order to keep up with upstream.
>>
>> Given that, how do you create a split quilt queue, that applies against
>> an upstream tag?
>>
>> For example, let's take the first RT Tag of rt-history: v2.6.31-rc6-rt2
>> How would you create a split quilt queue, that applies against v2.6.31-rc6?
>>
>> (I need to extract all those split quilt queues RT version<->base
>> upstream version)
>
> As I said before: That was an experiment whether git is usable as a tool to
> manage something complex as rt. It turned out, that it's not. I recreated a
> new quilt queue after I abondoned git for rt.
>
> So creating split queues is going to be a very interesting and tedious
> detective work.

Just stumbled upon this older discussion now by happenstance.

I can say with experience that it is exactly that:  tedious.

2.6.33 split queue:

http://www.spinics.net/lists/linux-rt-users/msg06310.html

2.6.34 split queue:

http://permalink.gmane.org/gmane.linux.kernel/1109036

The repo I referenced in the above doesn't seem to exist anymore
on kernel.org - although I don't explicitly recall deleting it.  Maybe
that was fallout from when kernel.org got hacked?

But I am guessing I probably still have a local copy somewhere that
could be used to repopulate if anyone really cared about that old stuff.

I don't recall if I implicitly made a 2.6.31 series in the march forward to
the 2.6.33 but since 31 didn't have merges (aside from stable stuff)
that series would probably be reasonably easy to construct.

Paul.
--

>
> Thanks,
>
>         tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
