Return-Path: <SRS0=6kRx=WP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78566C3A59F
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 06:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3CC20851
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 06:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfHSGex (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:34:53 -0400
Received: from mail.monom.org ([188.138.9.77]:57976 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSGex (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Aug 2019 02:34:53 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 2C91E5005CF;
        Mon, 19 Aug 2019 08:34:51 +0200 (CEST)
Received: from [192.168.154.174] (b9168f76.cgn.dg-w.de [185.22.143.118])
        by mail.monom.org (Postfix) with ESMTPSA id EDFAB500294;
        Mon, 19 Aug 2019 08:34:50 +0200 (CEST)
Subject: Re: [PATCH rt-tests v0 1/4] pmqtest: Increase buffer to avoid
 overflow
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
References: <20190816064204.6339-1-wagi@monom.org>
 <20190816064204.6339-2-wagi@monom.org>
 <20190816154132.xk5u7di6d5jdzw5v@linutronix.de>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <ebd1627d-bbc5-d6dc-48b6-159b265bd2dd@monom.org>
Date:   Mon, 19 Aug 2019 08:34:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816154132.xk5u7di6d5jdzw5v@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/16/19 5:41 PM, Sebastian Andrzej Siewior wrote:
> On 2019-08-16 08:42:01 [+0200], Daniel Wagner wrote:
>> Increase the size of the char buffer. gcc 9.1.1 reports:
>>
>> src/pmqtest/pmqtest.c: In function ‘main’:
>> src/pmqtest/pmqtest.c:46:21: warning: ‘%d’ directive writing between 1 and 10 bytes into a region of size 8 [-Wformat-overflow=]
>>     46 | #define SYNCMQ_NAME "/syncmsg%d"
>>        |                     ^~~~~~~~~~~~
>>
>> src/pmqtest/pmqtest.c:445:3: note: ‘sprintf’ output between 10 and 19 bytes into a destination of size 16
>>    445 |   sprintf(mqname, SYNCMQ_NAME, i);
>>        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Daniel Wagner <wagi@monom.org>
>> ---
>>   src/pmqtest/pmqtest.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
>> index a04fc49872bf..20164c8d547f 100644
>> --- a/src/pmqtest/pmqtest.c
>> +++ b/src/pmqtest/pmqtest.c
>> @@ -440,7 +440,7 @@ int main(int argc, char *argv[])
>>   		goto nomem;
>>   
>>   	for (i = 0; i < num_threads; i++) {
>> -		char mqname[16];
>> +		char mqname[32];
> 
> The compiler says, based on SYNCMQ_NAME's size and maximum possible %d
> we will have 19 bytes max. Why do you change it to 32? Why it is not
> wrong, one might ask what the extra storage is for.

I was taking the 16 bytes value as reference and doubled it. Indeed, 19 
bytes would be a better choice. Let me refresh the series.
