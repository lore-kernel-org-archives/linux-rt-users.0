Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0D1C2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 07:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA31611CB
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 07:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEVH7R (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 22 May 2021 03:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhEVH7Q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 22 May 2021 03:59:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2093DC061574
        for <linux-rt-users@vger.kernel.org>; Sat, 22 May 2021 00:57:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t3so25848423edc.7
        for <linux-rt-users@vger.kernel.org>; Sat, 22 May 2021 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=s1OOL3EcnQ+FUKgm3y19A6bxHMNVueJJTNXRBDJWRSA=;
        b=f48Wj+kJ8jKNdzUV2Zr+/GZ+nDR1EHtFKIOiwiEFGfxoluZOw0c6Gs6dBhN3vchXBZ
         FjjglTjLZJq57AaQlCCSVgDLy2vTDtkCPvZ6zNZ3Y0De5dfHm7OHp2JPW1X9Si8uIqF3
         JZ73aiODta93/lAq5bm0QFrvpl7lk3rWieqm/pjlJfpdMA8oJY4SJRi6e7cAPrWSLruT
         wxs+n3P3ryf1utPM/Ffr2A8RRLPeFzYAi/ITithh4h7UmpW5FHVJXMlcyMM1PVUgu0Yr
         7bKVT2b622chrhr9Dmz6FCHnn8M8lvu7Xmo+zCcjEqJ1m/iYrnWROmT8iB5J8qHd7L/B
         6KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=s1OOL3EcnQ+FUKgm3y19A6bxHMNVueJJTNXRBDJWRSA=;
        b=YMDqOftCF6PJwLRmtkgFyCfotkGTgE5vciRbZhoCZ2BBSeY6Cu+5ZgRykCaI9AfxF7
         xCfWH1mxMgSx4+fPzR5RZASy7rWEo+0qxSHugIidsFJHafSbQN61ynz9FbFNeZ9NB+mh
         epQ9LgGLabfZGesGtc/YLJjEyx6cJaHEiXy0YTh4Hz54HqzUx1NTNwVdhbkIHeuN5cDP
         l3fq0VBsZHNoK6mDpvBCPCyUyDVbYhOcxw2x0InUAVS/3laVFgzQOoFk2cM5ryX8trop
         gHCGYp20Bakl7lyVjRydev2MVwYK54K3B1S+GxYTiWGul0g+GI4mrCAIHTR6wtaRv8KP
         B7qA==
X-Gm-Message-State: AOAM5317Jwquw7QLW++6hXBly0uCTMRZc7gyOfliaboO5lbNZOrVY4H2
        xaiSHO5jFmm8U4czU4AxGVcnKqwWe9Y=
X-Google-Smtp-Source: ABdhPJzsd8SBArgLex5TKQpAuukEwup7TVHNF3hodnaw0Kr3ZNhVNCeZvB7yYoL0An1m/AP/i10fxw==
X-Received: by 2002:a05:6402:2044:: with SMTP id bc4mr15635536edb.282.1621670270181;
        Sat, 22 May 2021 00:57:50 -0700 (PDT)
Received: from ?IPv6:2a01:c22:c073:5000:490:8a1c:a268:b6eb? (dynamic-2a01-0c22-c073-5000-0490-8a1c-a268-b6eb.c22.pool.telefonica.de. [2a01:c22:c073:5000:490:8a1c:a268:b6eb])
        by smtp.gmail.com with ESMTPSA id f11sm4881720ejd.101.2021.05.22.00.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 00:57:49 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] cyclictest: Add --mainaffinity=[CPUSET] option.
To:     John Kacur <jkacur@redhat.com>
Cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
References: <20210518083712.8237-1-schwenderjonathan@gmail.com>
 <20210518083712.8237-3-schwenderjonathan@gmail.com>
 <db548620-e1a6-c4cb-3e48-3247865148eb@redhat.com>
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
Message-ID: <ee07d8b0-756a-173c-e0de-10ebc1e8a420@gmail.com>
Date:   Sat, 22 May 2021 09:57:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <db548620-e1a6-c4cb-3e48-3247865148eb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Am 21.05.2021 um 22:24 schrieb John Kacur:
>
> On Tue, 18 May 2021, Jonathan Schwender wrote:
>
>> This allows the user to specify a separate cpuset for the main pid,
>> e.g. on a housekeeping CPU.
>> If --mainaffinity is not specified, but --affinity is, then the
>> current behaviour is preserved and the main thread is bound
>> to the cpuset specified by --affinity

>> @@ -1802,7 +1816,9 @@ int main(int argc, char **argv)
>>   	}
>>   
>>   	/* Restrict the main pid to the affinity specified by the user */
>> -	if (affinity_mask != NULL) {
>> +	if (main_affinity_mask != NULL) {
>> +		set_main_thread_affinity(main_affinity_mask);
> Am I missing something here, if there is a main_affinity_mask we set that
> but then skip over the affinity_mask. Don't we want to check both?

So the idea here is that if --mainaffinity is specified, then we set the 
affinity of  the main thread
to the specified value, _regardless_ of --affinity. E.g.:

cyclictest --affinity=1,2,3 --mainaffinity=0 [other options]

The intended behavior is that the main thread is bound to CPU 0, and the 
other threads to CPUs 1-3.
I don't see a reason why mainaffinity should be restricted to a subset 
of affinity. E.g., if for some reason
(e.g. cyclictest in a container) you spawn multiple cyclictest instances 
with non-overlapping affinity cpusets
but want to offload the main pids to a common CPU (e.g. CPU 0). 
Restricting mainaffinity to a subset of
affinity would mean that now every cyclictest instance also must spawn a 
measurement thread on CPU 0,
even if you aren't really interested in the latencies of the 
housekeeping CPU. Due to the (potentially) high priority of
the timer threads, they might even negatively influence isolated CPUs by 
delaying offloaded tasks.

Another way to look at it is that --mainaffinity (if present) overrides 
--affinity when determining the target affinity for the
main thread. The affinity for the measurement threads is not affected by 
this in any way.

>
>> +	} else if (affinity_mask != NULL) {
>>   		set_main_thread_affinity(affinity_mask);
>>   		if (verbose)
>>   			printf("Using %u cpus.\n",
>> -- 
>> 2.31.1
>>
>>
