From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rc7-rt1
Date: Mon, 14 Jan 2008 16:27:09 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801141625260.1590@gandalf.stny.rr.com>
References: <1200250801.9190.7.camel@localhost.localdomain>
 <20080113202522.GD27137@pengutronix.de> <Pine.LNX.4.58.0801131544430.10093@gandalf.stny.rr.com>
 <20080114200836.GR27137@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:61812 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbYANV1W (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jan 2008 16:27:22 -0500
In-Reply-To: <20080114200836.GR27137@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Mon, 14 Jan 2008, Robert Schwebel wrote:

>
> It compiles now, although I still don't get any kernel output any more
> if I enable CONFIG_FUNCTION_TRACE. Sorry for not being more verbose, I'm
> out of office right now and my arms are not long enough to connect the
> BDI ;)
>

I have a strange anomaly going on with my box. It seems to get stuck, but
if I keep hitting the keyboard (serial console), it continues. Seems that
a timer is stuck.

-- Steve
