From: John Kacur <jkacur@redhat.com>
Subject: Re: [RFC 0/4] cyclictest: improve running under trace-cmd
Date: Wed, 24 Feb 2016 18:08:58 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1602241802300.13215@riemann>
References: <1456256633-17639-1-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36332 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457AbcBXRJB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2016 12:09:01 -0500
Received: by mail-wm0-f45.google.com with SMTP id g62so281970174wme.1
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Feb 2016 09:09:00 -0800 (PST)
In-Reply-To: <1456256633-17639-1-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 23 Feb 2016, Luiz Capitulino wrote:

> 
> In short, this series allows you to run cyclictest under
> trace-cmd and still get trace marks when the latency
> specified with -b is execeded. More details in patch 4/4.
> 
> This series is RFC because I'm not completely sure this
> is the right thing to do. I'm wondering if we shouldn't
> ditch all tracing support from cyclictest...
> 
> Luiz Capitulino (4):
>   cyclictest: tracing(): check for notrace
>   cyclictest: move debugfs init code to its own function
>   cyclictest: move tracemark_fd handling to its own function
>   cyclictest: add --tracemark option
> 
>  src/cyclictest/cyclictest.c | 62 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 15 deletions(-)
> 
> -- 

Hi. First of all, although I didn't look closely at the details yet, I 
like this set of patches. Just to let you and everyone else know where we 
are, Clark and I are going to put rt-tests into maintainence mode very 
shortly. We want to create a 1.0 version of it, which we will maintain 
with fixes, but no new features. This last set of patches would be a nice 
addition before we go into mainatinence mode so that the old code base 
would have a way of using trace-cmd.

For the next development line of rt-tests, we would like to rip-out all of 
the tracing code that we can, and leave the bare minimum in place to 
interact with trace-cmd. With that in mind, could you go over your RFC 
patches, and if you are satisfied that they don't break anything, but 
allow tracing under trace-cmd, then this could be the last new feature we 
let in. Let me know and I'll review at that point. I'll make and official 
announcement about maintainence mode and a new development line in a 
separate mail as well.

Thank You!

John Kacur
