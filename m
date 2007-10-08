From: Theodore Tso <tytso@mit.edu>
Subject: Re: Cyclictest expected results
Date: Mon, 8 Oct 2007 10:55:09 -0400
Message-ID: <20071008145508.GA29081@thunk.org>
References: <1985e0f60709300837l1b16deedgb15575bc73a729ad@mail.gmail.com> <20070930183253.GW23573@pengutronix.de> <alpine.LFD.0.9999.0709302353540.5677@localhost.localdomain> <1985e0f60709302030q62d19dd3q398a5d0685353786@mail.gmail.com> <20071002065451.GM23573@pengutronix.de> <1985e0f60710070550w47b1ccd7na897920cbd0aeb40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from THUNK.ORG ([69.25.196.29]:47340 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbXJHOzT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Oct 2007 10:55:19 -0400
Content-Disposition: inline
In-Reply-To: <1985e0f60710070550w47b1ccd7na897920cbd0aeb40@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, Oct 07, 2007 at 06:20:29PM +0530, Jaswinder Singh wrote:
> 
> But I am not able to see performance difference in my GNOME
> Environment. It is still very very slow, how can I boost X-Windows by
> -rt patch.

There are many reasons why GNOME performance might be slow.  Stupid
application design going to helped by some magic kernel patch.  Keep
in mind the GNOME doesn't run with real-time priority levels; neither
does the X server.  

The -rt patch isn't magic; no RTOS is magic.  A large amount of
application design and reworking in order to properly utilize the
POSIX real-time interfaces.

						- Ted
