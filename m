Return-Path: <SRS0=drm8=UP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B282C31E50
	for <linux-rt-users@archiver.kernel.org>; Sun, 16 Jun 2019 16:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F29204EC
	for <linux-rt-users@archiver.kernel.org>; Sun, 16 Jun 2019 16:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfFPQ3u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 16 Jun 2019 12:29:50 -0400
Received: from mail.monom.org ([188.138.9.77]:32912 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfFPQ3u (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 16 Jun 2019 12:29:50 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 988E65006DE;
        Sun, 16 Jun 2019 18:29:47 +0200 (CEST)
Received: from [192.168.154.174] (ppp-93-104-164-137.dynamic.mnet-online.de [93.104.164.137])
        by mail.monom.org (Postfix) with ESMTPSA id 4A0035007D2;
        Sun, 16 Jun 2019 18:29:47 +0200 (CEST)
Subject: Re: [PATCH v2 04/12] pi_stress: Allow short command line arguments
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
References: <20190605160617.22987-1-wagi@monom.org>
 <20190605160617.22987-5-wagi@monom.org>
 <alpine.LFD.2.21.1906131603230.8187@planxty>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <9218c750-b6d3-87f5-3c43-92ba0485bbda@monom.org>
Date:   Sun, 16 Jun 2019 18:29:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1906131603230.8187@planxty>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On 6/13/19 4:04 PM, John Kacur wrote:
>> index ac7646cd2613..543106be8e18 100644
>> --- a/src/pi_tests/pi_stress.c
>> +++ b/src/pi_tests/pi_stress.c
>> @@ -1322,9 +1322,8 @@ int process_sched_line(const char *arg)
>>   void process_command_line(int argc, char **argv)
>>   {
>>   	int opt;
>> -	while ((opt = getopt_long(argc, argv, "+", options, NULL)) != -1) {
>> +	while ((opt = getopt_long(argc, argv, "+ht:vqi:g:rs:pdVum", options, NULL)) != -1) {
>>   		switch (opt) {
>> -		case '?':
>>   		case 'h':
>>   			usage();
>>   			exit(0);
>> -- 
>> 2.20.1
>>
> 
> I actually don't see short options in the usage help text, but I do see
> them in the manpage.
> 
> This could use some clean-up to make sure the manpage is current and the
> usage text is current and synced too, if you or anyone else reading cares
> to address this.

pi_stress differs a bit in the handling of the options. Indeed it makes 
sense to streamline it with the other tools. Will look into it (but 
don't hold your breath :))

Thanks,
Daniel
