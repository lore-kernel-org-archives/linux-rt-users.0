From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RCU splat on boot from an idle CPU
Date: Fri, 11 Dec 2015 17:32:52 +0100
Message-ID: <20151211163252.GE6720@linutronix.de>
References: <CA+0CQ216LKjL4-PVeqW3vwZhvFLhRJ2GuTOfVsEvxtoZ=xoVgQ@mail.gmail.com>
 <alpine.DEB.2.11.1509011721510.15006@nanos>
 <20150902153823.749a9f73@gandalf.local.home>
 <CA+0CQ20mdGqWn6+rsA+Q6LWiDotXW=GUj-xmWBKcCrvHC=Z_vA@mail.gmail.com>
 <20150902230729.GZ4029@linux.vnet.ibm.com>
 <20150903165411.GA25462@philipp-debian.peloton-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Philipp Schrader <philipp@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47223 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbbLKQc5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 11:32:57 -0500
Content-Disposition: inline
In-Reply-To: <20150903165411.GA25462@philipp-debian.peloton-tech.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Philipp Schrader | 2015-09-03 09:55:46 [-0700]:

>> > Does that look reasonable?
>> > Or could this cause a problem down the road?
>> 
>> Looks good to me!
>
>Should I submit a patch for this or is this just a fix for my particular kernel
>configuration? I don't yet understand the code well enough to know the answer.

Did someone in the meantime sent a patch? It does not look so.
If this patch gets re-sent witch a changelog and gets acked by Paul/Steven I
don't see a problem why I should not include it.

>Thanks,
>Philipp

Sebastian
