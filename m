From: Daniel Wagner <daniel.wagner@siemens.com>
Subject: Re: [ANNOUNCE] Linux 4.4.15-cip15-rt10
Date: Wed, 10 Jan 2018 10:04:44 +0100
Message-ID: <b755c1e1-1246-b230-b8ab-2154d8ce37ad@siemens.com>
References: <b4cf2728-0d0c-5128-d007-818e66da5613@siemens.com>
 <20180108093350.lxjocaxlvrmjwpav@linutronix.de>
 <94212c58-73c7-7356-b325-9e7f18c9bfbc@siemens.com>
 <20180108105621.osnfazlumesxkwv3@linutronix.de>
 <1515531937.12097.1.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lizzard.sbs.de ([194.138.37.39]:56573 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752987AbeAJJFH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Jan 2018 04:05:07 -0500
In-Reply-To: <1515531937.12097.1.camel@codethink.co.uk>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ben,

>>>>>   https://ci-rt.linutronix.de/RT-Test/kbuild.jsp?id=112
>>>>>
>>>>> Some of the builds are failing (allmodconfig), though it
>>>>> doesn't look cip-rt specific, eg:
>>>>>
>>>>>>>>>     kernel/utilities/compiletest-runner@2/build/../include/linux/compiler.h:484 call to ‘__compiletime_assert_150’ declared with attribute error: BUILD_BUG_ON failed: hw_flag_names[NUM_IEEE80211_HW_FLAGS] != (void *)0x1
>>>>>
>>>>> Not sure how to handle those. IIRC, we don't support allmodconfig.
>>>>
>>>> yes but adding
>>>>   68920c973254 ("net/mac80211/debugfs.c: prevent build failure with
>>>>   CONFIG_UBSAN=y")
>>>>
>>>> could solve the issue.
>>>
>>> Okay, I just don't know if Ben wants to add the patch to his tree though.
>>
>> If the patch solves the issue then please forward the patch upstream.
>> The "normal" v4.4 stable tree is affected by this, too.
> 
> 4.4-stable doesn't have UBSAN.  Are some other configurations (or
> compiler versions) where this code fails to build?  (I'm a bit
> surprised that it ever compiled!)

The problem was introduced by 30686bf7f5b3 ("mac80211: convert HW flags
to unsigned long bitmap"). The only LTS kernel which is missing the
68920c973254 ("net/mac80211/debugfs.c: prevent build failure with
CONFIG_UBSAN=y") fix is the 4.4. The other don't have 30686bf7f5b3, e.g.
4.1, or have 30686bf7f5b3 and 68920c973254, e.g. 4.9.

I've sent 68920c973254 to stable for inclusion into 4.4.

	https://www.spinics.net/lists/stable/msg209228.html

Thanks,
Daniel


