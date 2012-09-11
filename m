From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Question regarding 'sched: RT throttling activated'
Date: Tue, 11 Sep 2012 11:55:38 -0700
Message-ID: <E22FBA66-9D10-4CC6-975C-1F2A66BFAA07@thebigcorporation.com>
References: <OF6683632B.9200AAEB-ONC1257A76.0053E7B9-C1257A76.00558786@br-automation.com> <1347387029.7018.53.camel@marge.simpson.net>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1486\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>,
	linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Josef Baumgartner <Josef.Baumgartner@br-automation.com>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65297 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759171Ab2IKSzr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2012 14:55:47 -0400
Received: by pbbrr13 with SMTP id rr13so1189856pbb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Sep 2012 11:55:46 -0700 (PDT)
In-Reply-To: <1347387029.7018.53.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sep 11, 2012, at 11:10 AM, Mike Galbraith <efault@gmx.de> wrote:

> On Tue, 2012-09-11 at 17:34 +0200, Wolfgang Wallner wrote:
> 
>>>> My questions are now:
>>>> 
>>>> * What does this logging entry mean?
>>>> Could you please point me to some information about RT throttling
>>>> so that I can understand what's it about?
>> 
>>> With stock settings, it means realtime task[s] consumed > 95% of the
>>> throttle interval (1s), so the throttle activated, allowing
>> SCHED_NORMAL
>>> tasks to have a sip of CPU, to let you try to save the box from
>> nutty RT
>>> CPU hogs. See kernel/sched_rt.c.
>> 
>> I think if the application turns into a cpu hog...
> 
> Where from comes 'if'?  You presented evidence, so methinks there's not
> a _lot_ of room for an 'if', there's just a missing 'why'.

Well, as you know a lot of folks do polling, but its important to make sure not ALL cores are doing that...

Need to look at the code, maybe we could add a mask to restrict throttling per cpu (e.g. to 0) ?

Sven

> 
> -Mike
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

