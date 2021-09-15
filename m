Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB84C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 01:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FEB61216
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 01:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhIOBx0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 21:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbhIOBxZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 21:53:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB327C061574
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 18:52:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id m26so1242342pff.3
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 18:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=01FvIfDnfp4Qt6ZhOAr3vY43RA9kUgYyvMbS3mU5Soc=;
        b=TSDN+8hmTWYaExTwTm0R3eT5MY271KnXhS0Uw0p95YhMq4geQTgcpLnB42vFhJrY5l
         rnlxnrlVmEJv+BuKzWMdYvF5DXD7fKyi8VYtocHU/ux+y8xP3Kh45W0eTnPjRzJwWMqI
         qAI7C9qrrXOGyvUxmfi1P4vskSUDnzwNiWyzxcD+i2B42qsjsaxXAU1A9bf/iipsK6uG
         pvJqIx4mGhqwcxQ0VUFtDkXy2SO+rmEsKX1W2kamg7rJTxRN2baKagjO7vyIkEWKDOkH
         agNmxUAzy+zIFJc8RbyJmvS5c8VkvNFK8o6Uwdj7tUF1xu0iwvTY8hQd+HZU5yso29pI
         V+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=01FvIfDnfp4Qt6ZhOAr3vY43RA9kUgYyvMbS3mU5Soc=;
        b=5mNdkE67SsrmW0rHnSNzZkSKi3aXVFkeJ9b9YwwkTPfbCF0vq+pBtnwIBMytlYUqWD
         RMyUbJTc47rgrv5L5gVoX31v/gQtpDePvcXoYiB2KfWue9UTjwuzbl5Vk/fLAH37VY4j
         sOJvsDUwnJ57ngSEpgBpJOvzQkZvWkeeNaPKpb7HD04e5yuF3HMtLLV8BoeWiU8bys4S
         9IqD7Lo7moITaazUKlQXl7EP4iIiIgRQRcO+IjsKUDYCY1qlR8koVKGs5J1xjGw/vpD0
         BL+B3ajAHjhqgCSi3yvEpTZIHLhYFQ2fFSVTVBV0UJ/L13TRci0O07z00l5sr3rrh8l5
         atTA==
X-Gm-Message-State: AOAM533DZxI9BH8DS9Z6XOge9GWUNeT2SyMOCn4LlJrymYfepQiD6kD/
        j2vJwjVs+Lz2MJ/eXX5pLHi9/RcOurv78w==
X-Google-Smtp-Source: ABdhPJzPriQUcvfP3MjXy8fjVufoJXIDDTiZK5XMiTtLe67EN1m7NwQeRyDs1LU0rcjGm390Ou6ftQ==
X-Received: by 2002:a05:6a00:244f:b0:404:fa55:c1a with SMTP id d15-20020a056a00244f00b00404fa550c1amr7741407pfj.42.1631670727286;
        Tue, 14 Sep 2021 18:52:07 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id 19sm11861423pfh.12.2021.09.14.18.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 18:52:06 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     nsaenzju@redhat.com
Cc:     jkacur@redhat.com, Peter Xu <peterx@redhat.com>,
        linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH v2 2/3] oslat: Add aarch64 support
References: <20210913083908.48408-1-nsaenzju@redhat.com>
        <20210913083908.48408-2-nsaenzju@redhat.com> <87ee9r9b5e.fsf@stealth>
        <fe15dafd9a6b6ee0d7f8a9f53e9acb6f4288046f.camel@redhat.com>
Date:   Wed, 15 Sep 2021 10:52:03 +0900
In-Reply-To: <fe15dafd9a6b6ee0d7f8a9f53e9acb6f4288046f.camel@redhat.com>
        (nsaenzju@redhat.com's message of "Tue, 14 Sep 2021 12:16:05 +0200")
Message-ID: <874kam8v24.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

nsaenzju@redhat.com writes:

> On Tue, 2021-09-14 at 10:52 +0900, Punit Agrawal wrote:
>> Hi Nicolas,
>> 
>> Apologies for the late comment. I just caught up with the thread.
>
> No worries, thanks for the input!
>
> [...]
>
>> > +static inline void frc(uint64_t *pval)
>> > +{
>> > +	/*
>> > +	 * This isb() is required to prevent that the counter value
>> > +	 * is speculated.
>> > +	 */
>> > +	__asm__ __volatile__("isb" : : : "memory");
>> > +	__asm__ __volatile__("mrs %0, cntvct_el0" : "=r" (*pval) :: "memory");
>> > +
>> 
>> Although the isb() ensures completion of instructions before the counter
>> is read, I think there is still the problem of speculative execution of
>> instructions after the counter read being moved forward. See the
>> examples in Arm ARM DDI 0487F.b Section D11.2.2 "The Virtual counter"
>> 
>> So from my understanding the problem would be something like below -
>> 
>> isb()
>> ...  <-  speculatively executed instructions from after the counter read
>> mrs %0, cntvct_el0
>> 
>> This would skew the counter value to a later point than what is intended
>> - a following isb() would address the issue.
>
> For the record, here's what the Arm ARM states:
>
>   Accesses to memory appearing in program order after the read of the counter
>   are executed before the counter has been read. [...]
>
>   To ensure that a memory access only occurs after a read of the counter, the
>   following sequence should be used:
>
>     MRS Xn, CNTVCT_EL0
>     ISB
>     LDR Xa, [Xb] ; this load will be executed after the timer has been read"
>
> As stated in the commit description, I made sure the program logic can't suffer
> from this. I hadn't thought of the timing angle though. I doubt we'll see any
> difference, given we have a 1us granularity, but I don't mind adding it for the
> sake of correctness.

Thanks - indeed that's the part I was referring to. Indeed the impact
will likely be low or none here but thought I'd mention the issue since
I noticed it while going through the patch.

Punit

[...]

