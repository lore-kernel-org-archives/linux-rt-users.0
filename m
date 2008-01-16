From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rc7-rt3
Date: Wed, 16 Jan 2008 14:55:14 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801161453100.15850@gandalf.stny.rr.com>
References: <1200456773.318.14.camel@localhost.localdomain>
 <5bdc1c8b0801161144x62aa3f9bj868602db94b42570@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mark Knecht <markknecht@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:34419 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbYAPTza (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2008 14:55:30 -0500
In-Reply-To: <5bdc1c8b0801161144x62aa3f9bj868602db94b42570@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 16 Jan 2008, Mark Knecht wrote:
>
> Jan 16 11:12:55 lightning sshd[5915]: Server listening on :: port 22.
> Jan 16 11:12:55 lightning sshd[5915]: error: Bind to port 22 on
> 0.0.0.0 failed: Address already in use.
>
> Will continue testing as I get time.

Thanks,

Are you sure you don't see this when booting the vanilla kernel. Also, if
you do try a vanilla kernel, don't use the distro version. Use what ever
version of the -rt patch you used. ie. for 2.6.23-rt1 try out 2.6.23 with
the same config (with necessary updates).

-- Steve
