From: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Subject: Re: Old split quilt queues
Date: Wed, 20 Jan 2016 23:18:03 +0100
Message-ID: <56A0079B.3000400@ramses-pyramidenbau.de>
References: <569D6AE1.2090301@ramses-pyramidenbau.de>
 <alpine.DEB.2.11.1601202151200.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ramses-pyramidenbau.de ([37.120.178.10]:56314 "EHLO
	mail.ramses-pyramidenbau.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934687AbcATWSJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2016 17:18:09 -0500
In-Reply-To: <alpine.DEB.2.11.1601202151200.3575@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

On 01/20/2016 09:59 PM, Thomas Gleixner wrote:
> Ralf,
>
> On Mon, 18 Jan 2016, Ralf Ramsauer wrote:
>
>> I'm looking for older RT split quilt queues, especially those for kernel
>> versions 2.6.31 and 2.6.33.
>> Apparently, these are the only two versions without split quilt queues
>> available on the FTP server.
>>
>> Does someone of you know where to get those patch stacks? Or more
>> precisely: are split quilt queues actually existing for those versions?
> I think that was the time where we actually tried to handle the rt patches in
> git and therefor did not release quilt queues. Those git branches are gone
> from git.kernel.org AFAICT, but I should have an archive somewhere. Poke me
> again in a week if I forget to search for it.
Ok, that's what I thought. A working git repo would really be helpful.
>
>> I'm looking for _all_ available split quilt queues for those versions as
>> I'm doing some analysis on the patch stacks.
> Out of curiousity. What kind of analysis are you doing?
>
> Archaeological studies? I wouldn't be suprised, given that you are in the
> pyramid building business.
Well, yes, kind of. I'm doing some archaeological research, digging deep
inside prehistoric PreemptRT and trying to figure out what we can learn
from history.

RT is a pretty huge patch stack which has been around for a couple of
years. I'm trying to find answers to questions like:
 - how did RT evolve over the years?
 - which kind of patches went upstream?
 - how long did a patch live in the RT stack before it went upstream?
 - which kind of patches tend to stay in the patch stack and will
probably not go upstream?

Therefore I'm happy for anything old that's still available out there.
Anything helps.
I will keep you informed.

Thank you
  Ralf
>
> Thanks,
>
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Ralf Ramsauer
GPG: 0x8F10049B

