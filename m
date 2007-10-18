From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
Date: Thu, 18 Oct 2007 10:51:58 +1000
Message-ID: <18198.44590.721412.314409@cargo.ozlabs.ibm.com>
References: <20070921032603.0D3EA32C887@thor>
	<4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
	<47161C38.2070305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:57065 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758570AbXJRAw0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Oct 2007 20:52:26 -0400
In-Reply-To: <47161C38.2070305@ru.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sergei Shtylyov writes:

> > Tony started from an earlier patch by John Stultz, not from your
> > patches.
> 
>     Well, that I can believe, yet the clockevents patch has traces of my
> former work, and looking at read_persisitent_time() it looks suspiciously 
> close to my version too...

There is basically only one reasonably way to do a lot of this stuff.

> > The main reason your patches were rejected were that you completely
> > broke the VDSO and the deterministic time accounting, and made no
> 
>     That's just not true!
>     They didn't broke vDSO (to be precise it was John's patch that broke it), 
> they just removed the vDSO code known to already be broken by -rt patch for 
> several months by then.  And they didn't broke determinictic accounting -- 
> they just made two things mutually exclusive.  I haven't yet seen how the 
> patches that were preferred dealt with it at all.

OK.  My requirement was that the clocksource/clockevent stuff and the
VDSO were both functional.  Your patch didn't meet that requirement.

>     Really? IMO, the harware does keep a constant interrupt rate better than 
> software.

Well, if you have actual numbers to back that up, show them to us.
I don't believe you would be able to measure any difference, and so I
prefer the simplicity of only implementing the one-shot mode.

> > Because you broke important features
> 
>     That is *not true*.
>     And nobody had interest to fix them for months (quite strange if they're 
> so important) while I had neither time nor interest to deal with them anymore 
> having written the code that *did work*, and not only for me.

Well, this is the difference between having a hack that works for you,
and having something that can go upstream into mainline.

Anyway, this discussion doesn't seem to be going anywhere.  If there
are changes you want made, or any other specific concrete action you
want anyone to do, say so.  Otherwise stop whinging.

Paul.
