From: "Girish kathalagiri" <girish.sk@gmail.com>
Subject: Re: jitter bursts
Date: Wed, 5 Sep 2007 14:06:36 +0530
Message-ID: <34ac6d890709050136v2b061c76pfb149667faa82617@mail.gmail.com>
References: <20070831151727.GT23573@pengutronix.de>
	 <34ac6d890708310855v413383cm2bd725501a685842@mail.gmail.com>
	 <20070905081402.GA30955@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	"Robert Schwebel" <r.schwebel@pengutronix.de>,
	kiszka@rts.uni-hannover.de
To: "Michael Olbrich" <m.olbrich@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:52036 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942AbXIEIgi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2007 04:36:38 -0400
Received: by ug-out-1314.google.com with SMTP id z38so9231ugc
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Sep 2007 01:36:37 -0700 (PDT)
In-Reply-To: <20070905081402.GA30955@pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Unfortunately not but it did get me on the right track. The problem is
> caused by the e100_watchdog function. As far as I can tell e100_watchdog
> is called from a timer queue and therefore runs with the priority of
> that thread. And while I set higher priorities for softirq-net-rx and
> the application I missed the thread for the hardware interrupt of the
> network interface. So whenever a packet arived while e100_watchdog was
> running it got delayed. The periodic pattern is a result of this and
> speed difference of sender and receiver clocks.
> The jitter is now <50us but still with some periodic patterns. So I'll
> need to investigate further.
>
There was some discussion going on this issue on netdev ....
The below link might help you.
http://www.nabble.com/Re%3A-My-vote-against-eepro*-removal-t954330.html#a2532617

-- 
Thanks
   Giri
