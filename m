From: jordan <triplesquarednine@gmail.com>
Subject: Re: nvidia bug or RT bug?
Date: Tue, 8 May 2012 11:46:42 -0400
Message-ID: <CAOcfFMx1J05oxWaXxBMSaMiMc0SWDpD57C9OtzqXtvRrsQBORw@mail.gmail.com>
References: <CAOcfFMwkXC1Ozs3+QhKUU18JY4KDzNaxAuLq34r+PQOCipSFSg@mail.gmail.com>
	<1336490100.14207.183.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45827 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab2EHPqp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 May 2012 11:46:45 -0400
Received: by eeit10 with SMTP id t10so394515eei.19
        for <linux-rt-users@vger.kernel.org>; Tue, 08 May 2012 08:46:44 -0700 (PDT)
In-Reply-To: <1336490100.14207.183.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks for the reply, Steven. ( i didn't even think i would get that)

> It's both, but we don't care. Sorry. Seems that the nvidia driver is not
> compatible with some of the changes that -rt has done. One is that you
> can not call spinlocks after disabling preemption. If the nvidia driver
> does this, it will break.

I see. I know how to reproduce this issue, and how to completely avoid
it from affecting me, anyway - so it's not a huge deal. It's only
happened twice, in both circumstances i use using VDPAU with Adobe
flash <sarcasm>surprise, surprise!</sarcasm>, also in both
circumstances my uptime had been several days. ie: it doesn't happen
very often, at all.

I understand why you don't care about nvidia, but if it is a bug in RT
- should it not be fixed? anyways, I will report it to nvidia once i
get a chance to. it would nice if they addressed RT-related problems
in their driver being as some folks do require proper/good 3d
acceleration / real performance / Opengl 4.2 which (obviously) Nouveau
does not provide, nor is it anywhere near providing in the foreseeable
future :\ (not that this is news to anyone who has used them both).

> Bring up the bug with the nvidia rt patch maintainer. That's about all
> I'll say on this matter.

No problem. I know the author of the patch, anyway. I just wanted some
verification, rather than just making my own assumptions.

take care, and thanks again.

jordan
