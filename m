From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Wed, 30 Nov 2011 08:49:15 -0500
Message-ID: <1322660955.17003.115.camel@frodo>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>
	 <4EC384FD.1040106@tum.de> <alpine.LFD.2.02.1111161605580.4902@ionos>
	 <4ED35D9A.7090401@tum.de>
	 <CAONaPpE7Jgz0GhFUB41ZKoa8dUKOqKVFKj6jHfi3EAnPX0SRbQ@mail.gmail.com>
	 <alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>
	 <1322620613.17003.110.camel@frodo>
	 <CAONaPpEp=bBJWZ4DzAem0TE+_2q5t+G=99_jdJxVsCwXZ4Mk9g@mail.gmail.com>
	 <1322660085.17003.112.camel@frodo>
	 <CAONaPpH5QgZ4peSWACmyT-6JRsd+e3Moip9Fu4v2kuTknP40Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Schauss <schauss@tum.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:63934 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038Ab1K3NtS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 08:49:18 -0500
In-Reply-To: <CAONaPpH5QgZ4peSWACmyT-6JRsd+e3Moip9Fu4v2kuTknP40Ow@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2011-11-30 at 14:39 +0100, John Kacur wrote:

> Quoting myself "Could you try the following patch to see if it gets
> rid of your lockdep
> splat? (plan to neaten it up and send it to lkml if it works for you.)"
> 
> I never requested this go into -rt directly.


Heh, OK, but it looks like there's already a fix to it going to
mainline, as Peter pointed out.

-- Steve


