From: Clark Williams <williams@redhat.com>
Subject: Re: 2.6.23-rc9-rt1
Date: Wed, 03 Oct 2007 08:46:54 -0500
Message-ID: <47039D4E.7090206@redhat.com>
References: <1191341473.5642.36.camel@localhost.localdomain> <4702EA31.4020102@redhat.com> <Pine.LNX.4.58.0710022134430.16284@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:41440 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbXJCNuC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Oct 2007 09:50:02 -0400
In-Reply-To: <Pine.LNX.4.58.0710022134430.16284@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Steven Rostedt wrote:
> 
> grmbl grmbl!!!
> 
> We are missing a match somewhere. Most likely in the suspend or resume
> code.  It's expected that if a CPU is idle with no ticks then the
> dynticks_progress_counter is even, otherwise it is odd. This check tells
> us that, in your case, this isn't the case. Which _is_ bad, and I wouldn't
> run it too long that way. It means that you can be getting false RCU grace
> period ends, which is not a good thing.
> 
> I could put a hack in that fixes the issue when detected, and still prints
> out a warning. I'll do that for now, until we find the problem area. I
> think the first warning probably had the want that corrupted us, and then
> we got flooded with warnings because we never fixed the situation.
> 
> Patch coming soon.
> 
> -- Steve
>> Ad infinitum. Not sure what you're looking for to be cleared in the enter and exit
>> functions, but it doesn't look like it's happening after a resume. Didn't seem to
>> affect the behavior of the kernel, since the network came up and I was able to
>> function normally (or as normally as I can function).
> 
> I'd reboot if I were you ;-)

Oh, I did :)

I've since suspended and resumed a couple of more times and have not seen your RCU
warnings, so it's not completely reproduceable.

Got any debugging code you want me to add, in case it pops up again?

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHA51OHyuj/+TTEp0RAn6hAJwO3JHHk+2EVjpH7XcAYu+g5CC3DQCgj1lR
4Umv2vf2iDjxHNprCXfxhvI=
=SL/V
-----END PGP SIGNATURE-----
