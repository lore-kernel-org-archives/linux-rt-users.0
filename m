Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6594DC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 00:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452AA60F93
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 00:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344845AbhJRAaT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 17 Oct 2021 20:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242859AbhJRAaT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 17 Oct 2021 20:30:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDDDC06161C
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Oct 2021 17:28:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so13253280pjb.5
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Oct 2021 17:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yJDAQNrAyCzgiFxNgAjF6us5D3TY4nT4w2SCw9rydO4=;
        b=oJahespz38LVlBIcWkjtJkYGmBSEwO/g9wLc1/6VRCDdo6UhLIJSITs/Kczj2vNpL6
         fVTtUoU0QGmxlZ4uP+GJjeeiE5AcQN+PpCUs1tyNVTVXDhtV1Xo5WrGVFzZi2Ejs5bUQ
         SNZF7pLF2aw8omwiyK9NtfAaRorkN6ny7rObzFPjDoGPINjvNDTUBOHy0JdvnyFouAUG
         JgnhVviGt1w6W6OvTUSjnmtj+EvQ/5+CW7Hq2lwqaukuytfMKhM2M5zBOfjUo5TkrjNE
         QxDyAjkcc6M+WlAiG4kz1YCTi9aQSHhFhelQP7+8pNZWn2LOecNuHR8TLnpswxUiPkmw
         4LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=yJDAQNrAyCzgiFxNgAjF6us5D3TY4nT4w2SCw9rydO4=;
        b=jdcp6HhZ6ur7avc3Dd+UG5zzrCYKPLQKfQDmV7XSi0AtPlQ/aDmz0RgwmREpdZUn93
         jqcdkrWwacg5aEgWM7yN08N6SU/HuuM7ckyNCehrr2kVNGJy19oHJHztFmpTmKICzsE7
         3nhkw84/nYCF3MAMzMOKZfwSTraigFwIjbaj9ZkZuZgD05YNA/cNqFg90JxO+dlbLG7x
         gbyzSOO8pXt1akvHeX36i69CPS1HPMP4RejGsWoA+TIyBNvZJ9sfPpmtRAyTFJd05LYs
         Lz99sAsuWuk5ENdz3Olwq8e+Ckh/dScqXl+pL4vhXin4Y/ITVgDH0+1ri3oTqGjQAinU
         7e8g==
X-Gm-Message-State: AOAM531TraXW98yMUWeIVmQfVKbGSmHLjJ01uVF5xAH1al1CQ+SFhpPM
        LWJYvKOhpaAuwIfFuNY7i7u15hoeg7w=
X-Google-Smtp-Source: ABdhPJyWFkya4unP5Z3OGMvahSbihosA1VStN7TmPGm/j7vIy77Zq7Cd+x2zQE0p5xtzSnqGUjmrDA==
X-Received: by 2002:a17:90b:17d2:: with SMTP id me18mr7695284pjb.132.1634516888394;
        Sun, 17 Oct 2021 17:28:08 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id u4sm11401582pfh.147.2021.10.17.17.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 17:28:07 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Joseph Salisbury <josephtsalisbury@gmail.com>
Cc:     jkacur@redhat.com, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC 0/7] rt-tests: cyclictest: Add support to report standard
 deviation
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
        <CAGHUO11me7hStnYpXTWs5DmDqKg8Y_sXAKFYaCToU5WZvfDm=g@mail.gmail.com>
Date:   Mon, 18 Oct 2021 09:28:05 +0900
In-Reply-To: <CAGHUO11me7hStnYpXTWs5DmDqKg8Y_sXAKFYaCToU5WZvfDm=g@mail.gmail.com>
        (Joseph Salisbury's message of "Fri, 15 Oct 2021 12:37:05 -0400")
Message-ID: <878ryr18iy.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Joseph,

Joseph Salisbury <josephtsalisbury@gmail.com> writes:

> On Thu, Oct 14, 2021 at 3:13 AM Punit Agrawal <punitagrawal@gmail.com> wrote:
>>
>> Hi,
>>
>> Standard deviation is an important measure to evaluate the latency
>> response of a real time system. It is calculated by downstream tools
>> such as rteval but the value cannot be correctly calculated when the
>> latency value exceeds the range of histogram.
>>
>> This series adds support to report the streaming standard deviation of
>> latencies to cyclictest. This approach avoids having to track all
>> latency values and adds minimal overhead (two additional doubles and
>> compute steps) to each iteration.
>>
>> In terms of patch organization, the first 5 patches are clean-ups that
>> were noticed in the course of developing the support for standard
>> deviation. It should be possible to apply them indepndently.
>>
>> Patch 6 converts the existing average calculation to a streaming
>> version. This running average value is needed for the standard
>> deviation.
>>
>> Patch 7 finally adds support for calculating standard deviation.
>>
>> The changes were verified by capturing the latency samples and
>> verifying the average and standard deviation with manual calculation.
>>
>> All feedback welcome.
>>
>> Thanks,
>> Punit
>>
>> Punit Agrawal (7):
>>   rt-tests: cyclictest: Drop unused defines
>>   rt-tests: cyclictest: Simplify duplicate initialization of "stop"
>>   rt-tests: cyclictest: Drop unnecessary variable "stopped"
>>   rt-tests: cyclictest: Drop unnecessary variable "bufsize"
>>   rt-tests: cyclictest: Move signal handler to avoid function
>>     declaration
>>   rt-tests: cyclictest: Use streaming algorithm to calculate averages
>>   rt-tests: cyclictest: Add support to report standard deviation
>>
>>  Makefile                    |   2 +-
>>  src/cyclictest/cyclictest.c | 149 +++++++++++++++++++++---------------
>>  2 files changed, 87 insertions(+), 64 deletions(-)
>>
>> --
>> 2.32.0
>>
>
> Hi Punit,
>
> Thanks for your contributions!
>
> I noticed there were no commit messages for patches 1 and 5.

If you look closely, patch 1 does have a commit log.

I missed adding a commit log for patch 5 - but the gist of it is to drop
function declarations when they are not required. In this case, this is
achieved by having the caller defined after all the callees have been
defined.

I'll add a log if the patch gets reposted.

Thanks for taking a look.

Punit

[...]

