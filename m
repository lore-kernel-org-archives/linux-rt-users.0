Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB5AC2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 08:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE68961090
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 08:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhEVIOy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 22 May 2021 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhEVIOy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 22 May 2021 04:14:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB97C061574
        for <linux-rt-users@vger.kernel.org>; Sat, 22 May 2021 01:13:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j10so8362529edw.8
        for <linux-rt-users@vger.kernel.org>; Sat, 22 May 2021 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Il0B/2o3T/2tW3emBvkHtbDVcdnJej6Dole0VqQwUnA=;
        b=H+DO7UPK5UmzTHOqL0f7sR98eoKRrzDS2hZrIfr1Mnm2ssk0rY0iI0geVOEnKctxRS
         J54/IOBMP6XQ0aiDzVltetDdy7zS/4eZa2Nt43Yx398kDAAxvjV+qf75eXfBDxLotreC
         AMY8rftPknJUeHlsApH8h0Ejsd7f+COxkLZmLPOWIOFkxVwf2qHBKZ58NMxc1qG3Nwg1
         BVLyX7Kk9IWzf0RH6Lh9S3Y1GA/iomUjxb6fwEHAqQQGScWPNfem52oFHb2uA9nblaSO
         NHjkpWJmzpkGROyC5t1t1bCC8ormdw27qa818NBgsZM1g3xn4z9MuumKJHbu34eMyN+B
         h/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Il0B/2o3T/2tW3emBvkHtbDVcdnJej6Dole0VqQwUnA=;
        b=oH7h5aXlv1dqos60RlP9padraxZuaG4bAwA3TxPA0UfbwJD/FV87UY6NpDGpe0rI0a
         /I+6ecn+NlKIXCoVMFa5FJizynayaQtRKqFvNwp4MzG33e78yDACx/oxtJu5B67yQcc+
         yyhmRRiFmT6dHk83ieQJxEidpmSznTW6eNklYL2TcJhWfc6HCKCWiVqwTzH6zqxxx78V
         aDeKcUUOTG1ATNSbNLn/Tpa7YOX0+5qtDQWisrUjeaLH+2M04LRmMlXhcJQNCXNFLnAL
         S7RZsebSzkvA4QCyFivgicq3aEht+T0bczfXeqc5HJONbQxRg+MUHx9tAtJRsxOzRb/T
         hsHA==
X-Gm-Message-State: AOAM532U+cObR/95rHB8baeNlgOyhI3neGlLNh/vRazEArY4Fan060F/
        HRhSWxJzHV15X6lJKNrSBtwrIRdb4BZ+PQ==
X-Google-Smtp-Source: ABdhPJyvLmP/KhN4sJO7o31yHVgC1XXAAEBTyEBrBHe4BcQjYOAUKO8NyaWYealLgAekK+txv9EI/A==
X-Received: by 2002:a05:6402:3512:: with SMTP id b18mr13237022edd.245.1621671207938;
        Sat, 22 May 2021 01:13:27 -0700 (PDT)
Received: from ?IPv6:2a01:c22:c073:5000:490:8a1c:a268:b6eb? (dynamic-2a01-0c22-c073-5000-0490-8a1c-a268-b6eb.c22.pool.telefonica.de. [2a01:c22:c073:5000:490:8a1c:a268:b6eb])
        by smtp.gmail.com with ESMTPSA id by20sm4962062ejc.74.2021.05.22.01.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 01:13:27 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] cyclictest: Add --mainaffinity=[CPUSET] option.
To:     Daniel Wagner <wagi@monom.org>
Cc:     jkacur@redhat.com, williams@redhat.com,
        linux-rt-users@vger.kernel.org
References: <20210518083712.8237-1-schwenderjonathan@gmail.com>
 <20210518083712.8237-3-schwenderjonathan@gmail.com>
 <20210519155547.mdukzibjnaepqnq3@beryllium.lan>
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
Message-ID: <4c2dbe5b-2026-e395-c1f9-4e4e8ed97afb@gmail.com>
Date:   Sat, 22 May 2021 10:13:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519155547.mdukzibjnaepqnq3@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Daniel,

Am 19.05.2021 um 17:55 schrieb Daniel Wagner:
>
>> +	       "         --mainaffinity=[CPUSET]  Run the main thread on CPU #N. This only affects\n"
>> +	       "                           the main thread and not the measurement threads\n"
> The main thread is allowed to run on any CPU which CPUSET specifies. CPU
> #N does not really make sense.
>
> While at it, please update man page accordingly.
Thanks for catching this. I'll include it in the next iteration.
> Thanks,
> Daniel


Regards,

Jonathan
