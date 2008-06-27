From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Fix the processing of optional options for cyclictest
Date: Fri, 27 Jun 2008 11:59:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0806271157001.20917@gandalf.stny.rr.com>
References: <520f0cf10806270110l5b3199ablc936c38f4bcf24eb@mail.gmail.com>
 <c384c5ea0806270734p73c68871k5dec8d1ad25afaff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@gmail.com>, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:51459 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760030AbYF0P7Q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Jun 2008 11:59:16 -0400
In-Reply-To: <c384c5ea0806270734p73c68871k5dec8d1ad25afaff@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

5B

On Fri, 27 Jun 2008, Leon Woestenberg wrote:

>
> Hello,
>
> I still found it strange that the RTWiki mentions "-t NUM" as if it
> works, so the manual page of cyclictest and the wiki needs a review
> too.

It doesn't?

Then again I must have an old version of cyclictest, because both -t5 and
-t 5 work for me.

-- Steve

>
> I think I have access and will change this:
>
> http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO
>
> Figure 11. Benchmarking the Realtime Environment using Cyclictest
>
> # ./cyclictest -p 80 -t 5 -n
> 1.58 1.61 1.62 3/68 4079
>
> T: 0 ( 3131) P:80 I:    1000 C:16469865 Min:       8 Act:      13 Max: 62
> T: 1 ( 3132) P:79 I:    1500 C: 9979903 Min:       8 Act:      18 Max: 75
> T: 2 ( 3133) P:78 I:    2000 C: 7934887 Min:       9 Act:      22 Max: 83
> T: 3 ( 3134) P:77 I:    2500 C: 6587910 Min:       9 Act:      25 Max: 81
> T: 4 ( 3135) P:76 I:    3000 C: 5489925 Min:       9 Act:      27 Max: 86

