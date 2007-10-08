From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Cyclictest expected results
Date: Mon, 8 Oct 2007 16:06:50 +0200
Message-ID: <20071008140650.GJ23573@pengutronix.de>
References: <1985e0f60709300837l1b16deedgb15575bc73a729ad@mail.gmail.com> <20070930183253.GW23573@pengutronix.de> <alpine.LFD.0.9999.0709302353540.5677@localhost.localdomain> <1985e0f60709302030q62d19dd3q398a5d0685353786@mail.gmail.com> <20071002065451.GM23573@pengutronix.de> <1985e0f60710070550w47b1ccd7na897920cbd0aeb40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:33665 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751056AbXJHOG6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Oct 2007 10:06:58 -0400
Content-Disposition: inline
In-Reply-To: <1985e0f60710070550w47b1ccd7na897920cbd0aeb40@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, Oct 07, 2007 at 06:20:29PM +0530, Jaswinder Singh wrote:
> I am also getting :
> root@rd cycletest]# ./cyclictest -t 1 -p80 -n -i 10000 -l 10000 -q
> T: 0 ( 2709) P:80 I:10000 C:  10000 Min:      8 Act:   16 Avg:   16 Max:      44
> [root@rd cycletest]# ./cyclictest -t 1 -p80 -i 10000 -l 10000 -q
> T: 0 ( 2723) P:80 I:10000 C:  10000 Min:     21 Act:   30 Avg:   29 Max:     139
> [root@rd cycletest]#

Doesn't look too bad.

> I am quite strange why I start getting RT performance with ACPI. why I
> need ACPI on my PC, I dont even use ACPI on my Laptop.

acpi_pm provides a proper clocksource to your system which is a) sane
and b) has enough resolution.

> But I am not able to see performance difference in my GNOME
> Environment. It is still very very slow, how can I boost X-Windows by
> -rt patch.

I'm not sure what you are expecting here? Realtime is about guaranteed
latencies, not about speed.

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
