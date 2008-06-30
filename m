From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: High latencies with linux-2.6.25.4-rt6 on MPC5200
Date: Mon, 30 Jun 2008 19:34:57 +0200
Message-ID: <48691941.5040100@grandegger.com>
References: <4858C229.2060509@grandegger.com> <20080619131406.GK5724@pengutronix.de> <485A675A.9070509@grandegger.com> <20080627143213.GG5666@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Wolfgang Grandegger <wg@grandegger.com>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52865 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbYF3Rea (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jun 2008 13:34:30 -0400
In-Reply-To: <20080627143213.GG5666@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Fu,

Luotao Fu wrote:
> Hi Wolfgang,
> I finally found some time and did some tests with your config file and the shiny
> new 2.6.25.8-rt7
> 
> On Thu, Jun 19, 2008 at 04:04:10PM +0200, Wolfgang Grandegger wrote:
>> Hi Fu,
>>
>> Luotao Fu wrote:
>> Keep in mind that I'm running Linux on a rootfs mounted via NFS.
> 
> I have exactly the same test configuration here.
> 
> Again everything looks just fine to me. Depending on which debugging Option are
> turned on my max. results pended between 70 and 350 us. However I could not
> produce any peak worst case values, which are so far away from the average like
> in your case.

The .config you send me correspond to what latency (debugging options 
turned on).

> Have you tried the new -rt patch on your board? Still any strange results?

I just re-tested 2.6.25.8-rt7 with a .config as close as possible to 
yours. Still, the latency measured with "cyclictest -p 98 -n -t1 -i1000" 
  goes up to 600us within a few minutes. I also re-measured latencies 
with older kernel version:

   RT kernel      Max. latency
   2.6.25.8-rt7     605 us
   2.6.24.7-rt13    230 us
   2.6.24.4-rt4     130 us

I will now try to narrow down the latency evils.

Wolfgang.
