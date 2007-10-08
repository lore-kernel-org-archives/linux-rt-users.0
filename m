From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: Cyclictest expected results
Date: Mon, 8 Oct 2007 20:16:44 +0530
Message-ID: <1985e0f60710080746p30ecebcv6807b6f24d1b5050@mail.gmail.com>
References: <1985e0f60709300837l1b16deedgb15575bc73a729ad@mail.gmail.com>
	 <20070930183253.GW23573@pengutronix.de>
	 <alpine.LFD.0.9999.0709302353540.5677@localhost.localdomain>
	 <1985e0f60709302030q62d19dd3q398a5d0685353786@mail.gmail.com>
	 <20071002065451.GM23573@pengutronix.de>
	 <1985e0f60710070550w47b1ccd7na897920cbd0aeb40@mail.gmail.com>
	 <20071008140650.GJ23573@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: "Robert Schwebel" <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:31612 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbXJHOqq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Oct 2007 10:46:46 -0400
Received: by an-out-0708.google.com with SMTP id d31so137533and
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Oct 2007 07:46:45 -0700 (PDT)
In-Reply-To: <20071008140650.GJ23573@pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Robert,

On 10/8/07, Robert Schwebel <r.schwebel@pengutronix.de> wrote:
> On Sun, Oct 07, 2007 at 06:20:29PM +0530, Jaswinder Singh wrote:
> > I am also getting :
> > root@rd cycletest]# ./cyclictest -t 1 -p80 -n -i 10000 -l 10000 -q
> > T: 0 ( 2709) P:80 I:10000 C:  10000 Min:      8 Act:   16 Avg:   16 Max:      44
> > [root@rd cycletest]# ./cyclictest -t 1 -p80 -i 10000 -l 10000 -q
> > T: 0 ( 2723) P:80 I:10000 C:  10000 Min:     21 Act:   30 Avg:   29 Max:     139
> > [root@rd cycletest]#
>
> Doesn't look too bad.
>
> > I am quite strange why I start getting RT performance with ACPI. why I
> > need ACPI on my PC, I dont even use ACPI on my Laptop.
>
> acpi_pm provides a proper clocksource to your system which is a) sane
> and b) has enough resolution.
>
> > But I am not able to see performance difference in my GNOME
> > Environment. It is still very very slow, how can I boost X-Windows by
> > -rt patch.
>
> I'm not sure what you are expecting here? Realtime is about guaranteed
> latencies, not about speed.
>

Currently my GNOME environment takes 150 seconds to start.

May be it because of some bug :
mtrr: base(0xf0020000) is not aligned on a size(0x300000) boundary
[drm:drm_unlock] *ERROR* Process 2382 using kernel context 0

I am just curious can we improve its performance by Realtime.

Yes, you are right we cannot do anything if CPU is already running 100%.

Thank you,

Jaswinder Singh.
