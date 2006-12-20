From: Theodore Tso <tytso@mit.edu>
Subject: Re: [patch 0/4] ARM: OMAP: Add clocksource and clockevent driver for OMAP
Date: Wed, 20 Dec 2006 10:55:07 -0500
Message-ID: <20061220155507.GB1710@thunk.org>
References: <4588FFC7.5060203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de,
	David Brownell <david-b@pacbell.net>,
	Daniel Walker <dwalker@mvista.com>,
	Kevin Hilman <khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:36132 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965128AbWLTPzU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Dec 2006 10:55:20 -0500
To: Dirk Behme <dirk.behme@googlemail.com>
Content-Disposition: inline
In-Reply-To: <4588FFC7.5060203@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Dec 20, 2006 at 10:17:59AM +0100, Dirk Behme wrote:
> 
> the following patches add clocksource and clockevent driver
> for ARM based TI OMAP devices.
> 
> They are against linux-2.6.19 + patch-2.6.20-rc1 +
> patch-2.6.20-rc1-rt0. The clocksource patch went through
> several review cycles on OMAP list.

Hi Dirk,

	As a suggestion, could you consider sending patches to
linux-kernel@vger.kernel.org?  One of the reasons why we (in
consultation with folks like Ingo and tglx) deliberatly didn't create
a RT development list was that in order to promote getting -rt related
patches into mainline as soon as possible, we wanted to keep patch and
development discussion on LKML.  For example, it's not clear that the
ARM maintainer subscribes to linux-rt-users; furthermore the more
patch discussion happens on LKML, it helps promote willingness of
other kernel developers that CONFIG_PREEMPT_RT isn't going to go away,
and will probably (hopefully!) be merged into mainline someday soon.

	Regards,

						- Ted
