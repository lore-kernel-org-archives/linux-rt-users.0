From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [patch 00/11] Autotool support for IBM RT Cases
Date: Thu, 29 Mar 2007 09:34:52 +0200
Message-ID: <20070329073452.GE32369@pengutronix.de>
References: <20070324121045.396218000@metis.extern.pengutronix.de> <460B2B35.4090108@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org, Darren Hart <dvhltc@us.ibm.com>
To: Nivedita Singhvi <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:57775 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753296AbXC2He7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Mar 2007 03:34:59 -0400
Content-Disposition: inline
In-Reply-To: <460B2B35.4090108@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Nivedita,

On Wed, Mar 28, 2007 at 07:57:57PM -0700, Nivedita Singhvi wrote:
> Thanks a lot for the patches. I believe Chirag Jog who's
> working on cleaning up some of the tests responded to you
> offline already. 

Nope, not yet...

> I thought I'd let everyone know we'll be rolling out an updated
> tarball once we have that working.

Great!

> What we'd like to do, however, is integrate these tests into the LTP
> project. I'm hoping people will still find it as convenient to use.
> Anyone foresee any issues with that move?

However that might end - I think it is important to have cross compiling
support in LTP; last time I looked it was really difficult to achieve,
because you more or less had to care about every single piece of
sourcecode.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
