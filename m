Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F99C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 01:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CC161214
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 01:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhIOB4R (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 21:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbhIOB4P (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 21:56:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9E8C061574
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 18:54:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j16so1254131pfc.2
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 18:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7SEfNq/1ZSod8/bM2XXGRkzh4K4hC4LAcsJ/gBayEeQ=;
        b=X8/u0GEhevmKks08n/ufjoXSK4eMKh5AzqKy1Bmll38nfhV9URlBjcpOBB32a0J+FQ
         ziOxraOTpOZ4IhSNx4gWa76kNOsuBqI44AZRbzzhmYaeTrMoRePW4HXg0sL4TRmmzHl8
         g4/YU4jp4QotMb1UZaJJSB6rsLFq47ZrzW8JLo8/rU8FWwaMTA52bwVm9Nnktn7MP1T8
         bNiELB+OZgA1BZW+FYrRlc1YBa/BZRHYz1d9xrjaFc+EnBMHX1ctSPR3boggEuGMDh+U
         WJzctBtEAjY1NhJO2bXkKv8wAXOXX/Ce1aGwqepZyunDfZ1E2iRaJ3HTYFQ8pJkPFUfE
         wpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=7SEfNq/1ZSod8/bM2XXGRkzh4K4hC4LAcsJ/gBayEeQ=;
        b=uxG8FDIzHGLUATW7XA64CU6AzX/P6JXedEWQHU/cSrS60iqMqDMy3VO9KkRAMm3MRa
         w1N6MhvY3cPy6OCLqyLxu6udJslaNMEcues869waPGDueZjquXOhHhLw5u+EUzajTuLe
         7/s8vKmx/Cm83JWG3pyzN+/8mx5EtcfgeXAho1Ft2Kwf5h7DFV96b46EMFXUMp3pjlfv
         /pUjNDJUKSGPbfVubWSvV12i8RKRZNttK7Kazr4IOyc5kOwjcpYEgWcXjOB1YObjBcem
         D3RW+6F075cZ7BfmDC1ZXy0/9dpAl4FH5PpUnZMza5pVFvGwFzaVJ3wZayZD1EJLRmXl
         SUKw==
X-Gm-Message-State: AOAM533IUCHv16WrpG9Rn2pNvthT98duMhHgG7hnQ7S5a3T1LQwbeYE/
        XQd/TaIsjmm5Mg+WUr/lWpw=
X-Google-Smtp-Source: ABdhPJyInu9XyhoCyMSMGQinryMsKvp4BNOLClmDHAKZWoI0D7zO1hYjeBf0pImShT+wtNeP7qpz8A==
X-Received: by 2002:a63:5902:: with SMTP id n2mr18302572pgb.305.1631670897387;
        Tue, 14 Sep 2021 18:54:57 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id v8sm2625111pjh.24.2021.09.14.18.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 18:54:56 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/5] rteval: hackbench.py: Enable running on a system
 with low memory
References: <20210901080816.721731-1-punitagrawal@gmail.com>
        <20210901080816.721731-5-punitagrawal@gmail.com>
        <64b0ee4c-41d4-9c76-98cf-b2459bdf214@redhat.com>
Date:   Wed, 15 Sep 2021 10:54:54 +0900
In-Reply-To: <64b0ee4c-41d4-9c76-98cf-b2459bdf214@redhat.com> (John Kacur's
        message of "Tue, 14 Sep 2021 14:32:36 -0400 (EDT)")
Message-ID: <87zgse7gcx.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

> On Wed, 1 Sep 2021, Punit Agrawal wrote:
>
>> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> 
>> The hackbench workload refues to run on RockPro64, a hexacore 64bit
>> Arm board with 4GB memory, complaining about insufficient memory
>> per-core.
>> 
>> On further investigation, it turns out that workload is using an
>> arbitrary limit of 0.75 GB/core but will quite happily run on much
>> lower lower memory systems.
>> 
>> Instead of preventing execution, convert the info message to a warning
>> when the memory is lower than expected but continue execution. This
>> should enable the workload to be used on a wider range of systems.
>> 
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> ---
>>  rteval/modules/loads/hackbench.py | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
>> index 3b692070e9d9..ab028c495d8b 100644
>> --- a/rteval/modules/loads/hackbench.py
>> +++ b/rteval/modules/loads/hackbench.py
>> @@ -55,9 +55,8 @@ class Hackbench(CommandLineLoad):
>>          if ratio >= 0.75:
>>              mult = float(self._cfg.setdefault('jobspercore', 2))
>>          else:
>> -            self._log(Log.INFO, "Low memory system (%f GB/core)! Not running" % ratio)
>> +            self._log(Log.WARN, "Low memory system (%f GB/core)!" % ratio)
>>              mult = 0
>> -            self._donotrun = True
>>  
>>          sysTop = SysTopology()
>>          # get the number of nodes
>> -- 
>> 2.32.0
>> 
>> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks for applying the patches - both from here and the misc-fixes. I
will address the comments on the cyclictest set and resend them.

