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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72E2C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 07:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA69560FDA
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 07:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbhIMHTn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 03:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbhIMHTl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 03:19:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155B3C061574
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 00:18:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id bb10so5205295plb.2
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CHOzzHSA3egOJVj4sNEagHfXHvGXZaWMN/quP7NbfGs=;
        b=JJvXbsR5nhcfu4UtzTFG8qi8oMPG9/bkKHBblrc7I+fVInCM5O8apg4i/D9ugIBzkv
         aBqzXRjKhBY+srYsczA+E1PJBupfZiM95Xd89gbAil2S9yzBft61Hv8sHasohr7i0w/+
         zUQAxce0Wqp0yvjgi87tuCh0/ajHUizjH4Z8liSkdufPue+rR+XqSzZeo0eZzKITrc4d
         2ProDzCjHNqtHC1T1k959HIXMmzvCBBGh49/52wYjib7x632rh5t3yg2X29IjC8OqAU4
         h9Ce2HMVvku3gnMEXUCBR0vrbSFrovzOncI32WsPzRr82uWbA3t4peD66cZClrWU6daq
         hv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=CHOzzHSA3egOJVj4sNEagHfXHvGXZaWMN/quP7NbfGs=;
        b=ITUiWbhVKAOVmNALvnDsSEDJMO3IrRS9iMj9mG4XoRH0LENEEhriH2UMo9o7CeZVjT
         sYi4RjsMDP3Qzj3TCedUK6dLnOrECFS0UzTLTWwuy66ltxRFiFO5ub1LdZO8CfaVrXfq
         zh8RAyn3Ks+HwD9Y9hfIkfH5c2nUKQKtLRxm+zrrUjRu8xETOXpJgzweASX4iNMRdTa0
         HGeCHLbTTmjhzxtbL09lQ4r/75Rx6TpelAW52aWrKOhW/YYXuVuNzWQ2ZJLVQegbq3Bj
         DRmfnvpRzXP3VTD54TYsca7MX5LKpqZdNAqGC9qzWYFr9WbBes+SZbn+bhB8Xq4NFWTH
         IYVg==
X-Gm-Message-State: AOAM531sqEtdy8/jrxU/th+kGrJ5Dv9IzIdWEtRRA6D/qmSfSw7A8FeN
        PwWYNrrNEl7hiiQiwsA+iPI=
X-Google-Smtp-Source: ABdhPJzIpP/4NT6vQOlWoblCaOyNIUJEkoGSziCTyO9inIaupj/QrNnZtVSkSx2nZl8m3fRQ9wkxNw==
X-Received: by 2002:a17:902:b193:b029:11a:a179:453a with SMTP id s19-20020a170902b193b029011aa179453amr9148983plr.69.1631517505562;
        Mon, 13 Sep 2021 00:18:25 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id e2sm6012727pfn.141.2021.09.13.00.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:18:24 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/5] rteval: hackbench.py: Enable running on a system
 with low memory
References: <20210901080816.721731-1-punitagrawal@gmail.com>
        <20210901080816.721731-5-punitagrawal@gmail.com>
        <4273ee11-b665-53e1-57b6-1e8f443168a5@redhat.com>
Date:   Mon, 13 Sep 2021 16:18:21 +0900
In-Reply-To: <4273ee11-b665-53e1-57b6-1e8f443168a5@redhat.com> (John Kacur's
        message of "Thu, 9 Sep 2021 08:46:11 -0400 (EDT)")
Message-ID: <8735q99c5e.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

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
>
> I'm not sure that I can accept this. The number isn't entirely arbitrary, 
> it's based on verifying machines as realtime capable for customers, in 
> which case I'd rather it fails early.

I think there's a misunderstanding. The above check only prevents the
hackbench workload from running - which takes ~2-3MB in the default
configuration on the board I tested. rteval (along with cyclictest,
kcompile and other workloads) executes without any issues.

In terms of memory requirements for real time systems, I am not sure
there is a single number that is valid across all applications or
systems. Any such requirement only manages to alienate certain class of
rteval users. I thought a warning was a good compromise.

I am hoping you will reconsider the need to introduce a user option for
this case.

> Maybe there is some other way to indicate that the user is okay with
> lower memory system, such as passing an --embedded flag or something
> of that nature?

If the above doesn't convince you, I will look to adding an option. How
about calling the option "--low-memory-system" to clearly state what it
enables. "Embedded" is not well-defined and hard to guess what it
relates to.
