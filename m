Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68B2C433FE
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Apr 2022 08:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbiDAIkl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 1 Apr 2022 04:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244346AbiDAIkj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Apr 2022 04:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E161E13D17
        for <linux-rt-users@vger.kernel.org>; Fri,  1 Apr 2022 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648802329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJgRufLo0Q+2TohvSo0V+grK8YPgHhb39pNmOaDe4X4=;
        b=QsgKOeY/jyrDnesemCy43ABuKXO52uh539OGhNMLGPMWcRkdznaD1HyDYnQHXbk6fbYc0c
        jGDPCOlDURTxHUomyFkPAfOnOcbtVg6L7eIHiHAFGn7bPo6oNxGOsSthGMt3TpqcrL2qGr
        qEjd1kNNk1dQP6+ZA6w6l/x0I8c//fA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-kA5eQhDlPfaEd9tTmNE3Hw-1; Fri, 01 Apr 2022 04:38:45 -0400
X-MC-Unique: kA5eQhDlPfaEd9tTmNE3Hw-1
Received: by mail-wm1-f69.google.com with SMTP id 12-20020a05600c24cc00b0038c6caa95f7so889315wmu.4
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Apr 2022 01:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jJgRufLo0Q+2TohvSo0V+grK8YPgHhb39pNmOaDe4X4=;
        b=VZgDrnn5otuI6by9fA9d0qR/xtfwmRc9fzZcHs6DzAOuquthGHBmkae36Rc/jQLlj9
         iMejxOaf7Il41X9FC2nX/UmWeCqE6kQbDeqnQ+qoS35fYXVomq6zp8ys8pWW1C9yJ1hO
         hgyFN/UfnxpcPr9QQs4o8xoqa1ic1uGLmR55IICMiFdqU4aniQ89iA/ZGRxL6/OcKc3z
         YgtWlnx08ofs/+N4C7eAQEnIfTJF0UC/q6Io58Zs22sFD2otKx+9agbGxwXvP9FLvr9l
         ZfdsBoDsMMOB+IaHzhQNHix0Wha+DauUv+TzkKU5p4holNojBceWOV0ldRYK5mm2oVKG
         +CPw==
X-Gm-Message-State: AOAM532JCgA5g807zReHH/YVumpiyig5fr5RUlQBEc+2/zrQVXNO+1RV
        4VZLzb2UD4xcnMtMYWfgwHx7VVJuaeU/ESNHDUGh++gFjFGybr6wWoZT5Uh7XM47bZQWgMm95nM
        ov82XjspufLkV8SJVM5JGtBouHSI=
X-Received: by 2002:a05:600c:20a:b0:38c:95bf:3289 with SMTP id 10-20020a05600c020a00b0038c95bf3289mr7846159wmi.134.1648802324816;
        Fri, 01 Apr 2022 01:38:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZv6I0FVV+CMTD5Ii7q1vvCTUGk/jp2epbACrhoZA7VwhBmVuCWWnjWAfbB1yDcm4RVzFGLA==
X-Received: by 2002:a05:600c:20a:b0:38c:95bf:3289 with SMTP id 10-20020a05600c020a00b0038c95bf3289mr7846142wmi.134.1648802324598;
        Fri, 01 Apr 2022 01:38:44 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm9408352wml.10.2022.04.01.01.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 01:38:44 -0700 (PDT)
Message-ID: <19fa075a-cc5a-4127-389a-bab7812d7af3@redhat.com>
Date:   Fri, 1 Apr 2022 10:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] efi: Allow to enable EFI runtime services by default
 on RT
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220331151654.184433-1-javierm@redhat.com>
 <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
 <YkYA/Wpqa/PMczkp@lx-t490>
 <CAFOAJEeKNy0HW82W6HV_49d5sc5L0m62QDfY9qA1906_ZzGRYg@mail.gmail.com>
 <Ykas9iX/D3WURx8T@linutronix.de>
 <78a0360d-1a27-5280-10bf-d27d1d306fa5@redhat.com>
 <CAMj1kXGEBtcdD+3MFK5gO6vCw8dg=ruTthdWGVUu1eJpgZXf8Q@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMj1kXGEBtcdD+3MFK5gO6vCw8dg=ruTthdWGVUu1eJpgZXf8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello Ard,

On 4/1/22 10:34, Ard Biesheuvel wrote:
> On Fri, 1 Apr 2022 at 10:33, Javier Martinez Canillas
> <javierm@redhat.com> wrote:

[snip]

>>
>>         if (!efi_enabled(EFI_RUNTIME_SERVICES))
>>                 efi.runtime_supported_mask = 0;
>> +       else if (IS_ENABLED(CONFIG_PREEMPT_RT))
>> +               pr_warn("EFI runtime services can lead to high latencies on Real-Time kernels\n");
>>
>>         if (!efi_enabled(EFI_BOOT))
>>                 return 0;
>>
> 
> 
> I don't think we need another warning.
> 
> The kernel log already tells you whether or not EFI runtime services
> are enabled.
> 

I'm fine with this too. As mentioned to Ahmed I was torn on this, since I
understand the ask for the warning but also don't want to pollute the log.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

