Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF627C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 07:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B672260EB4
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 07:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhJOIA3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 04:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhJOIA3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Oct 2021 04:00:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD88C061570
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Oct 2021 00:58:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e10so1009265plh.8
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Oct 2021 00:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xHjbbj3F24apFPGpWbEX8cXvZcQMinWPfOA2OFU/6Uk=;
        b=asPXvd0dzGYIy1rHBirVW48P8qN+YsW4Zy1uUdNfYLa6Ncpm2aadJZT7Az2jm2ODuG
         CyegQS0zBqmM7uyWdDICUwMU5B+3UmkEdKF+HnNgYrBTSaKFJ4Pg2DY20KHiP/qjdZK8
         gLMbpIJoAMOMwy+PN/ltVyvRqj705JnDKVUVMnz7V8JvxzfgKPiSXj9XdaG/4QesnaFn
         vlGH8cW866CUEGik/0u1nWqEZwzS/QBlzMZgHdclH96C08IQuGCEgDohcNtAR5f38BGx
         qBGGtWg2DWQIrnVht5o6HQp70+sLGptg+GI7Pw4s0Cmn9V9txdPKFJpbUfRv4C/VyAQT
         8yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=xHjbbj3F24apFPGpWbEX8cXvZcQMinWPfOA2OFU/6Uk=;
        b=HEe9aFRE41sycWixliO887y3xQmENw3ls/oY++p9gTt4XcXy/G/vWU2km74lCKoJjV
         9jI+wUGWTG3wV6id+mIafauelI2Wc0p1DXgQTgU7WrQIcUYpBB8yeM+01ubn5WT4/ESn
         TAY1TDc+XAVCmrEj99AallPeUmGEnRKwco1d+5xldDuJRrxdb/o+5OH+FA9abwvlQF/g
         HOlduUiOhep9EiF0Ic99syw9wQS3PjgzR15yOqpZwa830gbSHuDaXATHW2fyY+oKYDnf
         BOgftXTxr3A3fJRSP4fAVlypZTznmyFWPKZQQu8OSX5x01YBXGnvR/Y7QtJ6YsD8FcEh
         elgQ==
X-Gm-Message-State: AOAM530L12vXBXoB7SzgttNwNAgTOdOxFNP0MyBhiMJwbsYlRYYnseQO
        Ag6hUtsBStm12q0a35JKBo0=
X-Google-Smtp-Source: ABdhPJwqtAbsG1PS0AMS79H+AL7e4q+ZH8QA4rMwqMTEIWSrDbkjwDMA/v6oi3FksM6HGGhTvFRV9Q==
X-Received: by 2002:a17:90a:290b:: with SMTP id g11mr25756844pjd.35.1634284702927;
        Fri, 15 Oct 2021 00:58:22 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id y3sm4401146pjg.7.2021.10.15.00.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 00:58:22 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Daniel Wagner <wagi@monom.org>
Cc:     jkacur@redhat.com, Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [RFC 7/7] rt-tests: cyclictest: Add support to report standard
 deviation
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
        <20211014071247.4165329-8-punitagrawal@gmail.com>
        <20211014115043.s3zf5p3s7dglvcjb@carbon.lan>
Date:   Fri, 15 Oct 2021 16:58:19 +0900
In-Reply-To: <20211014115043.s3zf5p3s7dglvcjb@carbon.lan> (Daniel Wagner's
        message of "Thu, 14 Oct 2021 13:50:43 +0200")
Message-ID: <87r1cm1zz8.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Daniel Wagner <wagi@monom.org> writes:

> Hi Punit,
>
> On Thu, Oct 14, 2021 at 04:12:47PM +0900, Punit Agrawal wrote:
>> @@ -1781,6 +1810,7 @@ static void write_stats(FILE *f, void *data)
>>  		fprintf(f, "      \"min\": %ld,\n", s->min);
>>  		fprintf(f, "      \"max\": %ld,\n", s->max);
>>  		fprintf(f, "      \"avg\": %.2f,\n", s->avg);
>> +		fprintf(f, "      \"stddev\": %.2f,\n", calc_stddev(s));
>>  		fprintf(f, "      \"cpu\": %d,\n", par[i]->cpu);
>>  		fprintf(f, "      \"node\": %d\n", par[i]->node);
>>  		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
>
> I think in this case you should also increase the version number of the
> JSON file.

Sure, I can bump up the version to 1.1 - minor update as it's adding a
new field rather than changing existing ones. Or "2" if that is
preferred.

Taking a closer look, the rt_write_json() helper, that outputs the
version, is shared with other tools. Bumping the version will bump it up
for all of them - would that be OK?

> And while at it, I'd love to see the same stats
> fixes/extension for the other tools, not just cyclictest.

I can look at adding support for standard deviation to the other tools
if there's interest once the cyclictest changes have been merged.

Thanks for taking a look.

Punit
