From: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Subject: Re: jitter bursts
Date: Fri, 31 Aug 2007 17:58:17 +0200
Message-ID: <46D83A99.3080707@l1nuxh4ck3r.de>
References: <20070831151727.GT23573@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	kiszka@rts.uni-hannover.de
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cg-p07-fb.rzone.de ([81.169.146.215]:43331 "EHLO
	cg-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758148AbXHaPyf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 Aug 2007 11:54:35 -0400
Received: from mo-p00-ob.rzone.de (klopstock-mo-p00-ob.mail [192.168.63.66])
	by charnel-fb-02.store (RZmta 12.3) with ESMTP id r06ec4j7VF3Evo
	for <linux-rt-users@vger.kernel.org>;
	Fri, 31 Aug 2007 17:54:34 +0200 (MEST)
In-Reply-To: <20070831151727.GT23573@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Hi Robert!

I guess these latencies didn't show up at the system
you are porting from?
Is the HW setup from the system you are porting from
the same as you are using with -rt?
Are both, sender and receiver are using -rt?
What happens if you are using the old system
as sender and -rt for the receiver?
What happens if you are using -rt as sender and
-rt as receiver?
Are you using an onboard nvidia SATA controller?

regards

Bernhard
