From: Kushal Koolwal <kushalkoolwal@hotmail.com>
Subject: LPPTEST-worst-case latency
Date: Mon, 11 Aug 2008 11:18:19 -0700
Message-ID: <BAY107-W4327615787F6FE602CBAD9BA710@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bay0-omc1-s25.bay0.hotmail.com ([65.54.246.97]:31210 "EHLO
	bay0-omc1-s25.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754260AbYHKSSU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Aug 2008 14:18:20 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi,

I am trying to do some preliminary benchmarking on a rt-kernel (2.6.26) versus a vanilla-kernel (2.6.26).

Under CONFIG_LPPTEST in 2.6.26-rt1 patch it says:

"Latency of response: 12.2 usecs (121265 cycles)

then generate various workloads on the target system to see how
(worst-case-) latencies are impacted."

I am wondering if there is a more formal definition of "worst-case"? Does a 'make -j8' and a constant "ping" like the following:

#make -j8 &
#ping -l 100000 -q -s 10 -f localhost &

would fall under the definition of "worst-case"? 

Or perhaps "hackbench 100" is a more likely candidate to generate worst-case latency?

Thanks.

Kushal Koolwal

_________________________________________________________________
Reveal your inner athlete and share it with friends on Windows Live.
http://revealyourinnerathlete.windowslive.com?locale=en-us&ocid=TXT_TAGLM_WLYIA_whichathlete_us