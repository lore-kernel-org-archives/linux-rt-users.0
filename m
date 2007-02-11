From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Status of -rt for linux-2.6.20/arch/powerpc
Date: Sun, 11 Feb 2007 16:59:30 +0100
Message-ID: <20070211155929.GQ29553@pengutronix.de>
References: <45CEF997.3020101@grandegger.com> <20070211112933.GN29553@pengutronix.de> <45CF0E90.2080806@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:52562 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750709AbXBKP7c (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Feb 2007 10:59:32 -0500
Content-Disposition: inline
In-Reply-To: <45CF0E90.2080806@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, Feb 11, 2007 at 01:39:44PM +0100, Wolfgang Grandegger wrote:
> > We have 2.6.20-rt3 running on the phyCORE-MPC5200B, so that one should
> > work and the merge problems did probably come in later (don't have the
> > time to look right now because of the Embedded World activities for next
> > week).
> 
> As I see it, 2.6.20-rt3 has the same issues (have now attached the 
> missing make output). I fixed them manually and are now able to boot and 
> run the 2.6.20-rt5 on my Icecube board. Nevertheless, cyclictest returns 
> high values of around 8000-10000 (8-10ms). The fact that the unknown 
> field 'is_continuous' in arch/powerpc/kernel/time.c is still present 
> gives me the impression, that the code in there is not up-to-date. See 
> you next week on the Embedded World.

I have uploaded the latest results to this place:

http://www.pengutronix.de/oselas/realtime/results/20070211-1/phyCORE-MPC5200B-tiny-20070211-1.png

Note that this is still no waterproof measurement, with 100k data
points and only ad-hoc stressing. We'll do more testing after the
tradeshow.

The 2.6.20-rt3 is a little bit patched, but I don't have the time right
now to dig into the details. We can discuss it on the Embedded World
next week, I'll take the patch stack with me.

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
