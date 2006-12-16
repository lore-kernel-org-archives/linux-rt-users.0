From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [patch 00/10] ARM patch series for -rt15
Date: Sat, 16 Dec 2006 13:37:39 +0100
Message-ID: <20061216123739.GG15514@pengutronix.de>
References: <20061215223658.009035000@metis.extern.pengutronix.de> <1166269110.29505.251.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:59974 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030909AbWLPMhm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Dec 2006 07:37:42 -0500
To: Thomas Gleixner <tglx@linutronix.de>
Content-Disposition: inline
In-Reply-To: <1166269110.29505.251.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, Dec 16, 2006 at 12:38:29PM +0100, Thomas Gleixner wrote:
> How are the clock event patches merged ? Clock events are not in
> 2.6.20-rc1

mail before coffee ... I meant clocksource.

> General notes:
> 
> Please take care of 80 char width and stray whitespace in struct
> initializers.

Thx, we'll take care about these issues and repost.

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
