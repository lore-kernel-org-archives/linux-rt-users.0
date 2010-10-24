From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: RT scheduling / scheduling of RT groups
Date: Sun, 24 Oct 2010 12:12:42 +0200
Message-ID: <4CC4069A.5040404@steinhoff.de>
References: <AANLkTim5r_GoCDp0oKmEjWbf+64UL1r35_3GmCow1ETD@mail.gmail.com> <4CC2E09B.7020704@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61516 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331Ab0JXKIz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 24 Oct 2010 06:08:55 -0400
In-Reply-To: <4CC2E09B.7020704@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


is KUPS the answer ??


Armin Steinhoff wrote:
> Hi all,
>
> AFAIK,  the RT scheduler (sched_rt.c) is part of the CFS.
>  Is there a way to handle task running with SCHED_NORMAL and 
> SCHED_OTHER also with the RT scheduler ?
> ( CFS deactivated )
>
> There are scheduling groups. In which way (priorities? other 
> attributes?)  are these groups defined ?
>  How can sched_rt_period and sched_rt_runtime be set or read?
>
> Cheers
>
> --Armin
>
>
>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

