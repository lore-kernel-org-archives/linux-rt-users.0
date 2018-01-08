From: Daniel Wagner <daniel.wagner@siemens.com>
Subject: Re: [ANNOUNCE] Linux 4.4.15-cip15-rt10
Date: Mon, 8 Jan 2018 12:45:16 +0100
Message-ID: <84996d9c-54e1-b90b-fd06-948cabf447ef@siemens.com>
References: <b4cf2728-0d0c-5128-d007-818e66da5613@siemens.com>
 <20180108093350.lxjocaxlvrmjwpav@linutronix.de>
 <94212c58-73c7-7356-b325-9e7f18c9bfbc@siemens.com>
 <20180108105621.osnfazlumesxkwv3@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:56636 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756294AbeAHLp0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Jan 2018 06:45:26 -0500
In-Reply-To: <20180108105621.osnfazlumesxkwv3@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/08/2018 11:56 AM, Sebastian Andrzej Siewior wrote:
>>>>     kernel/utilities/compiletest-runner@2/build/../include/linux/compiler.h:484 call to ‘__compiletime_assert_150’ declared with attribute error: BUILD_BUG_ON failed: hw_flag_names[NUM_IEEE80211_HW_FLAGS] != (void *)0x1
>>>>
>>>> Not sure how to handle those. IIRC, we don't support allmodconfig.
>>>
>>> yes but adding
>>>   68920c973254 ("net/mac80211/debugfs.c: prevent build failure with
>>>   CONFIG_UBSAN=y")
>>>
>>> could solve the issue.
>>
>> Okay, I just don't know if Ben wants to add the patch to his tree though.
> 
> If the patch solves the issue then please forward the patch upstream.
> The "normal" v4.4 stable tree is affected by this, too.

Ah, I misunderstood you first. I'll picked the patch and let it run
through the ci system now and forward it to Greg if it solved the issue.

Thanks,
Daniel
