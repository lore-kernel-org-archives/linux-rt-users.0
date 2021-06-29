Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586E4C11F66
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Jun 2021 04:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3385561D9E
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Jun 2021 04:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhF2E4v (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 00:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhF2E4u (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Jun 2021 00:56:50 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC6C061574
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Jun 2021 21:54:22 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b7so25090961ioq.12
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Jun 2021 21:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Y94KFp//GHNht+/OQL4FlItcSFkUc6yZ6qOYVP9cQ9U=;
        b=onS1tW1Ca24I5V9eTzVfSLFJcSL+ivaQyzf/6vG4G8Oo2VQ0xK37j5vDjxj4xIp75t
         IoZPk/Dw0SmF7lxdXkzfBJ38naYuqYvVTYZWPQtNCziCnP86+AbggJmwaqxT/c+/LPOq
         kMpf95rK8FbEtK0nkIyaBJmML9faSNQjDt3VWHjllukXNCHtEd/26TZ7JNKTFZUAz9VG
         SOnN/dBetStRG8I4qlrl1wKrWh0f2yq4EjGLXDsNOeIz4Xg43Z/yXaaRxX3KyG9bKpFX
         9IplLQI2fuPOPyiXMbPYBiwZ8JxY23PM3VpIobqJP253zFZY0addCF1Ac/d9WPCwW4Ky
         BJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Y94KFp//GHNht+/OQL4FlItcSFkUc6yZ6qOYVP9cQ9U=;
        b=WjvNeHMPUzefXIRpSX8C/Mre5sNoxageTxr0qsxcj7AUtn978P+G5m0zfdsZsoFNcX
         6+NqZcnX0zWMiIEscBSYsci09BJsd3fdFUbekPuhkNm7t9B/r6E6aDW1OeyYLtp8gJjG
         Myysa+99QYYH94HMfY3kNNofgrB6cST1CnPX4puUF8OQFWD1bZnIJGG9u2dxdr0X7I+G
         i0MnZjO6wAHImcApGmObgVe8baWJwhsii6g3hKJyIIsGYAPymqMyBGXXU78MzbeQPZw/
         Jkymrl+oI0lcrOWMYdVmDiLI/vASUALCJcY2bNxiyJ5bMs0YN+VO3gIkNMnDVmThanDV
         D2Gg==
X-Gm-Message-State: AOAM530Zz1JRQ29pHZviK2UyUfKR7kxUihrW63CnHz7pqBuq+b9t/yBf
        f7YQUfGVv2TRCJq8TbXqrQlCK62xNktRW4KUA/sOlU7++yM=
X-Google-Smtp-Source: ABdhPJzHJ+Ow5HXLCJ/9q1CiaKGcr7/K8cWbhhKm88FjUisAP4JGQMIaNMCWEmF5vNcUnAePxGfyu2OLHLHc987S5kE=
X-Received: by 2002:a02:9665:: with SMTP id c92mr2621168jai.56.1624942461939;
 Mon, 28 Jun 2021 21:54:21 -0700 (PDT)
MIME-Version: 1.0
From:   manty kuma <mantykuma@gmail.com>
Date:   Tue, 29 Jun 2021 13:54:10 +0900
Message-ID: <CAB6A5-C=YsVca4OQJZ=tOg9mjzEjobD9b94Mkvc0Ora_uQ-GCA@mail.gmail.com>
Subject: Questions related to nano_sleep()/hrtimer
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I went through the source code for hrtimers and understood at a decent
level about how they are working. However, I have the following
questions.

- What is the clock source for HRTimers and what is the frequency of
this clock device?
- with timer subsystem CONFIG_HZ can go to a max of 1000 meaning at
the maximum only 1 ms latency can be reliably established. I
understand that hrtimers are not using CONFIG_HZ but i am just curious
as to what their clock source is and how 1 ns precision is achieved?
- I am using a RT kernel and I see that interrupt handlers are
executed as threaded-irqs. Is it possible to configure the priority of
the interrupt handler hrtimer_interrupt()? for a FF process, the
wakeup() is called from interrupt context(called by threaded irq)
which is actually having lesser priority than my higher priority
process. If possible I would like to change the priority of the
threaded_irq  process that handles timer interrupts. I believe this
way sleep() will not take longer than expected.(I am debugging issues
where even my FF process with prio 110 sometimes fails to wake up back
in time)

Thank you in advance!

Regards,
Manty
