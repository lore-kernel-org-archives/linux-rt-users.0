From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: 2.6.19 rc6 rt3 on embedded ARM system
Date: Sun, 19 Nov 2006 22:31:35 +0100
Message-ID: <20061119213135.GR18636@pengutronix.de>
References: <45609603.3000106@gmail.com> <20061119181539.GQ18636@pengutronix.de> <4560B006.2070305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:7873 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S933359AbWKSVbi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Nov 2006 16:31:38 -0500
To: Dirk Behme <dirk.behme@googlemail.com>
Content-Disposition: inline
In-Reply-To: <4560B006.2070305@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, Nov 19, 2006 at 08:27:02PM +0100, Dirk Behme wrote:
> >I use a gcc 4.1.0 toolchain built with crosstool with glibc-2.3.2:
> >I assume glibc-2.3.2 is too old.
> 
> Yeah, thanks. A toolchain with glibc 2.3.6 seem to make the 
> job. Maybe this is worth a hint in wiki?

We could add a section to the HOWTO, so the question is which are the
toolchain versions we minimally need? It's probably architecture
dependend as well.

Any knowldgable folks around who might have an idea?

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

