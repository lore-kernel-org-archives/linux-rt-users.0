From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] v4.4.3-rt9
Date: Mon, 29 Feb 2016 21:11:19 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602292107310.3638@nanos>
References: <alpine.DEB.2.11.1602291212180.3638@nanos> <20160229145414.11ad3043@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42475 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbcB2UMl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Feb 2016 15:12:41 -0500
In-Reply-To: <20160229145414.11ad3043@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 29 Feb 2016, Steven Rostedt wrote:
> On Mon, 29 Feb 2016 13:46:50 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > You can get this release via the git tree at:
> > 
> >     git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.4.3-rt9
> > 
> 
> There is no v4.4.3-rt9 tag. There's v4.4.3-rt9-patches and
> v4.4.3-rt9-rebase, but v4.4.3-rt9 is missing.

Hmm, pushed with --follow-tags but this time it needed a manual tag
push. Weird.

Thanks,

	tglx
