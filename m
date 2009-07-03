From: Jon Masters <jonathan@jonmasters.org>
Subject: hwlat latency readings [WAS: IRC Alert]
Date: Fri, 03 Jul 2009 13:50:44 -0400
Message-ID: <1246643444.5270.380.camel@perihelion.bos.jonmasters.org>
References: <E1MMhLr-0007zJ-D9@dallas.jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: irc-freenode <irc-freenode@jonmasters.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dallas.jonmasters.org ([72.29.103.172]:51083 "EHLO
	dallas.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545AbZGCRvT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Jul 2009 13:51:19 -0400
In-Reply-To: <E1MMhLr-0007zJ-D9@dallas.jonmasters.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-07-03 at 11:54 +0000, jbl wrote:

> [11:52:41] <jbl:#linux-rt> +jonmasters: ping
> [11:53:27] <jbl> +how long should be max latencies seen with hwlat detector?

It's a US holiday, so I'll reply by email as I'm not really around for
IRC, but I don't want to forget to add something to this - especially as
people seem to be trying to also track down new latencies in RT itself.
I don't think these are SMI related - though now you can check.

The default for the latency detector is to regard any unexplained time
interval over (greater than, not greater than or equal to) 10us as a
latency worthy of some regard. But you can also configure it down to 1us
since anything over 0us represents some kind of interruption - it's all
down to what threshold you actually care about (few people notice 1us).

Anyway. How high should it go? Theoretically, that is an open ended
question. But we have seen in practice latencies up to many milliseconds
or even higher - I don't expect you'll go over 100ms and in reality, I
don't expect it to be anything like that, maybe hundreds of us on a
modern enough system. But the range is really down to whatever crap the
BIOS is doing when it's taking your CPU cycles away, and that could
literally be anything (reformulating the coke recipe isn't unlikely).

If you're seeing something irregular, for widely long periods of time it
is less likely to be the kind of SMIs we see, which do tend to be
semi-predictable as they rely upon counters for most of the
non-asynchronous (e.g. hardware emulation) activities. But if you see
something short many times per second, or something longer on a
predictable schedule then it is quite likely to be an SMI hitting you.

Jon.

P.S. I know there's a slight bug in the wake_up handling in hwlat that
is causing some issues - I will have a fix available next week.


