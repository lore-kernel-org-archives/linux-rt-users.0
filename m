From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Preempt-RT patch for 2.6.25
Date: Mon, 5 May 2008 12:21:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805051220590.25250@gandalf.stny.rr.com>
References: <3efb10970805021102n4d87f55eue723786281b06fcb@mail.gmail.com>
 <1209753250.25628.34.camel@dd.thebigcorporation.com>
 <Pine.LNX.4.58.0805021441340.10615@gandalf.stny.rr.com>
 <1210004250.17132.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	Remy Bohmer <linux@bohmer.net>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jonathan@jonmasters.org>,
	Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:39357 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbYEEQVM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 May 2008 12:21:12 -0400
In-Reply-To: <1210004250.17132.12.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 5 May 2008, Daniel Walker wrote:
> You really want bisection first. The reason is that you don't want ever
> growing patches, you want smaller and smaller patches. For instance the
> rt-mutex-core.patch is way too large, you wouldn't want to fold my
> PICK_FUNCTION changes into that patch since that would just make
> rt-mutex-core larger ..
>

Yeah, I already did that ;-)

-- Steve

