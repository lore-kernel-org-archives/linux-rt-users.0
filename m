Return-Path: <SRS0=drm8=UP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B90EC31E50
	for <linux-rt-users@archiver.kernel.org>; Sun, 16 Jun 2019 16:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738C620644
	for <linux-rt-users@archiver.kernel.org>; Sun, 16 Jun 2019 16:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfFPQet (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 16 Jun 2019 12:34:49 -0400
Received: from mail.monom.org ([188.138.9.77]:32952 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfFPQet (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 16 Jun 2019 12:34:49 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 6BBFB5007D2;
        Sun, 16 Jun 2019 18:34:46 +0200 (CEST)
Received: from [192.168.154.174] (ppp-93-104-164-137.dynamic.mnet-online.de [93.104.164.137])
        by mail.monom.org (Postfix) with ESMTPSA id 2C5CD500796;
        Sun, 16 Jun 2019 18:34:46 +0200 (CEST)
Subject: Re: [PATCH v2 08/12] cyclicdeadline: Add duration command line
 argument
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
References: <20190605160617.22987-1-wagi@monom.org>
 <20190605160617.22987-9-wagi@monom.org>
 <alpine.LFD.2.21.1906131617340.8187@planxty>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <30b32fa9-d771-2a1a-5260-21ce605ffa0b@monom.org>
Date:   Sun, 16 Jun 2019 18:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1906131617340.8187@planxty>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On 6/13/19 4:18 PM, John Kacur wrote:
> 
> 
> On Wed, 5 Jun 2019, Daniel Wagner wrote:
> 
>> Many of the test programs have the --loop argument for automatic
>> stopping. The main problem with the --loop argument is how long is
>> --loop 1000?
>>
>> To simplify automated tests introduce a --duration argument which
>> allows to set the time how long a test should run. This allows the
>> test suite to define the execution time and also the timeout which a
>> normal human can understand.
>>
>> For example run the test for 10 minutes and timeout at 11 minutes:
>>
>>    # timeout 11m cyclicdeadline -D 10m
>>
>> Signed-off-by: Daniel Wagner <wagi@monom.org>
>> ---
>>   src/sched_deadline/cyclicdeadline.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
>> index 6d461b27ac43..47892daf747b 100644
>> --- a/src/sched_deadline/cyclicdeadline.c
>> +++ b/src/sched_deadline/cyclicdeadline.c
>> @@ -21,6 +21,8 @@
>>   #include <linux/unistd.h>
>>   #include <linux/magic.h>
>>   
>> +#include <rt-utils.h>
>> +
>>   #ifdef __i386__
>>   #ifndef __NR_sched_setattr
>>   #define __NR_sched_setattr		351
>> @@ -1049,6 +1051,7 @@ int main (int argc, char **argv)
>>   	unsigned int interval = 1000;
>>   	unsigned int step = 500;
>>   	int percent = 60;
>> +	int duration = 0;
>>   	u64 runtime;
>>   	u64 start_period;
>>   	u64 end_period;
>> @@ -1062,7 +1065,7 @@ int main (int argc, char **argv)
>>   		exit(-1);
>>   	}
>>   
>> -	while ((c = getopt(argc, argv, "+hac:i:s:t:")) >= 0) {
>> +	while ((c = getopt(argc, argv, "+hac:i:s:t:D:")) >= 0) {
>>   		switch (c) {
>>   		case 'a':
>>   			all_cpus = 1;
>> @@ -1081,6 +1084,9 @@ int main (int argc, char **argv)
>>   		case 't':
>>   			nr_threads = atoi(optarg);
>>   			break;
>> +		case 'D':
>> +			duration = parse_time_string(optarg);
>> +			break;
>>   		case 'h':
>>   		default:
>>   			usage(argv);
>> @@ -1246,6 +1252,10 @@ int main (int argc, char **argv)
>>   
>>   	signal(SIGINT, sighand);
>>   	signal(SIGTERM, sighand);
>> +	signal(SIGALRM, sighand);
>> +
>> +	if (duration)
>> +		alarm(duration);
>>   
>>   	if (!fail)
>>   		loop(sched_data, nr_threads);
>> -- 
>> 2.20.1
>>
> 
> I fixed-up some dos like line endings you added in the man page, are you
> doing something weird with your editor?

Just guessing: my editor sees DOS encoding in the file and preserves the 
mode. I haven't had this problem before. Very strange.

Sorry for the additional work.

Thanks,
Daniel
