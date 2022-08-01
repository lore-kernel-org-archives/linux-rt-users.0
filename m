Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A47C00144
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Aug 2022 22:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiHAWgh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 1 Aug 2022 18:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiHAWgg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 1 Aug 2022 18:36:36 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D483881
        for <linux-rt-users@vger.kernel.org>; Mon,  1 Aug 2022 15:36:34 -0700 (PDT)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D253E3F399;
        Mon,  1 Aug 2022 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1659393391;
        bh=gTx2SUweTAa1BMHmyc7ynaq26CQYsBfBAYdcIMGEXkM=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=FnNaxQLEjGiZ/I/XwSY3sa11vl483iBkdxZw88sgetm7vx0aX4YAFr5+YXCJmYeAW
         UGQyRz53alP8Do13Ualra+Z6TpDy02tFHytgGs77BkAiBgcghD/z4myrVFwWQBVoOD
         utf8lGY6g/2qqCUoHx/bUsjwWW/hanAmx8/HhI+gBeTHlzferz7GAOd2s+2OrZC1hK
         w94Gcg1Rf5UF+6DjJBhnnv4ZDqJOIHiWe6LowkAksdG74ZpIQQhOzTGe5cQRlUGg2K
         QIWcZqgxBigU4jRsu2nSoqhaaprabmDF874R7QD6/oosZAtm2F9iedHzIOr22ZBc9P
         fIc+m0wpq7CkA==
Message-ID: <aa48288b-2982-0756-4350-3287bdf6c09f@canonical.com>
Date:   Mon, 1 Aug 2022 18:36:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] Backport MEMCG changes from v5.17
Content-Language: en-US
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     David Oberhollenzer <goliath@infraroot.at>,
        linux-rt-users@vger.kernel.org, williams@redhat.com, richard@nod.at
References: <20220712112238.18824-1-goliath@infraroot.at>
 <60f230fb-de97-ead8-b3a3-12a591804c32@canonical.com>
 <YuQHe3g3Ydmljx7M@linutronix.de>
 <cac0fa51-0e02-b759-4887-cfa3141c9154@canonical.com>
In-Reply-To: <cac0fa51-0e02-b759-4887-cfa3141c9154@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 8/1/22 14:17, Joseph Salisbury wrote:
>
>
> On 7/29/22 12:14, Sebastian Andrzej Siewior wrote:
>> On 2022-07-27 16:35:44 [-0400], Joseph Salisbury wrote:
>>> Hi David,
>> Hi,
>>
>>> Do you know if these patches will be merged into the 5.15 patchset?
>> I'm going to look at these next week. Has this been tested?
> If anyone is interested in testing these patches with the Ubuntu 
> distro, I created a 5.15.39 based test kernel which is packaged as a 
> .deb. This test kernel has the rt-42 patch set, and the four patches 
> from David.
> This test kernel can be downloaded from:
> https://people.canonical.com/~jsalisbury/MEMCG_UNSUPPORTED_TEST_KERNEL/
Also, the test kernel is AMD64.  If anyone needs an ARM64 kernel, just 
let me know.
>
> This kernel will also be tested in an Ubuntu kernel bug[0].  The bug 
> reporter will be testing if the patches resolve a bug that affects 
> kubernetes, which is missing cgroup memory.  However, the bug reporter 
> will probably not be testing latency differences. That is something I 
> could look into next week.
>
> Joe
>
> [0] http://pad.lv/1978814
>>
>>> Thanks,
>>>
>>> Joe
>> Sebastian
>

