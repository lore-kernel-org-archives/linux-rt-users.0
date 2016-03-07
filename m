From: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Subject: Re: Old split quilt queues
Date: Mon, 7 Mar 2016 12:15:55 +0100
Message-ID: <56DD62EB.4000101@ramses-pyramidenbau.de>
References: <569D6AE1.2090301@ramses-pyramidenbau.de>
 <alpine.DEB.2.11.1601202151200.3575@nanos>
 <56AA25D6.3070701@ramses-pyramidenbau.de>
 <alpine.DEB.2.11.1601291210330.3886@nanos>
 <56ABAE2A.2030902@ramses-pyramidenbau.de>
 <alpine.DEB.2.11.1601292053330.3886@nanos>
 <CAP=VYLo5HxhWhxzSNoFki4Wb7maSOduWnNHMpzZja3Hdu7=k5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ramses-pyramidenbau.de ([37.120.178.10]:52776 "EHLO
	mail.ramses-pyramidenbau.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751000AbcCGLVs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2016 06:21:48 -0500
In-Reply-To: <CAP=VYLo5HxhWhxzSNoFki4Wb7maSOduWnNHMpzZja3Hdu7=k5g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Paul,

On 03/07/16 04:42, Paul Gortmaker wrote:
> On Fri, Jan 29, 2016 at 2:56 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Fri, 29 Jan 2016, Ralf Ramsauer wrote:
>>> As I expected, inside that repo are a lot of tags for the various -rt
>>> versions.
>>> First I thought, RT would make use of rebasing, like:
>>>   - Rebase onto the next kernel version and drop unnecessary commits
>>> (e.g. patches that went upstream)
>>>   - Do some additional changes
>>>   - Export vA.B.C...vA.B.C-rtX as split quilt queue
>>>
>>> But afaict, (at least on the old rt-history), you made a lot of merges
>>> from rt/* branches and added tags describing the -rt version. Then you
>>> went on merging against master in order to keep up with upstream.
>>>
>>> Given that, how do you create a split quilt queue, that applies against
>>> an upstream tag?
>>>
>>> For example, let's take the first RT Tag of rt-history: v2.6.31-rc6-rt2
>>> How would you create a split quilt queue, that applies against v2.6.31-rc6?
>>>
>>> (I need to extract all those split quilt queues RT version<->base
>>> upstream version)
>> As I said before: That was an experiment whether git is usable as a tool to
>> manage something complex as rt. It turned out, that it's not. I recreated a
>> new quilt queue after I abondoned git for rt.
>>
>> So creating split queues is going to be a very interesting and tedious
>> detective work.
> Just stumbled upon this older discussion now by happenstance.
>
> I can say with experience that it is exactly that:  tedious.
I bet!
>
> 2.6.33 split queue:
>
> http://www.spinics.net/lists/linux-rt-users/msg06310.html
>
> 2.6.34 split queue:
>
> http://permalink.gmane.org/gmane.linux.kernel/1109036
Oh my god, that must have been some agonizing days back in 2011 :-)

I tried the same, but eventually stopped linearizing the patch stack
after a few hours as there was no real chance of fast success...
>
> The repo I referenced in the above doesn't seem to exist anymore
> on kernel.org - although I don't explicitly recall deleting it.  Maybe
> that was fallout from when kernel.org got hacked?
>
> But I am guessing I probably still have a local copy somewhere that
> could be used to repopulate if anyone really cared about that old stuff.
If you still have access to those old versions, I'd appreciate if you
would let me know, anything helps!

Just out of curiosity: Do you still remember how long it took you to
linearize those stacks? As I already mentioned, I gave up after a few
hours .-)

Cheers
  Ralf
>
> I don't recall if I implicitly made a 2.6.31 series in the march forward to
> the 2.6.33 but since 31 didn't have merges (aside from stable stuff)
> that series would probably be reasonably easy to construct.
>
> Paul.
> --
>
>> Thanks,
>>
>>         tglx
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ralf Ramsauer
PGP: 0x8F10049B


