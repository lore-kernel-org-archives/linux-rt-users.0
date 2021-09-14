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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9A1C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 01:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D5F60E90
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 01:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhINBxf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 21:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhINBxe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 21:53:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15AEC061574
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 18:52:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so914916pjr.1
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 18:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TNmsox8QX6r1iagkUCKyZgQwGggW5HneIzPCzs3PhWY=;
        b=MQXq8EAomBHv4Xr2WcD4qc+zWw/9fPDDjzfYcuU9IyRLcWab80rqcWv21gh4JqNlYR
         17oK0uVaEAvPe0KavRcvB38VEs7A0mGFpcHTWLE4s4gk1ZpEI0eu3hb+dMa21GKJOXIs
         35OKMrNxSRMkVLXdEhwZ25exQx2Jn2Nc2MO4yB3Spif4C4jxQlOdonIXj35WgPeQf+53
         ex4glqKt+fa1Y9kQPBBHO1J7IbGtJmy5u5s2F9WRXtbMWdrmjwDl26R36iL4sOu61ayB
         GhZ3Ejmb/5uviyYoFzFVRCzqhtauf4vn2b4FRmO2/7YzyaBDCE+/EA4iKDp+3BTpfJgP
         1lGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=TNmsox8QX6r1iagkUCKyZgQwGggW5HneIzPCzs3PhWY=;
        b=QPFAWRuZW/VIwVhI/4ssDpptqjGXhm4g9beqwgh9MESZPCa6N2B+qGlMzEs/TRTj0W
         kWz7Y+tjIhRsJ5vUJ6TdGzXh01UI2m7Tp74SxMZ9SYTxhWgyA9gdabDLvuo/olgOwwoY
         gDBzVSGUw3tsVBIc4VaznbiH/GnKm8Ii+0OaiQ7vYUoCjzjJdbm9WUoXXiE/A5LSkdN5
         JCJwe7bXTFvjZ5/UCuEo5MjTHSBIYdSb6/YZB6GrGRlT7bvhACG3s9tuELsiPKJ/VUDd
         cLI+9Zl1s9hJEuZoAsvgCeNHGSdXztisDV4WTWn3xqgEXfz4SO5jRj/TJi+8RXWj41Jz
         OKOg==
X-Gm-Message-State: AOAM530/V6DLheHqa4MnUht0s8JMjc6ExpeSvwvhfUntqLn8YSsr509A
        Mh2/bu1/9Nxy0dCFrKiEHXogiasJGfkkFg==
X-Google-Smtp-Source: ABdhPJyhAqObuzSazLIZh/2NoBv6yYJ/liBN71t1KLYHNwQgMUjK7yx67CUfz8qJt9AC0vo5YDquIg==
X-Received: by 2002:a17:902:680a:b0:139:edc9:ed4c with SMTP id h10-20020a170902680a00b00139edc9ed4cmr12848053plk.5.1631584337367;
        Mon, 13 Sep 2021 18:52:17 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id a26sm9630239pgm.87.2021.09.13.18.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:52:16 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, peterx@redhat.com,
        williams@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH v2 2/3] oslat: Add aarch64 support
References: <20210913083908.48408-1-nsaenzju@redhat.com>
        <20210913083908.48408-2-nsaenzju@redhat.com>
Date:   Tue, 14 Sep 2021 10:52:13 +0900
In-Reply-To: <20210913083908.48408-2-nsaenzju@redhat.com> (Nicolas Saenz
        Julienne's message of "Mon, 13 Sep 2021 10:39:07 +0200")
Message-ID: <87ee9r9b5e.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Nicolas,

Apologies for the late comment. I just caught up with the thread.

Nicolas Saenz Julienne <nsaenzju@redhat.com> writes:

> The callbacks are based on Linux's implementation:
>  - CNTVCT_EL0 provides direct access to the system virtual timer[1].
>  - 'yield' serves as a CPU hint with similar semantics as x86's
>    'pause'[2].
>
> In contrast with the kernel's implementation, there isn't a need for
> isb() after reading CNTVCT_EL0,  this is only needed in-kernel as the
> register read has to be ordered with a subsequent locking operation.
>
> [1] See Linux's '__arch_get_hw_counter()' in arch/arm64/include/asm/vdso/gettimeofday.h
> [2] See Linux's 1baa82f4803 ("arm64: Implement cpu_relax as yield").
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> --
>
> Changes since v1:
>  - Code cleanup
>  - Add compiler barriers
>
>  src/oslat/oslat.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 33cccd3..c90ec1a 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -71,6 +71,19 @@ static inline void frc(uint64_t *pval)
>  {
>  	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
>  }
> +# elif defined(__aarch64__)
> +#  define relax()          __asm__ __volatile("yield" : : : "memory")
> +
> +static inline void frc(uint64_t *pval)
> +{
> +	/*
> +	 * This isb() is required to prevent that the counter value
> +	 * is speculated.
> +	 */
> +	__asm__ __volatile__("isb" : : : "memory");
> +	__asm__ __volatile__("mrs %0, cntvct_el0" : "=r" (*pval) :: "memory");
> +

Although the isb() ensures completion of instructions before the counter
is read, I think there is still the problem of speculative execution of
instructions after the counter read being moved forward. See the
examples in Arm ARM DDI 0487F.b Section D11.2.2 "The Virtual counter"

So from my understanding the problem would be something like below -

isb()
...  <-  speculatively executed instructions from after the counter read
mrs %0, cntvct_el0

This would skew the counter value to a later point than what is intended
- a following isb() would address the issue.

> +}
>  # else
>  #  define relax()          do { } while (0)
>  #  define frc(x)
