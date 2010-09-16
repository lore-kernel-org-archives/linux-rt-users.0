From: Daniel James <daniel@64studio.com>
Subject: Re: preempt rt in commercial use
Date: Thu, 16 Sep 2010 11:17:51 +0100
Message-ID: <4C91EECF.1090705@64studio.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>	<20100914094411.GB10841@pengutronix.de>	<4C8F8500.5070002@theptrgroup.com>	<201009141830.03206@zigzag.lvk.cs.msu.su>	<4C8F8B79.1010300@theptrgroup.com>	<4C8FF52E.1030407@us.ibm.com>	<4C907A51.1050305@steinhoff.de>	<4C90D392.8040808@us.ibm.com> <AANLkTin_LCyT-bp+wQ3uRZ2X8xiox6iBAk+XhfK8hxWv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nivedita Singhvi <niv@us.ibm.com>,
	Armin Steinhoff <armin@steinhoff.de>,
	Jeff Angielski <jeff@theptrgroup.com>,
	"Nikita V. Youshchenko" <yoush@cs.msu.su>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	Raz <raziebe@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Pradyumna Sampath <pradysam@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rom012.server4you.de ([62.75.222.127]:57847 "EHLO
	rom012.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0IPKSJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Sep 2010 06:18:09 -0400
In-Reply-To: <AANLkTin_LCyT-bp+wQ3uRZ2X8xiox6iBAk+XhfK8hxWv@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Pradyumna,

> I have created a wiki page on http://rt.wiki.kernel.org/ ,
> https://rt.wiki.kernel.org/index.php/Systems_based_on_Real_time_preempt_Linux
> . Please feel free to update it as and when you encounter / build /
> read about interesting usage of RT_PREEMPT.

Here's a more unusual example we have worked on recently - a
multi-microphone hearing aid research platform:

http://www.64studio.com/press_release_mahalia

With six microphones (three per side) you can start to do interesting
things with software algorithms, like selective noise cancellation. A
well-known electronics company is using this system for field trials, in
collaboration with university researchers in Germany.

Cheers!

Daniel
