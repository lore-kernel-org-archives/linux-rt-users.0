From: Jeff Angielski <jeff@theptrgroup.com>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 10:21:52 -0400
Message-ID: <4C8F8500.5070002@theptrgroup.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <201009141317.13439@zigzag.lvk.cs.msu.su> <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com> <20100914094411.GB10841@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Raz <raziebe@gmail.com>, "Nikita V. Youshchenko" <yoush@cs.msu.su>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.theptrgroup.com ([71.178.251.9]:60395 "EHLO
	mail.theptrgroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab0INOcw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 10:32:52 -0400
In-Reply-To: <20100914094411.GB10841@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/14/2010 05:44 AM, Robert Schwebel wrote:
> On Tue, Sep 14, 2010 at 11:24:21AM +0200, Raz wrote:
>> anyone can say preempt rt is hard real time?
>
> Hard realtime has something to do with how you define "missing the
> deadline". If somebody cuts the cable of your roboter controller in the
> factory hall, the system misses the deadline. So it is all about
> probabilities: hard realtime systems have a very, very low probability
> of missing the deadline. However, in real life systems, it is>  0%.
>
> So yes, if you talk about real world, it is hard realtime.

No.  Preempt rt it's not hard realtime.

But most people/companies who think they need hard realtime really 
don't.  They can live with soft realtime and have a really low 
probability of missing deadlines and having long latencies.  For these 
people, the preempt rt is adequate.

-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com
