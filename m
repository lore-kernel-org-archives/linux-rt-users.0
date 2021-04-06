Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0AC433ED
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Apr 2021 22:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6FE613CC
	for <linux-rt-users@archiver.kernel.org>; Tue,  6 Apr 2021 22:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhDFWV6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 6 Apr 2021 18:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232505AbhDFWV6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Apr 2021 18:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617747709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s1hRxpt2ffdYHYrIGfbgGHgTPYMM56n8tQe3ShKBMhM=;
        b=Hl14oHivu7UDpv6WSMFzKQbc/sr+Fs3oZXEgYJkdyS6jUYnmeUUA7yr+Qbx/Vfj1VyEcJ9
        Z2OXi0yMSF1I4q0/JTvJ+yV+t0Vn6gzoXW/2Iay6lyee+FJDb2ztdV6eh4zxPs9v/c+aX5
        A2JHLgXxoxOu+mVHGqi4zWWJsld1TJo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-2McL8rwuNwy4PoOK5GYmMA-1; Tue, 06 Apr 2021 18:21:47 -0400
X-MC-Unique: 2McL8rwuNwy4PoOK5GYmMA-1
Received: by mail-ot1-f71.google.com with SMTP id q20so10359721otn.12
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Apr 2021 15:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1hRxpt2ffdYHYrIGfbgGHgTPYMM56n8tQe3ShKBMhM=;
        b=dtO9sUA/T13tMD2DXcdzDDJ64nWNdUOHlhIZDpT6Et1nTrNJ5CJd7xgIpYRfh24Xoe
         j7VOEehkBECMqznxDzBkszQ6zatF9wpip6a0HVzUyLH1HtsK9BnKJxBv8yRB6ORZNYTj
         n88aGxQj4O3T8wbxSPSZzW8OyAn+680ek8CI/4sMXoKO7Zvu2Ip6sUWKnw2Wef6SP99d
         8cgOlyLR//V+mVavjYzkW9bXCmbErITCg5SwWDUMrj01wG0etdFbHcmCVXPKpBIGkxpn
         2zokCoHFKB2hYZAyin/kjmBldWBElePEGTfJr6T1NdicikQGk0eeC/4zRr+fBdRTDW7I
         2wvQ==
X-Gm-Message-State: AOAM530Vi8kQQdH7jsEOusyumpE+90O9X9hUT8uaVf8TsQqCPZTLqGwM
        FTk3hTgT29Wfk6c0xMzVXuPq8rM3a1GpWgkN/WYI5OrcNq7FpAbvHkSpt6ors1uCWl7L/Qi5fdv
        uZuK7cq+gWloZG4a8NpnPTvkBBMQ=
X-Received: by 2002:a9d:303:: with SMTP id 3mr256745otv.268.1617747706954;
        Tue, 06 Apr 2021 15:21:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVK/wKfco2rpUqiiNbYfzLUjvxyjVjuDGeQW5Ynxv/fOZ5VQFgqpDYynoPDmgw+xuTSyAjag==
X-Received: by 2002:a9d:303:: with SMTP id 3mr256729otv.268.1617747706791;
        Tue, 06 Apr 2021 15:21:46 -0700 (PDT)
Received: from halaneylaptop.redhat.com ([136.33.225.96])
        by smtp.gmail.com with ESMTPSA id y10sm4854599oto.18.2021.04.06.15.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 15:21:46 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>,
        Chunyu Hu <chuhu@redhat.com>
Subject: [RT PATCH] locking/rwsem-rt: Remove might_sleep() in __up_read()
Date:   Tue,  6 Apr 2021 17:19:52 -0500
Message-Id: <20210406221952.50399-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There's no chance of sleeping here, the reader is giving up the
lock and possibly waking up the writer who is waiting on it.

Reported-by: Chunyu Hu <chuhu@redhat.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Hello,

I ran into a warning caused by this, and I think the warning is
incorrect. Please let me know if I'm wrong!
I'm working off of linux-5.12.y-rt, but this applies cleanly to older
stable branches as well.

Thanks,
Andrew

 kernel/locking/rwsem-rt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index 274172d5bb3a..b61edc4dcb73 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -198,7 +198,6 @@ void __up_read(struct rw_semaphore *sem)
 	if (!atomic_dec_and_test(&sem->readers))
 		return;
 
-	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
 	/*
 	 * Wake the writer, i.e. the rtmutex owner. It might release the
-- 
2.30.2

