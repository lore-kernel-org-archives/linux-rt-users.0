Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EB1C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Jul 2022 11:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiGLLOO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiGLLNw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Jul 2022 07:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02AC4B1CFA
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Jul 2022 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657624388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slHwrhsSOL07LWoU4O4a8Klr2iEqMdZCY2kE3rkbshs=;
        b=BFlszsJzRGWuN3pGa6VOfNTYJE9HzIMiNi97kK5Gtp+1SUCUUDRkpNzo9ffHBjy0szr9Lx
        3WCKF1+48BLReFSuU2wTaK82mS15dz0DJQXSWYFJu2wL+UPoBrROzmoL48Gln8kbhVXdgM
        91LoyBZxNuf+7rPnzwS+mUomWi16rgY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-zcRsopxtPEeSCWTkQiVSJA-1; Tue, 12 Jul 2022 07:13:06 -0400
X-MC-Unique: zcRsopxtPEeSCWTkQiVSJA-1
Received: by mail-wm1-f71.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so3633714wmp.8
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Jul 2022 04:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=slHwrhsSOL07LWoU4O4a8Klr2iEqMdZCY2kE3rkbshs=;
        b=3MF3HYNSbv8D5lkK1HIZzAiIwKBKYWXLzqp3ZrXURlPzV4JbZW3DI2ntKQIhgcffkS
         SOkJTE5L9X8hs7iw/14cfWqAUdIb3jwRdGlFWrNlTfrhX2fHJdvknwkOWTiFCcp6hpVK
         PBCNW0gbLZTapAvifB/xAMEIIGf6CPdUetMmIopx3vIGHoDeolQkOg7FUdPSaye40gb2
         JBqU7vvk/aJHnlWcC6LNpMzpeHqqccOt9B9A8qY4iLAMrsihRzMebUb6s3AMtQVU/ywB
         0sO7EwL23WW9Rmnrimj9QScpmqgDEeJePrnDrJOrmRZ0rRNRplzbrVcuNjZTQ07hWWXd
         WPOg==
X-Gm-Message-State: AJIora+sW/QrI08IbTFHrnUawY0fe9f7JunOPGCsC5ndOBr4kkVkg0Ol
        nI+cTq8bVcXgIJOLpWh7yKkZE6JQAOCCUESvdsKKxKBDKLYJhA5RS4ERGa9138BC5meoaPibXnu
        HC1VfNo+U814CfYQaDjq/Fj6ht8Q=
X-Received: by 2002:a05:6000:154a:b0:21d:b74d:3561 with SMTP id 10-20020a056000154a00b0021db74d3561mr488342wry.584.1657624385902;
        Tue, 12 Jul 2022 04:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t8ZhXvsJEW8VYsrpIys/4zoUZ19sQAWjNoeBLraKcWG+eh+OaPJTWsHlZQCLCOGeak6REuKg==
X-Received: by 2002:a05:6000:154a:b0:21d:b74d:3561 with SMTP id 10-20020a056000154a00b0021db74d3561mr488316wry.584.1657624385694;
        Tue, 12 Jul 2022 04:13:05 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d4a90000000b0021d6ac977fasm8094998wrq.69.2022.07.12.04.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:13:04 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        akpm@linux-foundation.org
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
In-Reply-To: <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
References: <20220630223258.4144112-1-vschneid@redhat.com>
 <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
Date:   Tue, 12 Jul 2022 12:13:03 +0100
Message-ID: <xhsmh35f68tz4.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 12/07/22 10:47, Baoquan He wrote:
> Hi,
>
> On 06/30/22 at 11:32pm, Valentin Schneider wrote:
>> Hi folks,
>>
>> Here's ~v3~ v4 where we now completely get rid of kexec_mutex.
>>
>> o Patch 1 makes sure all kexec_mutex acquisitions are trylocks. This prevents
>>   having to add any while(atomic_cmpxchg()) loops which I'd really hate to see
>>   here. If that can't be done then I think we're better off with the combined
>>   mutex+atomic var approach.
>> o Patch 2 does the mutex -> atomic var switch.
>
> This series looks good, has it been taken into any tree?
>

I don't think so, briefly poked around git and haven't seen it anywhere.

> Thanks
> Baoquan

