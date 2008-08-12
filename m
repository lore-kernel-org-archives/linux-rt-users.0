From: Kushal Koolwal <kushalkoolwal@hotmail.com>
Subject: LPPTEST-worst-case latency
Date: Tue, 12 Aug 2008 12:03:47 -0700
Message-ID: <BAY107-W19C0C68D44AC0224120E89BA700@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bay0-omc1-s26.bay0.hotmail.com ([65.54.246.98]:36630 "EHLO
	bay0-omc1-s26.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751791AbYHLTDs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Aug 2008 15:03:48 -0400
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
Get Windows Live and get whatever you need, wherever you are.  Start here.
http://www.windowslive.com/default.html?ocid=TXT_TAGLM_WL_Home_082008