From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: Cyclictest expected results
Date: Mon, 8 Oct 2007 20:39:38 +0530
Message-ID: <1985e0f60710080809k5f0e029ah27750ee01c87dee6@mail.gmail.com>
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
Received: from nz-out-0506.google.com ([64.233.162.224]:46685 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbXJHPJj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Oct 2007 11:09:39 -0400
Received: by nz-out-0506.google.com with SMTP id s18so670478nze
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Oct 2007 08:09:38 -0700 (PDT)
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

139 microseconds interrupt latency looks not too bad for Genral purpose OS.

But this is still bad in Realtime point of view.

Thank you,

Jaswinder Singh.
