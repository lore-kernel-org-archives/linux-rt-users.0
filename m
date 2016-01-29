From: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Subject: Re: Old split quilt queues
Date: Fri, 29 Jan 2016 19:23:38 +0100
Message-ID: <56ABAE2A.2030902@ramses-pyramidenbau.de>
References: <569D6AE1.2090301@ramses-pyramidenbau.de>
 <alpine.DEB.2.11.1601202151200.3575@nanos>
 <56AA25D6.3070701@ramses-pyramidenbau.de>
 <alpine.DEB.2.11.1601291210330.3886@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ramses-pyramidenbau.de ([37.120.178.10]:55444 "EHLO
	mail.ramses-pyramidenbau.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756755AbcA2SXk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jan 2016 13:23:40 -0500
In-Reply-To: <alpine.DEB.2.11.1601291210330.3886@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

just out of curiosity:

As I expected, inside that repo are a lot of tags for the various -rt
versions.
First I thought, RT would make use of rebasing, like:
  - Rebase onto the next kernel version and drop unnecessary commits
(e.g. patches that went upstream)
  - Do some additional changes
  - Export vA.B.C...vA.B.C-rtX as split quilt queue

But afaict, (at least on the old rt-history), you made a lot of merges
from rt/* branches and added tags describing the -rt version. Then you
went on merging against master in order to keep up with upstream.

Given that, how do you create a split quilt queue, that applies against
an upstream tag?

For example, let's take the first RT Tag of rt-history: v2.6.31-rc6-rt2
How would you create a split quilt queue, that applies against v2.6.31-rc6?

(I need to extract all those split quilt queues RT version<->base
upstream version)

Thank you
  Ralf

On 01/29/16 12:12, Thomas Gleixner wrote:
> On Thu, 28 Jan 2016, Ralf Ramsauer wrote:
>> On 01/20/16 21:59, Thomas Gleixner wrote:
>>> from git.kernel.org AFAICT, but I should have an archive somewhere. Poke me
>>> again in a week if I forget to search for it.
>> Poke :-)
> Ouch :)
>
>> Did you find some old archive?
> Yes. Just forgot to push it out to k.org. Here you go:
>
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/rt-history.git
>
> It has two branches: linux-2.6.31.y-rt and linux-2.6.33.y-rt
>
> Have fun!
>
> Thanks,
>
> 	tglx
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ralf Ramsauer
GPG: 0x8F10049B


