Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65456C43334
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jun 2022 11:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiFWLkG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiFWLkE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jun 2022 07:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3688B4BFD0
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jun 2022 04:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655984401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXX1Tci8u6uSkWlCeJ6TegtPSfgMP3wYaXXEz0pOrgM=;
        b=D2J78GYB/jlNWK0/1KbP8C4y/gj7JpdxMG7vW2eZXYtZ3a+0SjOQWZmUKyO/csWxdKMNYY
        E/22A+jWK14LFA5+ob6ibHKboa1M+35iKAFAvRNyIHi4x92M5aMThtNI2MejIAlFvnemXa
        aeUQTuzONl6KgqXfxfoKSvVNjpKFXpg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-amY3oyWXP4Oa5w-NYTRVYQ-1; Thu, 23 Jun 2022 07:40:00 -0400
X-MC-Unique: amY3oyWXP4Oa5w-NYTRVYQ-1
Received: by mail-wm1-f69.google.com with SMTP id l17-20020a05600c4f1100b0039c860db521so1299721wmq.5
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jun 2022 04:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pXX1Tci8u6uSkWlCeJ6TegtPSfgMP3wYaXXEz0pOrgM=;
        b=22DMhco58gnfY80pdqtWCtFhftVuD5i3RxO6KqE2Ljtm9xWeFMC1VkF8QHRiQ7zB9I
         UOwKR/DnEopHWe3/0YqQhYBN5a82babkCkJbmPNQcY0UJzhlLriQG4+guR4hdZPozOvz
         0ay2GzSimM5S2D151hRr+CYbXQQjhavnbh7b/itbUh/PpJ1yNKqTlIAMyYEH8S3FOXqn
         fkS2CklWe2btIe2dUHGmLNqdhEQnxjFeLxE+W8YYsQcmPH5p96E6oi7+nbkXqRIsTcaX
         zqCAWIz0hF6I/MwuPzbhpgrLe9rFoIDWgtz67LD2j29JB3PovfEhwPMc92i5hSsqR91F
         W5Rw==
X-Gm-Message-State: AJIora+iX6LVq9xHtc3URhuMF1I1zb8noe/zp3X1weaqfVrl5PRgrS7B
        7WHw/tl+FdE/3M4aQS9IWgjX6TNvPfyoRcgIBgSJr5wujGTsKMluwFt2MCKcRaj877D+AKBIWr4
        24ZrnxI7gSA30WhZ2fxeDXaLgyRU=
X-Received: by 2002:adf:dece:0:b0:21b:a4b0:f7e3 with SMTP id i14-20020adfdece000000b0021ba4b0f7e3mr4817786wrn.197.1655984399562;
        Thu, 23 Jun 2022 04:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sK/dnm6ZYIya+uSaMaOutOXp1zODWOwg9uNXRImx0f7YrOK+SdjBXJeYaIC5fXn2ZDefBv4A==
X-Received: by 2002:adf:dece:0:b0:21b:a4b0:f7e3 with SMTP id i14-20020adfdece000000b0021ba4b0f7e3mr4817761wrn.197.1655984399335;
        Thu, 23 Jun 2022 04:39:59 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id h30-20020adfaa9e000000b0020c7ec0fdf4sm27013707wrc.117.2022.06.23.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:39:58 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <YrQzB7sPD8BNxSFq@linutronix.de>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <YrQzB7sPD8BNxSFq@linutronix.de>
Date:   Thu, 23 Jun 2022 12:39:57 +0100
Message-ID: <xhsmhy1xn622a.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 23/06/22 11:31, Sebastian Andrzej Siewior wrote:
> On 2022-06-20 12:15:20 [+0100], Valentin Schneider wrote:
>> Attempting to get a crash dump out of a debug PREEMPT_RT kernel via an N=
MI
>> panic() doesn't work. The cause of that lies in the PREEMPT_RT definition
>> of mutex_trylock():
>>=20
> =E2=80=A6
>
>> Fixes: 6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softi=
rq context")
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
>> ---
>> v1 -> v2
>> ++++++++
>>=20
>> o Changed from Peterson-like synchronization to simpler atomic_cmpxchg
>>   (Petr)
>> o Slightly reworded changelog
>> o Added Fixes: tag. Technically should be up to since kexec can happen
>>   in an NMI, but that isn't such a clear target
>
> RT-wise it would be needed for each release.

So git tells me the Fixes: commit dates from v4.2; from [1] and [2] I get
that both current longterm stable and stable-rt trees go as far back as
v4.9, so I'm guessing if that gets picked up for the stable trees then it
should make its way into the stable -rt trees?

[1]: https://wiki.linuxfoundation.org/realtime/preempt_rt_versions
[2]: https://www.kernel.org/category/releases.html

> There is also a mutex_unlock() in case an image is missing. This can go
> via the scheduler if there is a waiter which does not look good with the
> NMI in the picture.
>
> Sebastian

