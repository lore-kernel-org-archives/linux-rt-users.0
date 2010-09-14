From: Klaas van Gend <klaas.van.gend@mvista.com>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 12:06:32 +0200
Message-ID: <201009141206.32587.klaas.van.gend@mvista.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <201009141317.13439@zigzag.lvk.cs.msu.su>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: "linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52725 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab0INKGi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 06:06:38 -0400
Received: by ywh1 with SMTP id 1so2315783ywh.19
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 03:06:38 -0700 (PDT)
In-Reply-To: <201009141317.13439@zigzag.lvk.cs.msu.su>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 14 September 2010 11:17:12 Nikita V. Youshchenko wrote:
> > Hello
> > some companies asked me to show that premmpt rt is comercially used.
> > are you using it ?
> 
> MontaVista has long supplied preempt-rt to lots of it's customers.

Let me elaborate on that a little.

Yes, we have a *lot* of customers using PREEMPT_RT. 
In my experience they fall into a few different categories:

1) using it because "it is faster". Well, I've tried to squash that idea at 
every customer I've been, but it's not easy to get out of their heads. 
In most cases, these customers have no clue why they enabled it.

2) using it because Linux was too slow otherwise.
Unfortunately something I've run across a few times now - that the embedded 
boards are too slow to reliably grab all bytes from a serial port. 
Of course this has something to do with system load and bad design of serial 
data streams... In many cases, missing a byte can cause serious trouble, like 
having to do a whole sample analysis again (lab equipment). 

3) using it to work around system limitations, e.g. reducing priority on less 
relevant interrupts and/or threads.
This is the best use case. For example, if you design data acquisition or 
control loops, they better run reliably, with low jitter. So you want to 
reduce priority of everything not that relevant.


Hope this helps!


-- 
Klaas van Gend
Senior Solutions Architect, MontaVista Software LLC

phone: +31 40 2801386
