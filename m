From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: High latencies with linux-2.6.25.4-rt6 on MPC5200
Date: Sun, 29 Jun 2008 22:31:57 +0200
Message-ID: <4867F13D.9050405@grandegger.com>
References: <4858C229.2060509@grandegger.com> <20080619131406.GK5724@pengutronix.de> <485A675A.9070509@grandegger.com> <20080627143213.GG5666@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Wolfgang Grandegger <wg@grandegger.com>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52278 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbYF2Ubb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 29 Jun 2008 16:31:31 -0400
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

Interesting, I'm able to trigger latencies up to 600 us with the command

   "# while ls; do ls /bin; done"

in a telnet session, but it takes a while.

> Again everything looks just fine to me. Depending on which debugging Option are
> turned on my max. results pended between 70 and 350 us. However I could not
> produce any peak worst case values, which are so far away from the average like
> in your case.

Could you send me your .config file? And what version of cyclictest are 
you using?

> Have you tried the new -rt patch on your board? Still any strange results?

I will give it a try next week.

Wolfgang.

