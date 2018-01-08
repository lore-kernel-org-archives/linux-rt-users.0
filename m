From: Daniel Wagner <daniel.wagner@siemens.com>
Subject: Re: [ANNOUNCE] Linux 4.4.15-cip15-rt10
Date: Mon, 8 Jan 2018 11:13:12 +0100
Message-ID: <94212c58-73c7-7356-b325-9e7f18c9bfbc@siemens.com>
References: <b4cf2728-0d0c-5128-d007-818e66da5613@siemens.com>
 <20180108093350.lxjocaxlvrmjwpav@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:51169 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755062AbeAHK2R (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Jan 2018 05:28:17 -0500
In-Reply-To: <20180108093350.lxjocaxlvrmjwpav@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

On 01/08/2018 10:33 AM, Sebastian Andrzej Siewior wrote:
> On 2018-01-02 12:56:11 [+0100], Daniel Wagner wrote:
>> The release is based on the Linux 4.4.75-rt88 version. That is I
>> applied the -rt88 patch on the 4.4.75-cip6 kernel and merged in all
>> CIP releases.
> what is cip6?

CIP stands for Civil Infrastructure Platform [1]. Ben Hutchings maintains
the 4.4.x-cip kernel tree which is a super long stable tree [2].

>>   https://ci-rt.linutronix.de/RT-Test/kbuild.jsp?id=112
>>
>> Some of the builds are failing (allmodconfig), though it
>> doesn't look cip-rt specific, eg:
>>
>>     kernel/utilities/compiletest-runner@2/build/../include/linux/compiler.h:484 call to ‘__compiletime_assert_150’ declared with attribute error: BUILD_BUG_ON failed: hw_flag_names[NUM_IEEE80211_HW_FLAGS] != (void *)0x1
>>
>> Not sure how to handle those. IIRC, we don't support allmodconfig.
> 
> yes but adding
>   68920c973254 ("net/mac80211/debugfs.c: prevent build failure with
>   CONFIG_UBSAN=y")
> 
> could solve the issue.

Okay, I just don't know if Ben wants to add the patch to his tree though.

Thanks,
Daniel

[1] https://www.cip-project.org/
[2] https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance
