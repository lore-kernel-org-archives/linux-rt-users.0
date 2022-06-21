Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F6EC43334
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jun 2022 12:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiFUMQT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Jun 2022 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiFUMPy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Jun 2022 08:15:54 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D788413D31
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Jun 2022 05:15:53 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id d129so12938299pgc.9
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Jun 2022 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IhRlwR2iBJ2AGg39HG7ecPjXBsP+992iS71lB4PQRYs=;
        b=QbnardF/zZ8JGOI2mPyYYD0B3LKUxxvbEkg6ISCDHbgcswZSqNNHtc/6jkx3YKJZth
         Tzhdvz767wKB7ukMZ1bCfTKBME2e/L5k7yuzcwsbg3btLHcCL9mgaw6Jh8780R2S44Hs
         U1H9dqOFrq1c4m8WcmIXOSxO+kzAcvXhrN4+ITQOEdNeEBSh0npoC+ca98iLZEtmSVSR
         dUbyvJkE1ncGzISa96VJZDxyCwM/lf5trImqsO8456m2lL6W8y9c1BysZQwOOUs9EUNt
         qc3wKBIzidSmmbW9fB2W/55fyEy+7axKhlv8jFszrgprTM07l7iRDtyRiTX+IkOnePND
         8DCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IhRlwR2iBJ2AGg39HG7ecPjXBsP+992iS71lB4PQRYs=;
        b=BmOW5Y3KwHShUNTdor3g+XXryDwI2Op78q9guyJSijzPJ/x2XKxXT8P1CRTpocA/aF
         HyInrRLB8DlXdDcm6Yt4ET1EK9ayRRWFnpPmfYu0dFCx2KsjD1TSl8WZuGuj4AMmtm7O
         T6q8mp9oHIh3u9Ft2CsP3zrBvYfTzujxtUNRSk2qMVz1kVEk2Av/IHpGWNj3BiAvERKX
         yZxGapFOjQzhsFpp6KQTL1YOsD8ndtdsSlQRCcIIhNKF9LG1na1Lug6fC/A3eqVxyrJz
         qwv5Ky2v92g+P3G12/05Yshuv6g38unabCnl7lBM8iDWpW9jlUHwFPQnIYdl0vjpWB3j
         1k2w==
X-Gm-Message-State: AJIora+kfT5ZjFufKnitD8RgDaLq6DiUf2ysMbhKBJ4OycRRW2zRtrIY
        GoU50lTP7j00iSg7xtUkVQI=
X-Google-Smtp-Source: AGRyM1seNI2FKt3/V9+nzbRFmEUFaZDK7Ai/RlbJTCXo3u37c+dAVm25Ny0bySoYGQy04Cb260V3OQ==
X-Received: by 2002:a63:af53:0:b0:40c:b4de:9215 with SMTP id s19-20020a63af53000000b0040cb4de9215mr9543801pgo.97.1655813753325;
        Tue, 21 Jun 2022 05:15:53 -0700 (PDT)
Received: from ubuntu20 (60-249-39-197.hinet-ip.hinet.net. [60.249.39.197])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b0016a0858b25dsm8196445plg.152.2022.06.21.05.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:15:52 -0700 (PDT)
Date:   Tue, 21 Jun 2022 20:15:47 +0800
From:   Zhipeng Shi <zhipeng.shi0@gmail.com>
To:     linux-mm@kvack.org, linux-rt-users@vger.kernel.org
Cc:     tglx@linutronix.de, shengjian.xu@horizon.ai, schspa@gmail.com
Subject: [Question] vmalloc latency in RT-Linux
Message-ID: <20220621121547.GB37196@ubuntu20>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I noticed in rt-linux, vmalloc has a large latency. This is because the 
free_vmap_area_lock is held for a long time in the function  
__purge_vmap_area_lazy. 

In non-RT-Linux, because the function spin_is_contended is well 
implemented, so there will be no such problem.

But in RT-Linux, spin_is_contended simply returns 0. I don't understand 
why this function was implemented like this before, but in order to
solve this problem, I thought of two ways.

The first is to modify the spin_is_contended definition in spinlock_rt.h 
as shown below, but I'm not sure if the change has side-effects:

-#define spin_is_contended(lock)    (((void)(lock), 0))
+static inline int spin_is_contended(spinlock_t *lock)
+{
+ unsigned long *p = (unsigned long *) &lock->lock.owner;
+
+ return (READ_ONCE(*p) & RT_MUTEX_HAS_WAITERS);
+}

The second is by reducing the number of lazy_max_pages, but it will lead 
to lower performance of vmalloc.

Guys, Do you have any good ideas?

Best regards,
Zhipeng
