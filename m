From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: arm and ppc plattforms
Date: Fri, 20 Apr 2007 18:40:52 +0200
Message-ID: <20070420164052.GV9554@pengutronix.de>
References: <1177066595.5648.33.camel@localhost.localdomain> <20070420110819.GN9554@pengutronix.de> <20070420160106.GA21151@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Peter Feuerer <peter@piie.net>, linux-rt-users@vger.kernel.org,
	Darren Hart <dvhltc@us.ibm.com>
To: Theodore Tso <tytso@mit.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:60842 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2993269AbXDTQin (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Apr 2007 12:38:43 -0400
Content-Disposition: inline
In-Reply-To: <20070420160106.GA21151@thunk.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Ted,

[added Darren to Cc, as he is working on rt tests]

On Fri, Apr 20, 2007 at 12:01:06PM -0400, Theodore Tso wrote:
> You mind if I add these to along with your name/conctact to:
> 
> http://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch#Platforms_Tested_and_in_Use_with_CONFIG_PREEMPT_RT
> 
> ... or maybe you could add these platforms yourself?  
> 
> I think it would be useful if we had a collated set of tested
> platforms on the real-time wiki. I'm sure Peter isn't the only one who
> might be interested in this kind of information!
 
Yep, good idea. Nevertheless, I'd like to see a "standardized"
measurement process plus nice latency plots, like this one:

http://www.pengutronix.de/oselas/realtime/results/20070211-1/phyCORE-MPC5200B-tiny-20070211-1.png

to have a good comparism base. These plots are basically be done without
a sane realtime workload (well, some while true; do find /; done loops,
plus ping -f, but that can probably be done better). 

Any idea for a good realtime workload scenario which is valid to all
supported platforms?

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
