From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Recommended motherboard
Date: Tue, 03 May 2011 22:13:09 +0200
Message-ID: <4DC061D5.30905@steinhoff.de>
References: <BANLkTinrbbV=8U8XDA1r+wNpbccVE7MsDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: dashesy <dashesy@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54870 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876Ab1ECUHH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 May 2011 16:07:07 -0400
In-Reply-To: <BANLkTinrbbV=8U8XDA1r+wNpbccVE7MsDQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello Dashesy,

very good information are available at:

https://www.osadl.org/Individual-system-data.qa-farm-data.0.html#c4630

Check out the latency plots and make your own conclusion.

--Armin




dashesy wrote:
> I have tested the rt31 patch and everything seems great on my
> off-the-shelf high-end Xeon desktop so far. I will continue testing
> and let you know if I find any oopses or panics :)
>
> We are in the process of upgrading our embedded system, now based on
> an old ADEOS patch.
> In the first step we need to substitute our soon to be obsolete
> motherboard with a new long life industrial motherboard that works
> with -rt (as we all hope it will be all in the mainline).
> I know I will be going to a lengthy validation and testing phase to
> choose the right motherboard, one that is reliable (for a medical
> device), state-of-the-art (at least two cores) and of course -rt
> compliant (some indication about thing like SMI or hrtimer issues for
> example).
>
> There are few book and plenty of resources out there. "Building
> Embedded Linux Systems by Karim Yaghmour, et al" is a nice book, and
> linux-rt archives, LWN and LKML have been the ultimate source to keep
> up with the past (as much as I could) an learn the new. To find out
> what might cause problem or what to avoid when designing the system.
>
> It seems the manufacturers section of the OSADL Realtime QA Farm is a
> good starting point to look for motherboards if one is concerned about
> the latency plots, however,
> That would be great if there was some sort of -rt compliance
> certificate or tag, issued by OSADL (one organization that I can think
> of). I believe, this might generate some revenue for the project, and
> some ease of mind for developers who want to start a fresh design.
>
> I appreciate any comments or suggestion about the motherboard.
>
> Thanks
> dashesy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

