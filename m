Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EBBC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Sep 2021 11:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1721D613A1
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Sep 2021 11:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbhIPLfw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbhIPLfw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Sep 2021 07:35:52 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB575C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2021 04:34:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c4so3633428pls.6
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2021 04:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mHSNxjRrgh7fnjDkhw1wG4HPYWB4KOTbO/4DIEtiFL0=;
        b=oyG6ch6ElD/xjbqN94FjE3B0JZiYvLSCCjMN9amiU8JULb9ynY42c+fLFslGphHuJF
         kFWAiaHiB7fr2oxK8fqnXU/z0meKZuHNK5aBB1LQyyeI2jD1WmTpzPPGPJbEb20Jx4hJ
         XnitQNRctbIxQCdaT1Gqcq9B0vaGwP1HqA8nMj52NrNvs0TqtofgQoNWgqSubM/QEaSn
         8DM6HKFgKmYiD/TPLJPNGKxapJ3NqCBxU5WgqFi81Lb8Ppa8bqfyUfSLoZwm+0LxORtU
         I6/heo7zWf4LJFDMKCCi2/KVz0a8Mtf+B7EDsVrcCmaULqh8DL9pwNq1u5MqLMw+UslD
         VEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=mHSNxjRrgh7fnjDkhw1wG4HPYWB4KOTbO/4DIEtiFL0=;
        b=tkfkxpbHal+kptazGRJYhgI+ph2R/O99Io247D7y/ToDivL8l5aqjPjkT15gkuExxI
         gBYPUiJilIPVxtuMudQdTlbDBmPrX0Dp5eGSee89CiTb/QBaYaXsrQOrjT3Pm5EvKE+A
         uLnhIOwIb28AJLpHfCOen2fc/ZqSnSQ4H6KeJMkHwgCW/uCwIp0eqs14tueQbD02yKpA
         emoV5DOO8mNoNbFqzalF6Nm5nCrKZ+ylpvtBVqdNjtZteILEbF95TVgjp9/jgwLxouJ0
         Bv5+YOIGlARYVHgEcyiL49iMnemo+WtI+iJoJNesH3y2A7+pglaJBaMPxPvRTPgiLqvs
         4rMQ==
X-Gm-Message-State: AOAM5331uWSHKyu5ASN/WA9+XH50jNhc7n+lJRRb/yI9iJC/p7W7b5iP
        BDooz5titkB/57tFni/MR8CyaAVp/m8=
X-Google-Smtp-Source: ABdhPJzuB/py8FSVT5xco7nMraIQbJN85ycARkfP8OsIKNArG2iwFiZv8OCq1zvk1KxIwso6pKvOGQ==
X-Received: by 2002:a17:90a:5b0d:: with SMTP id o13mr14384384pji.117.1631792071221;
        Thu, 16 Sep 2021 04:34:31 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id m18sm2657469pjq.32.2021.09.16.04.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 04:34:30 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/5] rteval: kernel.py: Add support for kthreads running
 with deadline policy
References: <20210901080816.721731-1-punitagrawal@gmail.com>
        <20210901080816.721731-4-punitagrawal@gmail.com>
        <3ec9f755-404c-88b4-8efb-a29fb18f392@redhat.com>
        <87v9326xd5.fsf@stealth>
        <3382122d-6381-c664-af6e-461f7b992be@redhat.com>
Date:   Thu, 16 Sep 2021 20:34:28 +0900
In-Reply-To: <3382122d-6381-c664-af6e-461f7b992be@redhat.com> (John Kacur's
        message of "Wed, 15 Sep 2021 08:17:08 -0400 (EDT)")
Message-ID: <87k0jg7nzv.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

> On Wed, 15 Sep 2021, Punit Agrawal wrote:
>
>> Hi John,
>> 
>> John Kacur <jkacur@redhat.com> writes:
>> 
>> > On Wed, 1 Sep 2021, Punit Agrawal wrote:
>> >
>> >> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> >> 
>> >> When running rteval on a system with kthreads running with "deadline"
>> >> policy, an exception is encountered when parsing the output of "ps".
>> >> 
>> >>     [DEBUG] cmd: /usr/bin/ps -eocommand,pid,policy,rtprio,comm
>> >>     Traceback (most recent call last):
>> >>     ...
>> >>       File "...rteval/rteval/sysinfo/kernel.py", line 60, in kernel_get_kthreads
>> >> 	ret_kthreads[v[0]] = {'policy' : policies[bytes.decode(v[1])],
>> >>       KeyError: 'DLN'
>> >> 
>> >> The kernel uses deadline policy for "schedutil" cpufreq governor
>> >> threads. Fix the crash in rteval by adding support for "deadline" to
>> >> the list of policies.
>> >> 
>> >> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> >> ---
>> >>  rteval/sysinfo/kernel.py | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> 
>> >> diff --git a/rteval/sysinfo/kernel.py b/rteval/sysinfo/kernel.py
>> >> index 97ad9402b13e..f2e9d72ac2ef 100644
>> >> --- a/rteval/sysinfo/kernel.py
>> >> +++ b/rteval/sysinfo/kernel.py
>> >> @@ -44,7 +44,7 @@ class KernelInfo:
>> >>  
>> >>  
>> >>      def kernel_get_kthreads(self):
>> >> -        policies = {'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'unknown'}
>> >> +        policies = {'DLN': 'deadline', 'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'unknown'}
>> >>          ret_kthreads = {}
>> >>          self.__log(Log.DEBUG, "getting kthread status")
>> >>          cmd = '%s -eocommand,pid,policy,rtprio,comm' % getcmdpath('ps')
>> >> -- 
>> >> 2.32.0
>> >> 
>> >> 
>> >
>> > Signed-off-by: John Kacur <jkacur@redhat.com>
>> 
>> It looks like this patch and the other one converting hackbench memory
>> check to a warning was missed when applying the rest of the series -
>> John, could you please pick these as well.
>> 
>> Thanks,
>> Punit
>> 
>
> I added the patch to support deadline policy, the other one had already 
> been added, I just hadn't pushed upstream yet, but I just did so, so go 
> ahead and pull.

Thanks, I see both the patches now.
