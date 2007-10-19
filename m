From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
Date: Fri, 19 Oct 2007 16:11:31 +0400
Message-ID: <47189EF3.7010103@ru.mvista.com>
References: <20070921032603.0D3EA32C887@thor>	<4713A616.3090103@ru.mvista.com>	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>	<47161C38.2070305@ru.mvista.com>	<18198.44590.721412.314409@cargo.ozlabs.ibm.com>	<471777BD.8090800@ru.mvista.com> <18200.3600.459275.823335@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:53031 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752644AbXJSMLU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Oct 2007 08:11:20 -0400
In-Reply-To: <18200.3600.459275.823335@cargo.ozlabs.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Paul Mackerras wrote:
> Sergei Shtylyov writes:

>>    And now you have incomplete read_persistent_clock() implementation for 

> I don't see anything incomplete about it.  If you do, feel free to
> post a patch.

    The xtime_lock is still grabbed by time_init()

>>example, god knows why it was preferred to mine -- well, it also implemented 

> Your most recent post of your patch to implement read_persistent_clock
> was in May -- five months ago -- and you said this about it: "This

    Right, the most recent was in May but that was only a recast of the
October version (i.e. year old) -- that patch got somehow dropped from later
the -rt patches IIRC.

> patch hasn't received a good testing though".

    Right, it never has been tested on macines with RTC. That was a fair 
warning. :-)

> You don't have to be a god to figure out why I preferred a patch that
> had been tested, where the author was responding to comments and
> posting updated versions of his patch in the period leading up to the
> merge window, over that.

    Unfortunately, I didn't have time to try pusing it into every -rc1 since 
2.6.18 -- there has been experimental hrtimers patchset at that time with even 
x86 stuff being unmerged to mainline, so the stuff could only be pushed into 
that patchset last autumn. I was going to try addressing vDSO stuff, yet there 
has been too much work aside of that.  Still, I've answered the mails. :-)

>>    I just wanted the reasons clarified and got what I wanted -- as I thought, 
>>the decision behind preferring patches was somewhat biased, nobody really 
>>cared about code quality or just wasn't familiar with hrtimers enough to judge 
>>on the code quality...

> You really know how to persuade people to cooperate, don't you...  :P

    Well, I'm not persuading anybody, sine I don't believe that I can persuade 
somebody to do my work, so had to just vainly complain :-).
    However, I agree that my complaints/ comments might have been somewhat 
rash and unjust -- Tony's patches are *not* that bad after all. :-)
    The only thing I'm still unusre about is that deterministic accounting. 
Could you point me at the patch which deals with this (at least for System 390 
:-)?

> Paul.

WBR, Sergei
