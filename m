Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE11C2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 07:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394B9611AD
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 07:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhEVHgs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 22 May 2021 03:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhEVHgs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 22 May 2021 03:36:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB169C061574
        for <linux-rt-users@vger.kernel.org>; Sat, 22 May 2021 00:35:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lg14so33697225ejb.9
        for <linux-rt-users@vger.kernel.org>; Sat, 22 May 2021 00:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=hl1nPPFA6K0po6uDOrmDj7Q3i8M8O3kwzngmZzDI1Ao=;
        b=NhaHiUzRZLeY+3x7Tv2AEhOIbFk8ZpRSTcYAM7yDU0I36U4vfnxBYVt4R3DOK9C3K6
         MH0oLTDt+lZq7v9LPmSxZdjiIhGHYQjVvZeqJcvsiDEXKlUVte6EtXgnLdtWDeglLd6D
         Jcye2QtTmn0I2QIwnJv/IIkOMC1ETFR6seK0NvyntvL/JiAiNeKy5GKpiZJRwgaoybUl
         UXz4Zyyi26xF/sr233HJf8a7/xJTyMKaePH7RowQHdXzRD3QlacFxfLBe6wqz3hmcPAk
         UvYA0CwNpn9Qvu9/2mPsXa0qp8j9lfgf9IqqVRJ6giWNsoSMFeL1AQWSvKTFzSiwmy9G
         Q3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=hl1nPPFA6K0po6uDOrmDj7Q3i8M8O3kwzngmZzDI1Ao=;
        b=Q4nbgAR1C/FHzR3/1WlB0JshZMlK8ZLGKqs1akeWxnrNVTEB7B076uhNsGcck2uK4Y
         5jYzgvtSNFsSkRPf3mdPeglWHI6ph1qLSMhHmm889NtpjlxmCkwxv0kEeGUSj83ufLnH
         Ud07g23CAHxG2Ao9ldZz3ZwfGxRQw5AgSfwSAa+tGtk9lzHI6eQYmLqOIztrPsAYLe1A
         x9PJEfG9zt7BT8686L3oQoz7nRWXFSRNaRpbFM9NbGgBdJ+8ybBjQHT7usswzaYxDYyv
         ZZkWvJUIKPoR4iYdXtFmP5T/X0CJ4SEaS/npBV8omvQgctBZIqNoVQHMjKzdkzJhH1f5
         9sIw==
X-Gm-Message-State: AOAM533TWdiKQ2YJY/p4vfG7jT1B+fhGWdY+LwgPGb7zmUjDt7Qsgxoa
        esM3gBJZs1a+mjG/O2nspLcWjHOOliw=
X-Google-Smtp-Source: ABdhPJxxqLcyCmFfZzxO4bHj/fZqA9ATNaL11X4u+2rVb90MNbjAiec4hF696e3xrH0sITD3hdf12g==
X-Received: by 2002:a17:906:7e0f:: with SMTP id e15mr13548601ejr.398.1621668921642;
        Sat, 22 May 2021 00:35:21 -0700 (PDT)
Received: from ?IPv6:2a01:c22:c073:5000:490:8a1c:a268:b6eb? (dynamic-2a01-0c22-c073-5000-0490-8a1c-a268-b6eb.c22.pool.telefonica.de. [2a01:c22:c073:5000:490:8a1c:a268:b6eb])
        by smtp.gmail.com with ESMTPSA id i2sm5685195edc.96.2021.05.22.00.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 00:35:21 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] cyclictest: Move main pid setaffinity handling
 into a function
To:     John Kacur <jkacur@redhat.com>
Cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
References: <20210518083712.8237-1-schwenderjonathan@gmail.com>
 <20210518083712.8237-2-schwenderjonathan@gmail.com>
 <755ca9b1-b3c3-806f-95e0-b12a87d9448d@redhat.com>
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
Message-ID: <b0da72ea-b7d3-5212-e042-cc9e12fa7e8d@gmail.com>
Date:   Sat, 22 May 2021 09:35:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <755ca9b1-b3c3-806f-95e0-b12a87d9448d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Am 21.05.2021 um 22:19 schrieb John Kacur:
> How about set_thread_affinity() since you want to use the function
> for the main thread plus other threads.
>
>> +static void set_main_thread_affinity(struct bitmask *cpumask)
>> +{
>> +	int res;
>> +
>> +	errno = 0;
>> +	res = numa_sched_setaffinity(getpid(), cpumask);
>> +	if (res != 0)
>> +		warn("Couldn't setaffinity in main thread: %s\n",
>> +		     strerror(errno));
>> +}
>> +
>>   

Actually, I only intended to use this for the main thread.
I didn't touch the affinity setting of the timerthreads (and don't see a 
need to).

I'm not familiar with the whole cyclictest code and all options. Did you 
have
any specific threads in mind that also use numa_sched_setaffinity() and 
could
use this function?

Maybe you got that impression from the previous v3 iteration, where I 
moved the functionality
to rt_numa and added a parameter for the pid/tid. My motivation there 
was mainly,
that if I'm moving it into a library, then I should probably add a 
parameter for the pid to the function
in case someone has a usecase for that.


