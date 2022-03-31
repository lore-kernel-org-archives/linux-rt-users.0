Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94C8C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 31 Mar 2022 14:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiCaOwB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiCaOwA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 31 Mar 2022 10:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0850456407
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Mar 2022 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648738212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4syl0TwIcCPylaIS1VmorYj2ruIeY8S5BvvyNsDOjJk=;
        b=XTTH9ygvDcx2Ypt96Gf5ZF2AyHmigtHilWApRnL0+fK9dLbbaB4jQLTxJGKP8Ub0sHs4A/
        D8282/2PEYUCSA9KgNtknoWkhT1fdXsKxHJr6qCepz4wsTcHDusPRjInARo/XlxVi/WWvH
        Enf5U8v5+FiuMEADperueFqiAe+n96c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-OkqaCU9uP1SBpoMB0WHccw-1; Thu, 31 Mar 2022 10:50:10 -0400
X-MC-Unique: OkqaCU9uP1SBpoMB0WHccw-1
Received: by mail-wr1-f69.google.com with SMTP id q4-20020adfc504000000b00203e15159e8so20420wrf.6
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Mar 2022 07:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4syl0TwIcCPylaIS1VmorYj2ruIeY8S5BvvyNsDOjJk=;
        b=qsdAA72KX5Hj0hiZp8CViZdRxteO4Qz6msMxT6rc1QJY6Om7Q1TClGVJ7SohTCulFZ
         p9TjwPqmeTWkTTy+aF45d/3Kpkh2EC+FvhinRzwySDkvR1fMbfTNUcK66A0DvmwdVsYw
         5B7lK9aa2E7NfbsVw+fdZ7twSK9Nx77+3YO9XSouubB6UmdYCCJhSUAm1oaZsjjEk0VK
         lbz72xhu8jk37SMR40SYA3bb8PyGPoTSw3i65KeIemQdSfs/pXGA26aya695RZwWoLBm
         O4ycqa0n9P62yDSKJXykHtoptq9FHNZ8JSVwnVKERW4TlxoG066sszzRiPjgeozp0Ae8
         9/dQ==
X-Gm-Message-State: AOAM5339YUMH3MtHpIACemUh6dknHG9h8Nffp1XxbaE+sXhIdztZFGW8
        EL0W6G+IPE1o8Bwr2Z8Cg0pMK9SYXmTWoVd0VeDBbaCxQW0Rx3Ys6wW/vrXAx/ntHqkB+WpSEgN
        BEQyngQLRod6QAU4ZLrzRN8lShmM=
X-Received: by 2002:a05:600c:4f48:b0:38c:a460:cb6 with SMTP id m8-20020a05600c4f4800b0038ca4600cb6mr5110939wmq.96.1648738208913;
        Thu, 31 Mar 2022 07:50:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9T76Bw0cdtCwgENOVXbVuS/cZmvBb3Y3BI44bqjp7y5iekmFPLn5U6GIX8wGmn8RPjylCzQ==
X-Received: by 2002:a05:600c:4f48:b0:38c:a460:cb6 with SMTP id m8-20020a05600c4f4800b0038ca4600cb6mr5110912wmq.96.1648738208650;
        Thu, 31 Mar 2022 07:50:08 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p11-20020a5d638b000000b002048a77636dsm19369398wru.97.2022.03.31.07.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 07:50:08 -0700 (PDT)
Message-ID: <7178244c-fcfb-01d8-f678-565401cabca0@redhat.com>
Date:   Thu, 31 Mar 2022 16:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] efi: Allow to enable EFI runtime services with PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Al Stone <ahs3@redhat.com>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220331141038.171204-1-javierm@redhat.com>
 <YkW3EmURxE1+kOu5@linutronix.de>
 <ce8d975e-d9dd-f9b8-793d-234258021169@redhat.com>
 <YkW9T2xRSI9e4BFv@linutronix.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YkW9T2xRSI9e4BFv@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 3/31/22 16:40, Sebastian Andrzej Siewior wrote:
> On 2022-03-31 16:25:40 [+0200], Javier Martinez Canillas wrote:
>> Hello Sebastian,
> Hi Javier,
> 
>> Yes, it is but the motivation is to be able to have EFI runtime services
>> by default without the need for any kernel command line parameter.
> 
> This part wasn't clear. It is not mentioned by the description but now
> that I look at Kconfig, it is there.
>

Sure, I can post a v2 with better wording in the description to make it clear.
 
>> In the same vein, I could ask if efi=noruntime wasn't enough instead of
>> commit ("efi: Disable runtime services on RT").
> 
> No, it is not because it should not lead to any surprise latencies by
> default.
>

Yes, it was a rhetorical question. I understand the motivation of that commit
and agree with it. That's why $SUBJECT doesn't change the current behaviour,
and the EFI runtime services will still be disabled by default for RT.

It's just to allow a way to enable for RT users that may want to. But having
a separate boolean symbol also allow non RT users to disable it by default.
 
> Sebastian
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

