Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE26C433FE
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Apr 2022 08:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243931AbiDAIex (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 1 Apr 2022 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243238AbiDAIev (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Apr 2022 04:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0370673E6
        for <linux-rt-users@vger.kernel.org>; Fri,  1 Apr 2022 01:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648801981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJBsoW1uyBTrmZS6VG/0HyJLaUmX1rPmn4glzAwDgC0=;
        b=CUEA/rpt1nziY6kVw+lAoipdezCJ/uiFDKmR6GjK9TA85GOWgp5BKbwspQ9lrGbg+dBBrr
        odZjgT6VyT9yKiNkmDWCg+ZlgbsV7MTVqWmM0Lqzzh84rG9MAxsAczrvPUyCqLSgsh5ovF
        RpeiT9r8u8qvv49QF5sp10To8sgqfEo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-zXylsKn9MQyAqC3IoVquJA-1; Fri, 01 Apr 2022 04:33:00 -0400
X-MC-Unique: zXylsKn9MQyAqC3IoVquJA-1
Received: by mail-wm1-f69.google.com with SMTP id h127-20020a1c2185000000b0038c6f7e22a4so2547618wmh.9
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Apr 2022 01:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oJBsoW1uyBTrmZS6VG/0HyJLaUmX1rPmn4glzAwDgC0=;
        b=qAGDav5jSP9cAQ8GeLPJ1JjhT1FOKurjAyjkY3B4TMK4yK1oHxGHEnN0HoxY8y6J8p
         NS80LXYmeNuId/ydPx9vegQGifrs0Ym3sClL6DbGe25qxmW071z2spdZvYiO8jrEX2ne
         cVzguWrGVicACvyE2IZdF3T74lV+RcLicAobMax44DjwsEeZthCauUG8L0fidrm1Q8Wk
         fvBBuo4EXJOnpYcLhz94XVVG4lBn6CSzWpgESZ9Avzx4Se86T9kG2/ObPwDhNva2b29I
         /2Jo6pmf+QXZJKpcF6ad04dQdQThQZ7fiAIXuDMCbgtQbaovDVYsoXX+GTBaAcCXl721
         B5/Q==
X-Gm-Message-State: AOAM533EMA0Fn1HvKxaZy2xpnTFjTYlOhSGhV7UvfR6beSNT+wz4/SRQ
        QzHTRwb0c8SKTMHdn2Siow64ciEEVTpZyK6B34XRDxYg9adhohFcnssLXdF5ngcdVH5vwyxhrgo
        AU1Hj05MK80ChEffc89swrM20m5s=
X-Received: by 2002:a5d:64aa:0:b0:204:1c8a:51e9 with SMTP id m10-20020a5d64aa000000b002041c8a51e9mr6944116wrp.314.1648801979077;
        Fri, 01 Apr 2022 01:32:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhe2ldJEjxg5hDUnUWKA3i9yBCZcLWqm4BlLuIRU7wFYimoCPUCaac92i67im3U4a1+J84cA==
X-Received: by 2002:a5d:64aa:0:b0:204:1c8a:51e9 with SMTP id m10-20020a5d64aa000000b002041c8a51e9mr6944091wrp.314.1648801978840;
        Fri, 01 Apr 2022 01:32:58 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b3-20020adfd1c3000000b00205820686dasm1788397wrd.5.2022.04.01.01.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 01:32:58 -0700 (PDT)
Message-ID: <78a0360d-1a27-5280-10bf-d27d1d306fa5@redhat.com>
Date:   Fri, 1 Apr 2022 10:32:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] efi: Allow to enable EFI runtime services by default
 on RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Ykas9iX/D3WURx8T@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello Sebastian,

On 4/1/22 09:42, Sebastian Andrzej Siewior wrote:
> On 2022-04-01 00:19:57 [+0200], Javier Martinez Canillas wrote:
>>> In case of (CONFIG_PREEMPT_RT=y && CONFIG_EFI_DISABLE_RUNTIME=n),
>>> shouldn't we add a small message in the kernel log warning that EFI
>>> runtime services are enabled for the RT kernel?
>>>
>>> In almost all HW, except custom ones with "verified" firmware, such a
>>> warning would be useful... This is especially true since in the embedded
>>
>> I considered that as well but was not sure about what that message should be.
> 
> This makes sense and we had this in the past but dropped it for some
> reason.
> 

Ok, something like the following maybe? If you agree, I'll squash in v3:

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ff57db8f8d05..08d329a5179b 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -362,6 +362,8 @@ static int __init efisubsys_init(void)
 
        if (!efi_enabled(EFI_RUNTIME_SERVICES))
                efi.runtime_supported_mask = 0;
+       else if (IS_ENABLED(CONFIG_PREEMPT_RT))
+               pr_warn("EFI runtime services can lead to high latencies on Real-Time kernels\n");
 
        if (!efi_enabled(EFI_BOOT))
                return 0;

>> Since it will be printed even on systems whose EFI firmwares do not
>> have such long call times as the ones described in the commit that
>> disabled the runtime services for RT.
>>
>> And in that case the warning may be misleading and make users believe
>> that a problem exists, which might not be accurate.
> 
> Does this matter? The efi-rtc driver is known to cause latencies but it
> does not happen if the driver is not used. The same is probably true for
> efi-vars: It won't cause high latencies on _read_ but then a certain
> number of bit flips during read _may_ lead to write+erase which will
> cause higher latencies.
> Having a warning at boot (similar to trace_printk's warning) with the
> options listed that are known to case high latencies might be a help.
> There are some options that nobody will argue about like LOCKDEP. Then
> there are other like WATCHDOG or this one, where a debate might start ;)
>

Yes, you are correct.
 
>> Best regards,
>> Javier
> 
> Sebastian
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

