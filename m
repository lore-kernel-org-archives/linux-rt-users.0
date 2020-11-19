Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04FCC2D0E4
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 08:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525E4246AD
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 08:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgKSITQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Nov 2020 03:19:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:43994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgKSITP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Nov 2020 03:19:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B513EAD2B;
        Thu, 19 Nov 2020 08:19:14 +0000 (UTC)
Subject: Re: [rt-tests v1 01/12] cyclicdeadline: Remove dead code
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
References: <20201118190642.16006-1-dwagner@suse.de>
 <20201118190642.16006-2-dwagner@suse.de>
 <87wnyh7s6b.fsf@kokedama.swc.toshiba.co.jp>
From:   Daniel Wagner <dwagner@suse.de>
Message-ID: <70230c46-419c-c400-8b91-8249a265f335@suse.de>
Date:   Thu, 19 Nov 2020 09:19:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <87wnyh7s6b.fsf@kokedama.swc.toshiba.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Punit,

On 19.11.20 07:54, Punit Agrawal wrote:
> Hi Daniel,
> 
> One comment / query below -
> 
> Daniel Wagner <dwagner@suse.de> writes:
> 
>> my_sprintf() is not used, remove it.
>>
>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
>> ---
>>   compare.py                          | 12 ++++++++++++
>>   src/sched_deadline/cyclicdeadline.c | 13 -------------
>>   2 files changed, 12 insertions(+), 13 deletions(-)
>>   create mode 100644 compare.py
>>
>> diff --git a/compare.py b/compare.py
>> new file mode 100644
>> index 000000000000..7fb6ae818a00
>> --- /dev/null
>> +++ b/compare.py
>> @@ -0,0 +1,12 @@
>> +with open('old', 'r') as old:
>> +    with open('new', 'r') as new:
>> +        for ol in old.readlines():
>> +            new.seek(0)
>> +            for nl in new.readlines():
>> +                o = ol.split()
>> +                n = nl.split()
>> +
>> +                if o[8] == n[8]:
>> +                    d = int(n[4]) - int(o[4])
>> +                    p = d/int(o[4]) * 100
>> +                    print('{:20} {:>8} {:>8} {:>6} {:>2.2}%'.format(o[8], o[4], n[4], d, p))
> 
> This hunk seems to be unrelated and also not mentioned in the commit
> log. Perhaps it's accidentally part of this commit?

Indeed, this sneaked into the commit. Totally unrelated :)

I'll send an update.

Thanks,
Daniel
