Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D40C433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D8961166
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhJNHPG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJNHPG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 03:15:06 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0C7C061570
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f5so4649893pgc.12
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pvIfn5CrZ6zAHCDToZZ2s6vf19yv0mqdiWMiaTcFX8I=;
        b=pUtt9zri2MsCX8qSZzCRKZPpR8J0vMTKKMkW1h6w1GQ2gPAeWUoX2nl6n4NmpY0V/h
         CasX/DRMQ2zFIjnhbL4yPKB/CaCijBSeO+H7frI3YLlfnLKO/wfnokQRax7enRP22k5/
         xLeQ3xqJMjSKSrMSui+MXHkkdN8V2YKg1D91GOXHSNp/pPCsS4zQVE4jwYDjQ9j0CrGH
         1nt2VVHGsl5nfP4V0t5tnA0GBpsPAQo5EWvcZWojM9NCj52LW8zFNO+SH5dT9HfLNBvQ
         gDi43zxTi/W1ACBHUm8NLm/2HRjKzdgB5F2PQA5/c05gCZ+0JuJ01Yx1GTMm5VPK7ejE
         /AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pvIfn5CrZ6zAHCDToZZ2s6vf19yv0mqdiWMiaTcFX8I=;
        b=rXaMm8Pk4bvKDUeMwBs7ymd1vT0q+EpoB9to8BIZAeW5Dxy/hkRe7sRCXM5d0pLwem
         iGgx+b46QlouEtA4Y7USGMdKRhUQ3Edq0DHQo+xFc7qYH0ZB6E5t7+WElAX5w5YnosNb
         1NNkOYfMp8YVT9TxThv202QW6z4f10uEo6y1csrid60LpmObdItoBnSGCvV/2nCs6mk1
         AK6MKdQ4+AagHooMlx1xYWQmdWKAja1V0sX/89ryW53SxhF+FlWpboKHgUfwXXMY4m7l
         BAVMdFpIHKPG8TZ/m5S2YvrBqCbC/n41AkXg6p5RZ03ZrhL4xKp5fdFIhdKzR82Rf0pg
         MLQw==
X-Gm-Message-State: AOAM533i0PbUbFTz3X0698tF/sx42gzrrQxcW2On3wb/FKcwQC9wcnYr
        yeDOw2hSCgXrSvIHKRvekhz02Bt4u/I=
X-Google-Smtp-Source: ABdhPJzz6vyzPzPyv7LMh76AZE/62TcAsG5g6KQxiLk44V0jX899rP/8tz/3rhUZNKn6fVK/lDJvkw==
X-Received: by 2002:a62:1d46:0:b0:44d:1a4d:5d03 with SMTP id d67-20020a621d46000000b0044d1a4d5d03mr3859714pfd.55.1634195581150;
        Thu, 14 Oct 2021 00:13:01 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id k1sm1452519pjj.54.2021.10.14.00.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 00:13:00 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: [RFC 0/7] rt-tests: cyclictest: Add support to report standard deviation
Date:   Thu, 14 Oct 2021 16:12:40 +0900
Message-Id: <20211014071247.4165329-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Standard deviation is an important measure to evaluate the latency
response of a real time system. It is calculated by downstream tools
such as rteval but the value cannot be correctly calculated when the
latency value exceeds the range of histogram.

This series adds support to report the streaming standard deviation of
latencies to cyclictest. This approach avoids having to track all
latency values and adds minimal overhead (two additional doubles and
compute steps) to each iteration.

In terms of patch organization, the first 5 patches are clean-ups that
were noticed in the course of developing the support for standard
deviation. It should be possible to apply them indepndently.

Patch 6 converts the existing average calculation to a streaming
version. This running average value is needed for the standard
deviation.

Patch 7 finally adds support for calculating standard deviation.

The changes were verified by capturing the latency samples and
verifying the average and standard deviation with manual calculation.

All feedback welcome.

Thanks,
Punit

Punit Agrawal (7):
  rt-tests: cyclictest: Drop unused defines
  rt-tests: cyclictest: Simplify duplicate initialization of "stop"
  rt-tests: cyclictest: Drop unnecessary variable "stopped"
  rt-tests: cyclictest: Drop unnecessary variable "bufsize"
  rt-tests: cyclictest: Move signal handler to avoid function
    declaration
  rt-tests: cyclictest: Use streaming algorithm to calculate averages
  rt-tests: cyclictest: Add support to report standard deviation

 Makefile                    |   2 +-
 src/cyclictest/cyclictest.c | 149 +++++++++++++++++++++---------------
 2 files changed, 87 insertions(+), 64 deletions(-)

-- 
2.32.0

