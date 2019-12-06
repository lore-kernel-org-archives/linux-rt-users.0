Return-Path: <SRS0=Qk+l=Z4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54C0C43603
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Dec 2019 15:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8251205F4
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Dec 2019 15:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ck/TEkSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLFPu4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:50:56 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49564 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfLFPuz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Dec 2019 10:50:55 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB6FoWDu130516;
        Fri, 6 Dec 2019 09:50:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575647432;
        bh=z1ddrnBoswoODisAIcZF+CmtQE/vK0JijAZ3Pcui0/8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ck/TEkSd1WRGxGle/weXm1bH3Vb6ntIT4d+cMTnFZagvX7NwZwBcK8qfvu9hHCWx8
         eYmbMzvX/KLRdBAYx77pZdyRPPoXGjxP1sHXwE3cy9v0/tafllj/9gf1MdNMVzmet9
         Z+IU+BRN9B95zO2YKkoljgSYfU0D6WYzpkBJfPIU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB6FoVHd101978
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Dec 2019 09:50:32 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Dec
 2019 09:50:31 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Dec 2019 09:50:31 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB6FoTwG128051;
        Fri, 6 Dec 2019 09:50:30 -0600
Subject: Re: [LTP] LTP realtime tests
To:     Joerg Vehlow <lkml@jv-coder.de>, Petr Vorel <pvorel@suse.cz>,
        <linux-rt-users@vger.kernel.org>, <rt@linutronix.de>
CC:     <ltp@lists.linux.it>, Carlos Hernandez <ceh@ti.com>
References: <20191205135020.GA7951@dell5510>
 <6a7fbfdf-4fda-70bb-01d8-19fb6218170d@jv-coder.de>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <bc04bede-48fb-68e4-2ade-6125268008a4@ti.com>
Date:   Fri, 6 Dec 2019 17:50:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6a7fbfdf-4fda-70bb-01d8-19fb6218170d@jv-coder.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

CC:

On 06/12/2019 08:13, Joerg Vehlow wrote:
> Hi Petr,
> 
> we are running these tests and from what I've seen the quality is very poor.
> We had to make changes to a lot of them to make them pass reliably:
> most of the tests: Missing checks of return value for pthread function and resulting deadlock
> prio-wake and prio-preempt: Bound to a single cpu core
> sched_football: Needs a sleep to run reliable (I send a mail some time ago to this mailing list
> regarding the validity of the test, which got forwarded to lkml by cyril, but no reply)
> 
> Some tests do not return the correct result e.g.:
> testpi-5, testpi-6, sched_jitter, gtod_latency
> 
> I haven't really looked into most of these tests.
> 
> Jörg
> 
> Am 05.12.2019 um 14:50 schrieb Petr Vorel:
>> Hi RT folks,
>>
>> looking into LTP realtime tests (testcases/realtime/ [1]),
>> the code certainly deserves cleanup.
>>
>> Looking at [2], it does not mention these tests at all.
>> Can anyone comment on relevance of these tests to current RT?
>> Does anyone use these tests?
>>
>> Thanks for feedback.
>>
>> Kind regards,
>> Petr
>>
>> [1] https://github.com/linux-test-project/ltp/tree/master/testcases/realtime
>> [2] https://elinux.org/Realtime_Testing_Best_Practices#Test_programs
>>
> 

-- 
Best regards,
grygorii
