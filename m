From: "John Kacur" <jkacur@gmail.com>
Subject: Re: [PATCH] Fix the processing of optional options for cyclictest
Date: Fri, 27 Jun 2008 21:22:07 +0200
Message-ID: <520f0cf10806271222g37dd75c0gafe578c6d4ef5339@mail.gmail.com>
References: <520f0cf10806270110l5b3199ablc936c38f4bcf24eb@mail.gmail.com>
	 <c384c5ea0806270734p73c68871k5dec8d1ad25afaff@mail.gmail.com>
	 <Pine.LNX.4.58.0806271157001.20917@gandalf.stny.rr.com>
	 <48651013.2070704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	"Leon Woestenberg" <leon.woestenberg@gmail.com>,
	linux-rt-users@vger.kernel.org,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Clark Williams" <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:29883 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756339AbYF0TWI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Jun 2008 15:22:08 -0400
Received: by rv-out-0506.google.com with SMTP id k40so700716rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Jun 2008 12:22:07 -0700 (PDT)
In-Reply-To: <48651013.2070704@gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jun 27, 2008 at 6:06 PM, Clark Williams
<clark.williams@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Steven Rostedt wrote:
>> 5B
>>
>> On Fri, 27 Jun 2008, Leon Woestenberg wrote:
>>
>>> Hello,
>>>
>>> I still found it strange that the RTWiki mentions "-t NUM" as if it
>>> works, so the manual page of cyclictest and the wiki needs a review
>>> too.
>>
>> It doesn't?
>>
>> Then again I must have an old version of cyclictest, because both -t5 and
>> -t 5 work for me.
>>
>> -- Steve
>>
>
> You do. The current source in Thomas's git tree exhibits this
> behavior, because of the way getopt() handles optional arguments.
>
> Clark

Right the extra-code is only necessary for the processing of optional
arguments, so without checking the history of the program, I would
assume that the NUM argument to -t was not optional in the past. Now
it is optional because -t without arguments implies threads =
max_cpus. I made some very minor edits to the wiki a little while ago
to reflect this but the Wiki page does need to updated more, I think
the usage file corresponds a lot more closely to the actual behaviour.

crap, I see I left of the signed-off-by: John Kacur <jkacur@gmail.com>
line on the patch, do I need to resubmit it?

John
