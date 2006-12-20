From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [patch 0/4] ARM: OMAP: Add clocksource and clockevent driver
 for OMAP
Date: Wed, 20 Dec 2006 22:28:50 +0100
Message-ID: <4589AB12.1020309@gmail.com>
References: <4588FFC7.5060203@gmail.com> <20061220155507.GB1710@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de,
	David Brownell <david-b@pacbell.net>,
	Daniel Walker <dwalker@mvista.com>,
	Kevin Hilman <khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:34881 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030360AbWLTV3B (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Dec 2006 16:29:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2369627uga
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Dec 2006 13:28:59 -0800 (PST)
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20061220155507.GB1710@thunk.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Theodore Tso wrote:
> On Wed, Dec 20, 2006 at 10:17:59AM +0100, Dirk Behme wrote:
> 
>>the following patches add clocksource and clockevent driver
>>for ARM based TI OMAP devices.
>>
>>They are against linux-2.6.19 + patch-2.6.20-rc1 +
>>patch-2.6.20-rc1-rt0. The clocksource patch went through
>>several review cycles on OMAP list.
> 
> 
> Hi Dirk,
> 
> 	As a suggestion, could you consider sending patches to
> linux-kernel@vger.kernel.org?  One of the reasons why we (in
> consultation with folks like Ingo and tglx) deliberatly didn't create
> a RT development list was that in order to promote getting -rt related
> patches into mainline as soon as possible, we wanted to keep patch and
> development discussion on LKML.  For example, it's not clear that the
> ARM maintainer subscribes to linux-rt-users; furthermore the more
> patch discussion happens on LKML, it helps promote willingness of
> other kernel developers that CONFIG_PREEMPT_RT isn't going to go away,
> and will probably (hopefully!) be merged into mainline someday soon.

Many thanks for this clarification! Yes, I will see to find 
some time to send the patches to LKML.

I will check as well if parts of your quite good explanation 
above will fit into rt wiki.

Cheers

Dirk
