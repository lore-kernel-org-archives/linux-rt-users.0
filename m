From: Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: RFC on fixing mutex spinning on owner
Date: Wed, 16 Mar 2016 16:35:30 -0700
Message-ID: <20160316233530.GA8731@kroah.com>
References: <CAD=GYpbHjcsuQSnNPL4SCv-r=Me6oiH7dJ98a64udbakWLaUjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Joel Fernandes <agnel.joel@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43896 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934515AbcCPXff (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Mar 2016 19:35:35 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id A39E820F0F
	for <linux-rt-users@vger.kernel.org>; Wed, 16 Mar 2016 19:35:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAD=GYpbHjcsuQSnNPL4SCv-r=Me6oiH7dJ98a64udbakWLaUjQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 16, 2016 at 04:22:17PM -0700, Joel Fernandes wrote:
> Hi,
> 
> On a fairly recent kernel and android userspace, I am seeing that with
> i915 driver is in a spin loop waiting for mutex owner to release it
> (mutex_spin_on_owner).

Why not provide a backtrace to the drm and i915 developers so that they
can work on this?  The mailing lists you sent this to can't do much
about this, sorry...

thanks,

greg k-h
