Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F31EC433E6
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 23:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DFB723B51
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 23:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbhAVX1z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 18:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbhAVX1u (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Jan 2021 18:27:50 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F50C06178B
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jan 2021 15:27:09 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id z22so5452413qto.7
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jan 2021 15:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=liafwCAjt92iLA4cLgj5Tjx7sOKTgC3IwoI04FloCKI=;
        b=iGc0H6d2p8BCYnM9KQwFjiX/uQynQzBAGE3ye7jCy2YsFwTARZCQhl5c3zudx2cOhU
         Fi2lnBaMCyeDXVeu+kHlxoShLfnxTO5aeU4fCxgIrtaraNIKzCkYaXqCGwQbJ/uHVSwp
         DDYIF8scxKAGW9tTA+UlygNjW+tWZn6J4lD6vmH81IemXo6RuduKexAhNEsQ/MaZw/Rd
         ZyRcECbTVgKQfxzkxKu6P44Y8XKgOKs8Fe2ZOIeFuwD4O596CTfwtgsJY1SsuGyQwe+R
         wRmL5LkkXSfru/ET2EPqdyLNrIHX248U30RyZLq60BGwbkWOoBlLRMjGBOnRMKUa0WKP
         zKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=liafwCAjt92iLA4cLgj5Tjx7sOKTgC3IwoI04FloCKI=;
        b=taqRrw/3RoNTPX/XdsxkAHFeMrvotMDFuSXHIZA6262pbuYc5yB8Cp9a/eNBjlCYuP
         5DEKBNigAUVbbmgJg1vmugAeGGWAdLYWsLVRiiUTUaUpjx7Q+nkCRxZ1e6mXdH1jrfR0
         vTElliGR+5TYc/c0WKA/BbFklsC03fEf4PP/S0w+Q9NPUO6Env9UL8Vzzo02NktDKzjb
         Ef15jpiOmXOZTutYFhYRinW9aHCihB+5tOeamJn8n7dkCDXX27N5nRLGXWYe3F2smspx
         aJG82IFb7itoVGkx/4xyPFl99kC8cqZMcxlx6NRbFqEIIL11JzvcScgfXzLlNbDPjJQe
         4Jjw==
X-Gm-Message-State: AOAM530itCF5yaB2XxSMK2hs8qjCgdAaaQH0MWRpa4DUrUKc/G+o33Yu
        P8nIgsw0jnIhs8Er0viakxs=
X-Google-Smtp-Source: ABdhPJz1c0lNbmyP08DLXVAhuXWBHtTKk3CBDgr87QyDWupz65hu6/vz63swJ8qLoBvJmx7FMBRk3A==
X-Received: by 2002:ac8:4c82:: with SMTP id j2mr178599qtv.40.1611358028964;
        Fri, 22 Jan 2021 15:27:08 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id n139sm2810992qke.89.2021.01.22.15.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 15:27:08 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 22 Jan 2021 18:27:00 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
cc:     binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>,
        dwagner@suse.de, linux-rt-users@vger.kernel.org
Subject: Re: Some issues running rteval on arm64, arm and i386
In-Reply-To: <877doa1uwx.fsf@kokedama.swc.toshiba.co.jp>
Message-ID: <f4fac09b-dd20-3949-87e1-6855b0cec521@redhat.com>
References: <877doa1uwx.fsf@kokedama.swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 18 Jan 2021, Punit Agrawal wrote:

> Hi John,
> 
> We ran into a few issues when trying to run rteval on arm64, arm and
> i386.
> 
> A few of the assumptions in rteval don't hold true on these systems.
> 
>     1. On arm64, there is no 'model name' in /proc/cpuinfo. See attached
>        sample output from qemu arm64. I verified the same behaviour on
>        an arm64 board we have as well.
> 
>     2. Also, the build target for the kernel on arm64 is "Image" of
>        "bzImage". Rather than use different targets per-architecture it
>        maybe better to drop it all together. Do you see any downsides?
> 
> The attached patches[1][2] gets things moving with regards to Issues 1
> and 2 locally but I am not sure that's the best solution - especially
> for "cpuinfo".
> 
>     3. Both arm and i386 do not provide "numa" nodes in sysfs. This
>        causes rteval to complain "No valid nodes found in
>        /sys/devices/system/node"
> 
>        Is this requirement planned to be relaxed - it'll be really
>        useful to be able to use rteval on these architectures.
> 
> Thanks,
> Punit
> 
> 

In the past we targetted x86_64 only with rteval, but I definitely am 
interested in patches that would make it work on other architectures where 
the rt-kernel runs.

Could you resend the patches inline in separate mails, as you would when
sending patches for the linux kernel? The reason for this is it makes it
easier to comment on the code.

Thanks

John
