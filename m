From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Doubt: Does RT patch reduce interrupt latency?
Date: Fri, 24 Jul 2009 12:04:00 -0700
Message-ID: <1248462240.7533.14.camel@sven.thebigcorporation.com>
References: <4cd511390907241111x3c6c9bbcw25230775c34ba3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sbs <sbs.pub@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f226.google.com ([209.85.219.226]:46433 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbZGXTEK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jul 2009 15:04:10 -0400
Received: by ewy26 with SMTP id 26so1968005ewy.37
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jul 2009 12:04:08 -0700 (PDT)
In-Reply-To: <4cd511390907241111x3c6c9bbcw25230775c34ba3e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-07-24 at 23:41 +0530, Sbs wrote:
> Hi All,
> 
> (Sorry if I am asking this on a wrong list. Please let me know the
> correct list for this question)
> 
> We have a system which needs to be connected to a device that will
> produce an interrupt during every msec. So, we want interrupt
> latencies less than 1 msec (else we will miss interrupts). We tried
> measuring interrupt latencies with RT patch applied. However, the
> results that he got suggested that after applying patches, the worst
> case latency went up.
> 
> From what I read and understood from the site is that, the patch will
> cause this kind of behaviour. Is this correct? (" Converting interrupt
> handlers into preemptible kernel threads:" - RT wiki FAQ)  I have seen
> some other site mentioning about rtirq patch (for 2.4). What is good
> for my scenario? Should I apply an RT patch at all? Or is there
> something else that I need to see?
> 

Did you raise the priority for the 1 ms IRQ thread?

> Thanks in advance,
> 
> Regards,
> Sbs
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

