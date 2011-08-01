From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/3] update to cpupri algorithm
Date: Mon, 01 Aug 2011 14:54:31 -0400
Message-ID: <1312224871.18583.72.camel@gandalf.stny.rr.com>
References: <20110729151340.419467771@goodmis.org>
	 <1312017596.8752.78.camel@marge.simson.net>
	 <1312208313.18583.28.camel@gandalf.stny.rr.com>
	 <1312224095.8151.78.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <mgalbraith@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:57633 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1HASyd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Aug 2011 14:54:33 -0400
In-Reply-To: <1312224095.8151.78.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-08-01 at 20:41 +0200, Mike Galbraith wrote:

> > Thanks for testing! I'll redo the patches to remove the logging, and
> > send them to you again. Could you return back a 'Tested-by' tag
> > afterward.
> 
> (I did the logging removal, the posted numbers were that, but..)

Could you merge the two patches and diff them against the one I posted
privately. Just to make sure that you really tested the one I plan on
giving to Mainline.

> 
> Sure.  I've been beating on them (heftily), there are there have been no
> ill effects detected.  You can have my..
> 	Tested-by: Mike Galbraith <mgalbraith@suse.de> ||
> 	Tested-by: Mike Galbraith <efault@gmx.de> (the real /me)

Heh, I'll probably take the suse.de, just because its nice to see
multiple companies on a single patch. Especially one that affects the
scheduler.

-- Steve


