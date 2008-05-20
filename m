From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: 2.6.25.4-rt2 compile errors on ARM due to cmpxchg() problems.
Date: Tue, 20 May 2008 21:11:59 +0200
Message-ID: <20080520191159.GL13814@pengutronix.de>
References: <3efb10970805200721u6a837a2ap94ead54f7eb7bf89@mail.gmail.com> <Pine.LNX.4.58.0805201034130.1838@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Remy Bohmer <linux@bohmer.net>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, lvcargnini@gmail.com,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:40515 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754594AbYETTMW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 May 2008 15:12:22 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0805201034130.1838@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven,

On Tue, May 20, 2008 at 10:34:54AM -0400, Steven Rostedt wrote:
> No idea right off the bat. But I may be needing to set up a ARM
> crosscompiler. Unless Thomas would like to take a look into this.

If you need an ARM cross compiler, you can for example use ptxdist to
setup an OSELAS.Toolchain:

http://www.pengutronix.de/oselas/toolchain/index_en.html

The current well tested revisions are based on 4.1.2, but -trunk does
also contain (work-in-progress) top-of-tree versions.

rsc
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

