From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: Cyclictest expected results
Date: Sun, 7 Oct 2007 18:20:29 +0530
Message-ID: <1985e0f60710070550w47b1ccd7na897920cbd0aeb40@mail.gmail.com>
References: <1985e0f60709300837l1b16deedgb15575bc73a729ad@mail.gmail.com>
	 <20070930183253.GW23573@pengutronix.de>
	 <alpine.LFD.0.9999.0709302353540.5677@localhost.localdomain>
	 <1985e0f60709302030q62d19dd3q398a5d0685353786@mail.gmail.com>
	 <20071002065451.GM23573@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: "Robert Schwebel" <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:25122 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbXJGMu3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Oct 2007 08:50:29 -0400
Received: by rv-out-0910.google.com with SMTP id k20so502693rvb
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Oct 2007 05:50:29 -0700 (PDT)
In-Reply-To: <20071002065451.GM23573@pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear Robert,

I am sorry for delay.

By enabling ACPI on my PC I get acpi_pm

I am also getting :
root@rd cycletest]# ./cyclictest -t 1 -p80 -n -i 10000 -l 10000 -q
T: 0 ( 2709) P:80 I:10000 C:  10000 Min:      8 Act:   16 Avg:   16 Max:      44
[root@rd cycletest]# ./cyclictest -t 1 -p80 -i 10000 -l 10000 -q
T: 0 ( 2723) P:80 I:10000 C:  10000 Min:     21 Act:   30 Avg:   29 Max:     139
[root@rd cycletest]#

These numbers are quite impressive as compared to old numbers.

Thanks for your help.

I am quite strange why I start getting RT performance with ACPI. why I
need ACPI on my PC, I dont even use ACPI on my Laptop.

But I am not able to see performance difference in my GNOME
Environment. It is still very very slow, how can I boost X-Windows by
-rt patch.

Thank you,

Jaswinder Singh.

On 10/2/07, Robert Schwebel <r.schwebel@pengutronix.de> wrote:
> On Mon, Oct 01, 2007 at 09:00:42AM +0530, Jaswinder Singh wrote:
> > /sys/devices/system/clocksource/clocksource0/available_clocksource :
> > tsc pit jiffies
>
> Can you try to enable ACPI on the box and check if you get an acpi_pm?
>
> Robert
> --
> Pengutronix - Linux Solutions for Science and Industry
> Entwicklungszentrum Nord     http://www.pengutronix.de
>
