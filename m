From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Status of -rt for linux-2.6.20/arch/powerpc
Date: Sun, 11 Feb 2007 17:39:51 +0100
Message-ID: <45CF46D7.4060703@grandegger.com>
References: <45CEF997.3020101@grandegger.com> <20070211112933.GN29553@pengutronix.de> <45CF0E90.2080806@grandegger.com> <20070211155929.GQ29553@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:59011 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbXBKQjb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Feb 2007 11:39:31 -0500
In-Reply-To: <20070211155929.GQ29553@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Robert Schwebel wrote:
> On Sun, Feb 11, 2007 at 01:39:44PM +0100, Wolfgang Grandegger wrote:
>>> We have 2.6.20-rt3 running on the phyCORE-MPC5200B, so that one should
>>> work and the merge problems did probably come in later (don't have the
>>> time to look right now because of the Embedded World activities for next
>>> week).
>> As I see it, 2.6.20-rt3 has the same issues (have now attached the 
>> missing make output). I fixed them manually and are now able to boot and 
>> run the 2.6.20-rt5 on my Icecube board. Nevertheless, cyclictest returns 
>> high values of around 8000-10000 (8-10ms). The fact that the unknown 
>> field 'is_continuous' in arch/powerpc/kernel/time.c is still present 
>> gives me the impression, that the code in there is not up-to-date. See 
>> you next week on the Embedded World.
> 
> I have uploaded the latest results to this place:
> 
> http://www.pengutronix.de/oselas/realtime/results/20070211-1/phyCORE-MPC5200B-tiny-20070211-1.png
> 
> Note that this is still no waterproof measurement, with 100k data
> points and only ad-hoc stressing. We'll do more testing after the
> tradeshow.
 >
> The 2.6.20-rt3 is a little bit patched, but I don't have the time right
> now to dig into the details. We can discuss it on the Embedded World
> next week, I'll take the patch stack with me.

OK, great, thanks.

See you next week.

Wolfgang.
