Return-Path: <SRS0=OpkQ=TJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B7AC04AB1
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 07:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A260E2173C
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 07:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfEIHvF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 May 2019 03:51:05 -0400
Received: from smtp-sp200-203.kinghost.net ([177.185.200.203]:48359 "EHLO
        smtp-sp200-203.kinghost.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbfEIHvE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 May 2019 03:51:04 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 May 2019 03:51:03 EDT
Received: from smtpi-sp-244.kinghost.net (smtpi-sp-244.kinghost.net [177.185.201.244])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-sp200-203.kinghost.net (Postfix) with ESMTPS id 450BC10037984
        for <linux-rt-users@vger.kernel.org>; Thu,  9 May 2019 04:44:37 -0300 (-03)
Received: from t460s.bristot.redhat.com (198.red-83-43-182.dynamicip.rima-tde.net [83.43.182.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daniel@bristot.eti.br)
        by smtpi-sp-244.kinghost.net (Postfix) with ESMTPSA id 3233B6000F0F;
        Thu,  9 May 2019 04:44:26 -0300 (-03)
Subject: Re: Real-time micro-conference proposal for Linux Plumbers 2019
To:     =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
 <f1507572-cb9d-e347-fc5e-42b9c90f5ed5@numalliance.com>
From:   Daniel Bristot de Oliveira <daniel@bristot.me>
Message-ID: <c474e4e5-b471-b505-f6fc-6422b40af20e@bristot.me>
Date:   Thu, 9 May 2019 09:44:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f1507572-cb9d-e347-fc5e-42b9c90f5ed5@numalliance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SND-ID: E3DhL4HZvWApxdeEu0+R3k19tF2vhIUMcvigv4x0qidpkEMv/61pVU+Ic2kX
        C2E5z/9xJ4WEtUyKW/eV3FZ7zmaiZL4jAC+FYM/DXGPSGG7DqAs9XBU+/eo9
        udhih1mYnG7sSSJQBijp+M+K8KbGT/z5M++/0vjTAnYVY6gB7Ke2wzEpPjyN
        yeLvIrPIJ7OdwqpaaevzJZom1tPf5tJTjBBAu2+7HOhsHADqvEZoWoDHvPdo
        +3peEBOEC8q2YPGEIZiNoqohoSTZfb5IBf+gBYru3DSbte9PbRAxPWREFndq
        qVUted8gbU/6vHD8MRb7GLYbfHPaKaGbyHkcSP7HCYWDLGHUdpv7/n8ZYB27
        0dJ9F2By/tZRLb7E5kwjbdsgePFFcgMCkYbLP0T9445Uq5MhmJ5jk2p8u8lD
        2KCL52N0TeUxw/LznrRaIDVRYU6tHI/tOaKB4QeE4JspwZ8VQl7JgYUb2dG6
        Z2zqBm0hRL8dl5ecNOmQzThzwxqEQHcF
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Stephane!

On 5/7/19 8:46 AM, Stéphane Ancelot wrote:
> Hi guys,
> 
> That's a good job. Regarding this topic, I would be interested in knowing the
> future of network drivers in preempt RT.
> 
> At the moment, it is mandatory to hack any network driver, if you want to
> achieve realtime.
> 
> This would imply inhibit some layer functions of the driver (eg vlan, etc ...).
> 
> The NAPI model in network drivers is not really compatible with RT tasks.
> 
> To achieve this task , I would suggest network driver architecture must adopt an
> enhanced driver model .
> 
> This may be some work planning.

Sorry for the delay, I am attending to an academic conference (these conferences
drains my brain out).

This is an interesting topic! Will you attend to the Plumbers? Do you have any
suggestions on how to change the NAPI model or how to change the driver
architecture to be more "real-time friendly?"

-- Daniel


> Regards,
> 
> S.Ancelot
> 
> 
> Le 03/05/2019 à 08:53, Daniel Bristot de Oliveira a écrit :
>> Hi all!
>>
>> Last year we had a very fun and productive real-time micro-conference at the
>> Linux Plumbers Conference, so the idea is to repeat it this year!
>>
>> Are you interested in participating? Do you have any suggestion of topic? Let us
>> know!
>>
>> This is the current proposal of micro-conference, we can still edit it and add
>> your thoughts.
>>
>> ======================== PROPOSAL ==============================
>> Since 2004 a project has improved the Real-time and low-latency features for
>> Linux. This project has become know as PREEMPT_RT, formally the real-time patch.
>> Over the past decade, many parts of the PREEMPT RT became part of the official
>> Linux code base. Examples of what came from PREEMPT_RT include: Real-time
>> mutexes, high-resolution timers, lockdep, ftrace, RT scheduling, SCHED_DEADLINE,
>> RCU_PREEMPT, generic interrupts, priority inheritance futexes, threaded
>> interrupt handlers and more. The number of patches that needs integration has
>> been reduced on the last years, and the pieces left are now mature enough to
>> make its way into mainline Linux. This year could possibly be the year
>> PREEMPT_RT is merged (tm)!
>>
>> In the final lap of this race, the last patches are on the way to be merged, but
>> there are still some pieces missing. When the merge occurs, the preempt-rt will
>> start to follow a new pace: the Linus one. So, it is possible to raise the
>> following discussions:
>>
>>    1) The status of the merge, and how can we resolve the last issues that block
>> the merge;
>>    2) How can we improve the testing of the -rt, to follow the problems raised as
>> Linus tree advances;
>>    3) What's next?
>>
>> Possible topics:
>>     - Status of the PREEMPT_RT Merge
>>
>>     - Merge - what is missing and who can help?
>>
>>     - How do we teach the rest of the kernel developers how not to break
>>       PREEMPT_RT?
>>
>>     - Stable maintainers tools discussion & improvements.
>>
>>     - Interrupt threads are RT and are not protected by the RT Throttling.
>>       How can we prevent interrupt thread starvation from a rogue RT task?
>>
>>     - Improvements on full CPU isolation
>>
>>     - Newer methods like proxy execution, hierarchical scheduler?
>>
>>     - What tools can we add into tools/ that other kernel developers can use to
>>       test and learn about PREEMMPT_RT?
>>
>>     - What tests can we add into tools/testing/selftests?
>>
>>     - New tools for timing regression test, e.g. locking, overheads...
>>
>>     - What kernel boot self-tests can be added?
>>
>>     - Discuss various types of failures that can happen with PREEMPT_RT
>>       that normally would not happen in the vanilla kernel, e.g, with lockdep,
>>       preemption model.
>>
>> I will suggest the continuation of the discussions of the topics I presented
>> last year, based in the results of the work I did this year (spoiler: I am doing
>> model verification in the kernel, and it is very efficient!).
>>
>> Paul already told that he could talk about ongoing work to make RCU's forward
>> progress be more robust in overloaded cloud deployments. There will be some
>> connection to real-time response involving rcu_poll and the infamous RCU kthread
>> priority!
>>
>> The continuation of the discussion of topics from last year's micro-conference,
>> including the development done during this (almost) year, are also welcome!
>>
>> -- Daniel
