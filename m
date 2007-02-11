From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Status of -rt for linux-2.6.20/arch/powerpc
Date: Sun, 11 Feb 2007 17:39:38 +0100
Message-ID: <1171211978.4904.3.camel@chaos>
References: <45CEF997.3020101@grandegger.com>
	 <20070211112933.GN29553@pengutronix.de>  <45CF0E90.2080806@grandegger.com>
	 <1171209448.3661.10.camel@chaos>  <45CF4651.506@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:49476 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750724AbXBKQjd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Feb 2007 11:39:33 -0500
In-Reply-To: <45CF4651.506@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2007-02-11 at 17:37 +0100, Wolfgang Grandegger wrote:
> > Yup, I did not come around to do the fixups. Is top on my todo list
> > though.
> 
> Apart from that, I also realized that it's not possible to enable 
> HIGH_RES_TIMERS, because GENERIC_CLOCKEVENTS is not selected or 
> available for PowerPC.

Yup, the whole bunch is missing. It got dropped at some point.

	tglx
