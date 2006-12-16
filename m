From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 00/10] ARM patch series for -rt15
Date: Sat, 16 Dec 2006 09:24:54 +0100
Message-ID: <20061216082454.GA23274@elte.hu>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:44685 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030758AbWLPI06 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Dec 2006 03:26:58 -0500
To: Robert Schwebel <r.schwebel@pengutronix.de>
Content-Disposition: inline
In-Reply-To: <20061215223658.009035000@metis.extern.pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Robert Schwebel <r.schwebel@pengutronix.de> wrote:

> Thomas,
> 
> this is our current series to make -rt work on ARM, currently based on 
> 2.6.19-rt15. The clockevent patches are already merged in 2.6.20-rc1 
> via Russell, so they are provided here only for completeness. I'm 
> going to update the latency plots recently posted on the OSADL list 
> when I'm back in the office on monday, to check if the longer 
> latencies on i.MX are still there.

FYI, i've added your queue to -rt, it should show up in -rt16. (The only 
minor complication was that some of the patches in the patch-queue were 
-p0, some were -p1 formatted. In general we prefer -p1 patches.)

	Ingo
