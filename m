Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69399C433FE
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Oct 2022 13:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJCNVA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 Oct 2022 09:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJCNU6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Oct 2022 09:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756B639BB8
        for <linux-rt-users@vger.kernel.org>; Mon,  3 Oct 2022 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664803255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVXsJIBXalnx9DWAK2vGpTAO0XTeIS5m62mJRZPuaKk=;
        b=jAmnYn/C3wd6bR/Kcoqu4TyeC/LgaaauUk8XuVKPoehWRUXs2adEfK2dncC5UoS0/uQo3z
        pWvcBDmfrZTXwEy0/dH7lWcRI+L3hj7v38GawinNlo+KNTULiS8BtGDDj9ix/dV9nk0I2K
        EHR4COpCXUSxXqoFis2UyojvPwmCtJQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-416-UWLAwHkCORS92pDRghVpDw-1; Mon, 03 Oct 2022 09:20:54 -0400
X-MC-Unique: UWLAwHkCORS92pDRghVpDw-1
Received: by mail-wm1-f72.google.com with SMTP id r9-20020a1c4409000000b003b3f017f259so6284636wma.3
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Oct 2022 06:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=hVXsJIBXalnx9DWAK2vGpTAO0XTeIS5m62mJRZPuaKk=;
        b=pchlx/l2g4EGo3WfaMJ7bynXq0MHkGDRaFz0lgScMpkZFaMOytyXQHMiHTsXcrRFOx
         MwEZgpFysgF7p1P+zFAYwhEvG6riSqVynQAd3Z0TjgPBy/ATY46n9gMx+8l7PYf/LzP8
         LWQGzf2gvSCrr7IiGiMYHaGKD4t4rtpZGtG/wG0jVy8iBGEH7xhJX8LbcMU0juGTAfV2
         6ZFp3WsZz27uHWhnsimoPYmhSBHixojmsGeGw833i7D32Pudc+sM7btgVUjRe5DNb/+j
         69p3LGGT9IhCceGAuF8NNt2zkyNZaIfXQwm0lo2uwjTJW8lNCTJNnynXiUVZd7rQ2Say
         MkNw==
X-Gm-Message-State: ACrzQf36b8JT4iDpoY6M0NJPTNBQ4bjcoAQWMOkUahBjsY7/9gY2nvsv
        ya2/VXlf2F7K+eAt9y9NjgszxXViGbAHfPEL0iH4RfKajBsN5dNqP7ff67zwwu6zUNCf0DwQAcW
        nOoFnsX5GMweliPr7a5mbWh9y8FA=
X-Received: by 2002:adf:d1e1:0:b0:22a:cd3e:e98b with SMTP id g1-20020adfd1e1000000b0022acd3ee98bmr13557953wrd.510.1664803253420;
        Mon, 03 Oct 2022 06:20:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4yziT+A7H/8++Xkk8zqP5zDeXrH0j0Cz7+uAIJmoQRJ6TFWZ9Hd0AE6hLkuUVLVWF97tjM0g==
X-Received: by 2002:adf:d1e1:0:b0:22a:cd3e:e98b with SMTP id g1-20020adfd1e1000000b0022acd3ee98bmr13557945wrd.510.1664803253271;
        Mon, 03 Oct 2022 06:20:53 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600005c900b0022ccbc7efb5sm9968291wrb.73.2022.10.03.06.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:20:52 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
In-Reply-To: <20220713103933.e7510daa1c1f6ccde32f4d42@linux-foundation.org>
References: <20220630223258.4144112-1-vschneid@redhat.com>
 <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
 <xhsmh35f68tz4.mognet@vschneid.remote.csb>
 <20220713103933.e7510daa1c1f6ccde32f4d42@linux-foundation.org>
Date:   Mon, 03 Oct 2022 14:20:51 +0100
Message-ID: <xhsmho7ut2gcs.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Hi,

On 13/07/22 10:39, Andrew Morton wrote:
> On Tue, 12 Jul 2022 12:13:03 +0100 Valentin Schneider <vschneid@redhat.com> wrote:
>
>> On 12/07/22 10:47, Baoquan He wrote:
>> > Hi,
>> >
>> > This series looks good, has it been taken into any tree?
>> >
>>
>> I don't think so, briefly poked around git and haven't seen it anywhere.
>
> I'll stash it away for consideration after -rc1.

I've seen them in linux-next for a while, am I right in assuming they'll be
part of a 6.1 PR?

