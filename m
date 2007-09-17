From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Don't sleep in oops_begin()
Date: Mon, 17 Sep 2007 22:20:43 +0200
Message-ID: <200709172220.43871.ak@suse.de>
References: <200709172012.21102.ak@suse.de> <1190056047.3253.104.camel@imap.mvista.com> <1190057923.3615.26.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Daniel Walker <dwalker@mvista.com>, mingo@elte.hu,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:33220 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756952AbXIQUWR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 16:22:17 -0400
In-Reply-To: <1190057923.3615.26.camel@sven.thebigcorporation.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Monday 17 September 2007 21:38, Sven-Thorsten Dietrich wrote:
> On Mon, 2007-09-17 at 12:07 -0700, Daniel Walker wrote:
> > On Mon, 2007-09-17 at 21:00 +0200, Andi Kleen wrote:
> > > > Since it's all got "__" in the front, not good to use this method all
> > > > over .. If you just need a real spinlock best to use
> > > > DEFINE_RAW_SPINLOCK() unless your a special situation ..
>
> die_lock has been RAW for a while, see older patches...

It's definitely not in 2.6.23-rc4-rt1 and also wasn't in the oops
trace I looked at.

> but DEFINE_RAW or DECLARE_RAW should be used when possible.

I disagree for the oops case.  You want the simplest possible code
here.

-Andi
