From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Doubt: Does RT patch reduce interrupt latency?
Date: Sat, 25 Jul 2009 21:23:27 -0700
Message-ID: <1248582207.16032.76.camel@quadrophenia.thebigcorporation.com>
References: <4cd511390907241111x3c6c9bbcw25230775c34ba3e@mail.gmail.com>
	 <1248462240.7533.14.camel@sven.thebigcorporation.com>
	 <4cd511390907252021m78ae5c14hb8faaef9459eed6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sbs <sbs.pub@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f184.google.com ([209.85.216.184]:53402 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbZGZEX3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 26 Jul 2009 00:23:29 -0400
Received: by pxi14 with SMTP id 14so948190pxi.33
        for <linux-rt-users@vger.kernel.org>; Sat, 25 Jul 2009 21:23:29 -0700 (PDT)
In-Reply-To: <4cd511390907252021m78ae5c14hb8faaef9459eed6e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2009-07-26 at 08:51 +0530, Sbs wrote:
> > Did you raise the priority for the 1 ms IRQ thread?
> 
> Sorry, this test was done by one of my team-mate. I should have
> gathered enough information before mailing. I will check with him and
> if that was not done, we will try again with raised priority. Then I
> will get back to the list with more details and queries.
> 
> However, we did use the nodelay flag while requesting the IRQ. If
> nodelay flag is used, does the priority still matter? Doesn't the use
> of this flag make the kernel to treat this interrupt in the
> traditional way? Are we really making use of any rt capability?
> 

In general, when using nodelay, this would be the highest effective
priority for an IRQ.

Are there nested PICs? Keep in mind that threads mask off IRQ lines
until they have run, so you may want to make sure that all the lines
that handle IRQ cascade are also NODELAY. 

> Btw, we are testing this on ARM platform.
> 
> Thanks,
> Sbs
> 
> >
> >> Thanks in advance,
> >>
> >> Regards,
> >> Sbs
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >

