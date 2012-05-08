From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: nvidia bug or RT bug?
Date: Tue, 08 May 2012 11:58:10 -0400
Message-ID: <1336492690.14207.189.camel@gandalf.stny.rr.com>
References: <CAOcfFMwkXC1Ozs3+QhKUU18JY4KDzNaxAuLq34r+PQOCipSFSg@mail.gmail.com>
	 <1336490100.14207.183.camel@gandalf.stny.rr.com>
	 <CAOcfFMx1J05oxWaXxBMSaMiMc0SWDpD57C9OtzqXtvRrsQBORw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:21210 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757013Ab2EHP6M (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 May 2012 11:58:12 -0400
In-Reply-To: <CAOcfFMx1J05oxWaXxBMSaMiMc0SWDpD57C9OtzqXtvRrsQBORw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-05-08 at 11:46 -0400, jordan wrote:

> I understand why you don't care about nvidia,

Because it's a proprietary driver and I can't see some of the code nor
can I fix it.


>  but if it is a bug in RT

It's not a bug in RT. It's a bug in how nvidia interacts with RT. When I
said it was both, I meant that it wont break in vanilla kernel, but only
breaks when nvidia is used with RT. But that's because RT changes
things, and drivers must adapt to be part of RT.

> - should it not be fixed?

There's nothing to fix.


>  anyways, I will report it to nvidia once i
> get a chance to. it would nice if they addressed RT-related problems

That's up to nvidia to decide.

> in their driver being as some folks do require proper/good 3d
> acceleration / real performance / Opengl 4.2 which (obviously) Nouveau
> does not provide, nor is it anywhere near providing in the foreseeable
> future :\ (not that this is news to anyone who has used them both).
> 
> > Bring up the bug with the nvidia rt patch maintainer. That's about all
> > I'll say on this matter.
> 
> No problem. I know the author of the patch, anyway. I just wanted some
> verification, rather than just making my own assumptions.

Thanks,

-- Steve


