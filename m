From: Sergio Ruocco <ruocco@disco.unimib.it>
Subject: Re: preempt rt in commercial use
Date: Wed, 15 Sep 2010 14:48:19 +0200
Message-ID: <4C90C093.4070607@disco.unimib.it>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>	<201009141317.13439@zigzag.lvk.cs.msu.su>	<AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com>	<20100914094411.GB10841@pengutronix.de>	<4C8F8500.5070002@theptrgroup.com> <AANLkTimq7RGABRJk=2YQasav_Xd8zC-Qzf63tJRCY12J@mail.gmail.com>
Reply-To: ruocco@disco.unimib.it
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff Angielski <jeff@theptrgroup.com>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	Raz <raziebe@gmail.com>,
	"Nikita V. Youshchenko" <yoush@cs.msu.su>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Pradyumna Sampath <pradysam@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.disco.unimib.it ([149.132.176.35]:39402 "EHLO
	mail.disco.unimib.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab0IOMs0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Sep 2010 08:48:26 -0400
In-Reply-To: <AANLkTimq7RGABRJk=2YQasav_Xd8zC-Qzf63tJRCY12J@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Pradyumna Sampath wrote:
> I agree. Hard, soft ... far too qualitative for a discussion like
> this. Numbers, test cases and applications determine different
> meanings of these words.

Right. Hard and Soft realtime discussions end up always in useless
infinite loops. The *applications*' *requirements* are hard or soft.

These requirements reflect in the OS, the CPU, the IO devices, and more
typically a convolution of all of them, depending on what the
application does, i.e., the actual sequence of computations, OS
syscalls, IO operations and so on...

> Top copy a phrase from one of the presentations from dresden.

Which presentation? I am curious to read it.

> Real-time need not always be real fast.

"Real fast is not real-time" is a catchy phrase which comes from this
very old workshop:

http://www.langston.com/Papers/uk.pdf

I used it to motivate an investigation in the real-time properties of a
"real fast" microkernel:

http://www.hindawi.com/journals/es/2008/234710.abs.html

Have fun!

	Sergio
