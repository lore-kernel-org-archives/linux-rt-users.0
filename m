From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 09:27:43 -0700
Message-ID: <1284568063.1026.8.camel@sven.oceanvoyage.org>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>
	 <201009141317.13439@zigzag.lvk.cs.msu.su>
	 <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com>
	 <20100914094411.GB10841@pengutronix.de>	<4C8F8500.5070002@theptrgroup.com>
	 <AANLkTimq7RGABRJk=2YQasav_Xd8zC-Qzf63tJRCY12J@mail.gmail.com>
	 <4C90C093.4070607@disco.unimib.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Pradyumna Sampath <pradysam@gmail.com>,
	Jeff Angielski <jeff@theptrgroup.com>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	Raz <raziebe@gmail.com>,
	"Nikita V. Youshchenko" <yoush@cs.msu.su>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: ruocco@disco.unimib.it
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45339 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0IOQ1t (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 12:27:49 -0400
Received: by pwi3 with SMTP id 3so185025pwi.19
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2010 09:27:48 -0700 (PDT)
In-Reply-To: <4C90C093.4070607@disco.unimib.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-09-15 at 14:48 +0200, Sergio Ruocco wrote:
> Pradyumna Sampath wrote:
> > I agree. Hard, soft ... far too qualitative for a discussion like
> > this. Numbers, test cases and applications determine different
> > meanings of these words.
> 
> Right. Hard and Soft realtime discussions end up always in useless
> infinite loops. The *applications*' *requirements* are hard or soft.
> 

THANK YOU!  

The term "RTOS" historically has been a tag used by proprietary vendors
to charge exorbitant fees for their OS.

TODAY, 

with embedded shifting towards Linux, there are still a few of these
RTOS vendors, who are using variants of this "fear tactic" with their
customers:

"Linux isn't an RTOS, and it won't be reliable"

This is also key to Klaas's point that most customer's "think" they need
an RTOS. That's typically good marketing to your typical organization
where product management and marketing has been empowered to the point
where they are making software architecture decisions.

OTOH, there are plenty of valid applications for RT, don't
mis-understand. Its just that RTOS is IMO just a totally overmarketed
term to earn premium revenue.

> These requirements reflect in the OS, the CPU, the IO devices, and more
> typically a convolution of all of them, depending on what the
> application does, i.e., the actual sequence of computations, OS
> syscalls, IO operations and so on...
> 

And the aggregate latencies either QUALIFY or DISQUALIFY the OS, based
on some degree of qualification. That qual should be extremely rigorous
for "hard RT" and may be less so for "soft RT".

The notion that you can just buy a hard RTOS, that makes guarantees, and
be done with things, is a fantasy.

In the end you will be doing a lot of work on your RTOS (drivers), and
you can screw things up badly.

Or you can qualify Linux. If Linux is good, then you are done,
otherwise, pay for an RTOS or send patches.

Its that simple.

Sven



