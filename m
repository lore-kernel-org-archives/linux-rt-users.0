Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4E9C7EE23
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 16:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjFAQHZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 12:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjFAQHY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 12:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E1189
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685635595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xaF4LAIG2oh7wL99Qq3/230ZZVPiSunURcG7vN9wEJM=;
        b=BUPOCGUWcwOjoX1klAZYkYqhpj6hgjvKgxB/6oLBsUB8MlyrByLA5VPN/VK4DyfH8uCb70
        mKz+6mGEDhFWLavRGEW+ITSIBqCJWBFT9tHKkUKCJRczx8TIT2geRDl870oSSP7vqAugJx
        ZLg2zTH1dsV3mOqd5OQmiwf+UFemKDY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-sasrK_1IMkW3yzqBC5kHig-1; Thu, 01 Jun 2023 12:05:56 -0400
X-MC-Unique: sasrK_1IMkW3yzqBC5kHig-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-97455ea1c14so17758066b.2
        for <linux-rt-users@vger.kernel.org>; Thu, 01 Jun 2023 09:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635548; x=1688227548;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xaF4LAIG2oh7wL99Qq3/230ZZVPiSunURcG7vN9wEJM=;
        b=iEFn44i7raVIAObWBgp6Pf76E2uquvJcOvP9VUE//MaqYUavTYabDZ899TnwwQykji
         519q5/ssRY6Mj3CCmDPCfpr6Si3pMRpqTVNIAuVO7eIwMJZzvZbhBDL1NFa1Xo08VmIW
         YBMM26ROp9tHDoe5m6gu23ZCPMWRVPcoVwUiBD71mXuEevyluYv6wRWjRLMlbLoSKGHM
         dLqAH0Oj856/8DUwRsvFG7aMuc4QOSeGeF6X+50w4dJ5a0jdsp2ix0mRjiFGeguAXGd7
         O7iCNWtgHZOU0vDhF618Bq6C1GRubsj+KZVADkTl5mM3io7q8YQ5OJMm7GCOr5IKA7RT
         SaJg==
X-Gm-Message-State: AC+VfDw1QlX0kHlkizBUUD5M6LoUwifa6qqcrTt8/9TJm6KXjNo7Kdk1
        h3skKbiTp2OTe3bRFgoXKBZIxRi8luqrsveWCtZVuD6xyBusDme42+ENQV0qcDsp6p19dxts7K4
        Gh4IVA3jSYOaOablmAlwcZZ7gIu8=
X-Received: by 2002:a17:907:da5:b0:973:ea41:3ef8 with SMTP id go37-20020a1709070da500b00973ea413ef8mr9118519ejc.35.1685635548326;
        Thu, 01 Jun 2023 09:05:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7GEbYoaLH8nR2gIno0mTHMpUiTE8b+YcwJJ8T11rbucvlJZgqgJIYMM5a0gtgwd1t1ua/VlA==
X-Received: by 2002:a17:907:da5:b0:973:ea41:3ef8 with SMTP id go37-20020a1709070da500b00973ea413ef8mr9118493ejc.35.1685635548050;
        Thu, 01 Jun 2023 09:05:48 -0700 (PDT)
Received: from [192.168.0.224] (host-87-12-203-248.business.telecomitalia.it. [87.12.203.248])
        by smtp.gmail.com with ESMTPSA id la11-20020a170906ad8b00b00965f5d778e3sm10766381ejb.120.2023.06.01.09.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:05:42 -0700 (PDT)
Message-ID: <b20d1687-b808-2c63-d73d-c962456b3f56@redhat.com>
Date:   Thu, 1 Jun 2023 18:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [ANNOUNCEMENT] Real-time Linux Summit 2023 at EOSS Prague
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Min Yu <myu@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Copperman, Elana (Mobileye)" <elana.copperman@mobileye.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The Linux Foundation Real-Time Linux (RTL) collaborative project
organizes the Real-Time Linux Summit at the Embedded Open Source
Summit 2023. The event is intended to gather developers and users
of Linux as a Real-Time Operating System. The main intent is to
provide room for discussion between developers, tooling experts,
and users, in a friendly environment.

The event will take place on June 26th afternoon.

Topics to be discussed include:

  - Debugging latencies with ftrace
  - Best practices of Linux on safety-critical systems
  - rtla timerlat auto-analysis
  - The famous Q&A with Thomas Gleixner

To learn more, visit the event Page [1]. Also, feel free to reach us out!

[1] https://events.linuxfoundation.org/embedded-open-source-summit/features/co-located-events/#real-time-linux-summit

-- Daniel

