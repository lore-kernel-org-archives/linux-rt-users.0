From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Cyclictest expected results
Date: Tue, 2 Oct 2007 08:54:51 +0200
Message-ID: <20071002065451.GM23573@pengutronix.de>
References: <1985e0f60709300837l1b16deedgb15575bc73a729ad@mail.gmail.com> <20070930183253.GW23573@pengutronix.de> <alpine.LFD.0.9999.0709302353540.5677@localhost.localdomain> <1985e0f60709302030q62d19dd3q398a5d0685353786@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:41675 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750960AbXJBGy7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Oct 2007 02:54:59 -0400
Content-Disposition: inline
In-Reply-To: <1985e0f60709302030q62d19dd3q398a5d0685353786@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Oct 01, 2007 at 09:00:42AM +0530, Jaswinder Singh wrote:
> /sys/devices/system/clocksource/clocksource0/available_clocksource :
> tsc pit jiffies

Can you try to enable ACPI on the box and check if you get an acpi_pm?

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
