Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AADBC43334
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Jun 2022 16:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383198AbiFQQJe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Jun 2022 12:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbiFQQJd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Jun 2022 12:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CADC3464E
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Jun 2022 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655482168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IBPwk9nDoQIaL1wwpLaX0H/tPNhFrVWuXXlSyUu7t6s=;
        b=Q5FxoFQun0YZUNMt5jCDxzgtXQ1VDf9QKUc71SDvClKuNhrQsXIY/Fb/3oiMsqS5fApA29
        +i0YWmlg1+M5CholWPEVz5rDs8yfxCjOqiCL+OC24VDkplAkoRJUEwa09BEXaECJRqsJwF
        iQwIZ14bRptg9raYZ+VaIrqcLygzEVg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-TNzD87MhMruYDb1TW92rqg-1; Fri, 17 Jun 2022 12:09:27 -0400
X-MC-Unique: TNzD87MhMruYDb1TW92rqg-1
Received: by mail-wm1-f71.google.com with SMTP id k15-20020a7bc40f000000b0039c4b7f7d09so2363459wmi.8
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Jun 2022 09:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IBPwk9nDoQIaL1wwpLaX0H/tPNhFrVWuXXlSyUu7t6s=;
        b=H79WPOS38hoS1HLJV1SRvLUXsuUCiZ/o77hZ+MZrDX1ghe8mlkqVPvC9P/UkW6QzUt
         R3PqoIpcnqFvAAv/S9XuazpWjDYhBqcA/SSLKXWNvC2P16Xge7mmQaL5nOCVRcLV8inY
         KGiSTWNfiuKdHjIxSWlwHZ/lKAFqdSs/5RZE+e8VmMpd/7QeZNePTrbK2mZjKWJKCaQ7
         3eCRqcdal1mNe8ffSIx2RFvH1mrMH4sLen3AjP4naaW9bbn2RjGDYX4RX+OMx7JBfZLb
         HDnfP8KS5Q30k6n8GwRFEyozS/VbzOyWNt8BSBiDBcQPz3qNem0BJ3GY/2pILphQCGB2
         gi9A==
X-Gm-Message-State: AJIora+AxgZF5q60i5O7XgHudaiRLb+KK755RyegugICeDjjEiFyFthT
        kjq+griysY7CiyQIN4MlHof37EKOcIwKG8nlCKXkLFE5OHmIwrh0m8apDvn/78mKtWUer39n+p+
        0tTQlTmjneMC9W4IxerFNhxmYfhQ=
X-Received: by 2002:a05:600c:2e14:b0:39c:58c4:c6ed with SMTP id o20-20020a05600c2e1400b0039c58c4c6edmr10889835wmf.156.1655482166311;
        Fri, 17 Jun 2022 09:09:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u4uhRwDqd/FDNa9ffN3RJce9NoqdX8q9rlMvOtfDNVZYT0LfHesVUll3eMnh2rdM9bZbYJIA==
X-Received: by 2002:a05:600c:2e14:b0:39c:58c4:c6ed with SMTP id o20-20020a05600c2e1400b0039c58c4c6edmr10889813wmf.156.1655482166046;
        Fri, 17 Jun 2022 09:09:26 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c1c8600b0039c84c05d88sm11256071wms.23.2022.06.17.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 09:09:25 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
In-Reply-To: <YqyZ/Uf14qkYtMDX@linutronix.de>
References: <20220616123709.347053-1-vschneid@redhat.com>
 <YqyZ/Uf14qkYtMDX@linutronix.de>
Date:   Fri, 17 Jun 2022 17:09:24 +0100
Message-ID: <xhsmha6ab6zm3.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 17/06/22 17:13, Sebastian Andrzej Siewior wrote:
> On 2022-06-16 13:37:09 [+0100], Valentin Schneider wrote:
>> Regarding the original explanation for the WARN & return:
>> 
>> I don't get why 2) is a problem - if the lock is acquired by the trylock
>> then the critical section will be run without interruption since it
>> cannot sleep, the interrupted task may get boosted but that will not
>> have any actual impact AFAICT.
>
> boosting an unrelated task is considered wrong. I don't know how bad
> it gets in terms of lock chains since a task is set as owner which did
> not actually ask for the lock.
>
>> Regardless, even if this doesn't sleep, the ->wait_lock in the slowpath
>> isn't NMI safe so this needs changing.
>
> This includes the unlock path which may wake a waiter and deboost.
>

Both are good points, thank you for lighting my lantern :)

>> I've thought about trying to defer the kexec out of an NMI (or IRQ)
>> context, but that pretty much means deferring the panic() which I'm
>> not sure is such a great idea.
>
> If we could defer it out of NMI on RT then it would work non-RT, too. If
> the system is "stuck" and the NMI is the only to respond then I guess
> that it is not a great idea.
>

Those were pretty much my thoughts. I *think* panic() can be re-entrant on
the same CPU if the first entry was from NMI, but that still requires being
able to schedule a thread that panics which isn't a given after getting
that panic NMI. So for now actually doing the kexec in NMI (or IRQ) context
seems to be the less hazardous route. 

> Sebastian

