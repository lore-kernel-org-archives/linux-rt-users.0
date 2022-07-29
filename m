Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20644C00144
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Jul 2022 16:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbiG2Qi3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 12:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbiG2Qhx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Jul 2022 12:37:53 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADF988F2C
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Jul 2022 09:37:41 -0700 (PDT)
Received: from [192.168.1.30] (unknown [70.105.249.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6D7423F3BA;
        Fri, 29 Jul 2022 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1659112660;
        bh=CAzf+YNlP6WYOCElCMYgZB8EuaCxhQRq+Gh+W7p9DXk=;
        h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
         In-Reply-To:Content-Type;
        b=pxCCWa961t9LUd0H//DvJLrbLsu3caFgZTPgXCz/ShXC2iDSResKrzTrRNoFr1Xap
         BtaHvbIrdLN93cPckhsjZ+4M5q81ldHnAds0dBDNgP7Fubfk56iF6sIp+Gtp3I0MVq
         Nia9zqu30yZp11KFBycoZ08u4TIydpQAfgpQTJr2Ps8bN3Zt4keEp8WWoDZ86GCAWj
         R8h/nlvviugBZ37YV+JbXFDAZi9AZjsNJwlPqU6uuSU3U/gT4pKVkcC7y/t3urSRgY
         MMyEWTSoYp3UwgFu/yIVKLf+lQ0xKMpBGeqCeo4CrvWWqODo2kBGK7QVAs8f+/hpCK
         f+wrVNAUY5QNA==
Message-ID: <181525bd-1d06-b1d6-7af1-e4bf770cc9bd@canonical.com>
Date:   Fri, 29 Jul 2022 12:37:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     David Oberhollenzer <goliath@infraroot.at>,
        linux-rt-users@vger.kernel.org, williams@redhat.com, richard@nod.at
References: <20220712112238.18824-1-goliath@infraroot.at>
 <60f230fb-de97-ead8-b3a3-12a591804c32@canonical.com>
 <YuQHe3g3Ydmljx7M@linutronix.de>
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: Re: [PATCH 0/4] Backport MEMCG changes from v5.17
In-Reply-To: <YuQHe3g3Ydmljx7M@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 7/29/22 12:14, Sebastian Andrzej Siewior wrote:
> On 2022-07-27 16:35:44 [-0400], Joseph Salisbury wrote:
>> Hi David,
> Hi,
>
>> Do you know if these patches will be merged into the 5.15 patchset?
> I'm going to look at these next week. Has this been tested?
Thanks for the update, Sebastian!  I have not tested the patches 
myself.  There is an open Ubuntu kernel bug[0].  I can build a test 
kernel for the bug reporter and ask them to test.  I will provide 
testing results to this thread.
>
>> Thanks,
>>
>> Joe
> Sebastian


[0] http://pad.lv/1978814
