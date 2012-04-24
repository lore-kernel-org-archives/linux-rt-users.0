From: John Kacur <jkacur@redhat.com>
Subject: Re: Hard real time in user space with preempt_rt patch
Date: Tue, 24 Apr 2012 13:36:09 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1204241331550.3182@tycho>
References: <CAM1yFZ_MLVNK8xPGg5Ad3suQh_AR18k6coyDqX9EurCkh9j9pg@mail.gmail.com> <4F966AFC.7070803@cfl.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anisha Kaul <born.rebel.83@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Mark Hounschell <dmarkh@cfl.rr.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52776 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab2DXLgk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Apr 2012 07:36:40 -0400
Received: by bkuw12 with SMTP id w12so349418bku.19
        for <linux-rt-users@vger.kernel.org>; Tue, 24 Apr 2012 04:36:38 -0700 (PDT)
In-Reply-To: <4F966AFC.7070803@cfl.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 24 Apr 2012, Mark Hounschell wrote:

> On 04/24/2012 01:46 AM, Anisha Kaul wrote:
> > From:
> > https://rt.wiki.kernel.org/articles/f/r/e/Frequently_Asked_Questions_7407.html
> > 
> > > Real-time only has impact on the kernel; Userspace does not notice the
> > > difference except for better real time behavior.
> > 
> > Does it mean that if we write the applications in user space, they
> > won't get the hard real time effect?
> > The threads running in the userspace won't get the hard real time effect?
> > 
> 
> You use the term "hard real time". The RT patch set does not even come close
> to providing a "hard real time" environment, and isn't even attempting to.

Wrong. It is attempting to come as close to hard real-time responses as 
possible. There is however, no mathematical guarantee that it will do so, 
that some would require of "hard real time". What exactly is meant by hard 
real time is also a bit hard to pin down. For a good easy to 
read discussion of it, 
check out http://www.linuxjournal.com/article/9361

> does however provide user land applications a much better chance for a "soft
> real time" environment. The phrase you quot above just means the patches are
> applied to the kernel and there are no patches required for user land glibc or
> your application.

That sounds right to me.
