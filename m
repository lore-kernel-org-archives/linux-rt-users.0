Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A75C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 14:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04FB023998
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 14:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbhAHOoA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAHOn7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Jan 2021 09:43:59 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3AFC061380
        for <linux-rt-users@vger.kernel.org>; Fri,  8 Jan 2021 06:43:19 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n10so7755808pgl.10
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Jan 2021 06:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=q0M+CbexSJ0phINKY2HzjqKMyc1HDOhNAPkn1G63ims=;
        b=I/ZTvqhmLroKLKmkzmne26Z/D0PN03tOQK/68VLZHtmJ2mPJSnz3qyJeknbjJgV7/D
         nBhiLjhB3d1Fw6Y9KA3st0z3MIAn50TAURsszDfEuQU1KWnyi0vGc9TdpsBYH1Gl1LZR
         dsyR3KvoAr7oBR9ixc3EL0BXJOZiACrUNw3ymVCdQsBCIm1iGwMzqYHxAjtbnke1kfm2
         tgSrotZVDGobnbQe/EdUWigAgg+tfQvoYS2pPllyz4CuZqRKLtvhbOnHYsGnKsl/TE8W
         TF2DLIHJT67ogvayFJS8A7xaFOeq8pWU3pBjXyCDulbFOjoeJN3WR5fh01zbOS/oDa+Z
         4rIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=q0M+CbexSJ0phINKY2HzjqKMyc1HDOhNAPkn1G63ims=;
        b=Uwz/UzIpCj1gsyfcEk2nJLKbxl4X6ZBSunDsny9xsZoQjMjmuvN7CzGkrd//ywbKKG
         8O/5iFxpq3UjE+AYk0DMfAkeor4jOkZigsa4FbdPavTRGwk5O/LW1acWvDtJwbzc+rJO
         5fVGLKpXXEjYeV0sL84jgoXrh+enkR6H73tNvVWsvZ1Z+9sTN6vrAJGtJqtQeFz86m0G
         ZcDGFzQQRpdoaOlE/TgyDt3DKlKgWYP4+D7a7hBDXPc/JZLvszOcmQ7MWuqBaoRjrDHU
         YDP4piPoT2k7wODhOTMmrwTeLMFtbm1PThfltmBOVKqRiBxz5tFmJjH2repyO+xCA2Ce
         f0sw==
X-Gm-Message-State: AOAM531MVCU4jTruxlcSAQnvEgVsUp9/La+DZBlPTSNsqrrxz4UGNtDK
        o64kYASEHiY/+pAjyFDSFqjHcSIW9y4=
X-Google-Smtp-Source: ABdhPJw3Brrp2YsfpU8c3Ihtg9eqaLJdpTlXzrVa8jH4QdF/HxRqn7ie2vxMgIRvY79Si6XlOoUcaw==
X-Received: by 2002:a62:19cb:0:b029:19e:75c2:61ec with SMTP id 194-20020a6219cb0000b029019e75c261ecmr3912417pfz.19.1610116998620;
        Fri, 08 Jan 2021 06:43:18 -0800 (PST)
Received: from hoboy.vegasvil.org (c-73-241-114-122.hsd1.ca.comcast.net. [73.241.114.122])
        by smtp.gmail.com with ESMTPSA id n10sm9118670pfu.176.2021.01.08.06.43.15
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:43:17 -0800 (PST)
Date:   Fri, 8 Jan 2021 06:43:14 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     linux-rt-users@vger.kernel.org
Subject: thread_do_softirq in 4.19
Message-ID: <20210108144314.GA23597@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear list,

The function thread_do_softirq() is never used anywhere in
v4.19.135-rt60.

   git grep thread_do_softirq

   include/linux/interrupt.h:505:static inline void thread_do_softirq(void) { do_softirq(); }
   include/linux/interrupt.h:515:extern void thread_do_softirq(void);
   kernel/softirq.c:674:void thread_do_softirq(void)

Is it supposed to be called from somewhere, or is it simply dead code?

Thanks,
Richard





