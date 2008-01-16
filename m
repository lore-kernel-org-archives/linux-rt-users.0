From: "Mark Knecht" <markknecht@gmail.com>
Subject: Re: 2.6.24-rc7-rt3
Date: Wed, 16 Jan 2008 12:10:06 -0800
Message-ID: <5bdc1c8b0801161210t63071f40n9521f5530590d309@mail.gmail.com>
References: <1200456773.318.14.camel@localhost.localdomain>
	 <5bdc1c8b0801161144x62aa3f9bj868602db94b42570@mail.gmail.com>
	 <Pine.LNX.4.58.0801161453100.15850@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.243]:21273 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751259AbYAPUKI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2008 15:10:08 -0500
Received: by hs-out-2122.google.com with SMTP id 54so212106hsz.5
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Jan 2008 12:10:07 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0801161453100.15850@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Jan 16, 2008 11:55 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 16 Jan 2008, Mark Knecht wrote:
> >
> > Jan 16 11:12:55 lightning sshd[5915]: Server listening on :: port 22.
> > Jan 16 11:12:55 lightning sshd[5915]: error: Bind to port 22 on
> > 0.0.0.0 failed: Address already in use.
> >
> > Will continue testing as I get time.
>
> Thanks,
>
> Are you sure you don't see this when booting the vanilla kernel. Also, if
> you do try a vanilla kernel, don't use the distro version. Use what ever
> version of the -rt patch you used. ie. for 2.6.23-rt1 try out 2.6.23 with
> the same config (with necessary updates).
>
> -- Steve

Steve,
   I'll give it a try. I am pretty sure it's a distro specific issue
so I'm going to check with them about how to properly configure sshd.
It's likely jsut some oversight in one of my config files. Being a
Gentoo user we have more things like this that we have to look after.
Probably some update clobbered something and I just noticed it
recently.

   If I get a quick minute I'll build the 2.6.23 and take a look at that also.

Thanks,
Mark
