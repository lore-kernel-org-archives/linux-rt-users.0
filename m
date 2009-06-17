From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Setting the priority of an IRQ thread
Date: Wed, 17 Jun 2009 07:28:23 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906170724060.2800@localhost.localdomain>
References: <loom.20090615T222836-377@post.gmane.org>  <000001c9ee36$218cf3a0$a852c70a@dlh.st.com>  <loom.20090616T074347-549@post.gmane.org>  <20090616182734.GD13048@pengutronix.de>  <alpine.LFD.2.00.0906170025080.2800@localhost.localdomain>
 <49b7c2350906161812t14784817o4ce71daae9c472cc@mail.gmail.com> <Pine.LNX.4.64.0906161907010.9500@goblin.caltech.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GeunSik Lim <leemgs1@gmail.com>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-rt-users@vger.kernel.org
To: Martin Shepherd <mcs@astro.caltech.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:35592 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbZFQF2g (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jun 2009 01:28:36 -0400
In-Reply-To: <Pine.LNX.4.64.0906161907010.9500@goblin.caltech.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 16 Jun 2009, Martin Shepherd wrote:
> Note that my attempt to do this from my device-driver didn't work out,
> because it turns out that irq_to_desc() isn't exported. So my driver

For a good reaseon. The interrupt description structures are not to be
fiddled with by drivers.

Thanks,

	tglx

