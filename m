Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56ACC433ED
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 May 2021 16:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D3E61278
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 May 2021 16:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhEKQI2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 May 2021 12:08:28 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:33196 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhEKQI2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 May 2021 12:08:28 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2021 12:08:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1620748838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4e3c4tHCYigd8VMYKgeRZ8N7ZU9EedN5D+Sp++U8z+0=;
        b=lqNHhh2g8jQLxGz2ZM5eutHuGzscK5sdlJedVtRWqfCCn6bVR+kwr9ZRw9JfIq6a/i4JbK
        DeO/AMV9OCyspuTj5Cm+GoQLHVsCtlSTV3lC6p9YcLyiAS1ihJZ8zsCQOyqCLPVdKFY5Bh
        Blg5zTGgNixld1HM4mHlPEbvoZfTniw=
Received: from [192.168.0.2] (host-79-44-236-134.retail.telecomitalia.it [79.44.236.134])
        by ziongate (OpenSMTPD) with ESMTPSA id 3ccdcf01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-rt-users@vger.kernel.org>;
        Tue, 11 May 2021 16:00:38 +0000 (UTC)
To:     linux-rt-users@vger.kernel.org
From:   Angelo Dureghello <angelo@kernel-space.org>
Subject: big rt latencies compared to non rt
Message-ID: <736a53fb-d80e-3faa-1a66-d40538e0fe26@kernel-space.org>
Date:   Tue, 11 May 2021 18:00:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all,

i am running some RT tests on imx8qxp.
Kernel is a imx (nxp) modified kernel, but with
rt patch (5.4.70) that at least applies properly.

Linux version 5.4.70-rt40-00120-g3e7dde1168e5-dirty

I am running some histograms by

cyclictest --duration=180 -t=1 -m -Sp99 \
         -i2000 -h3000 -q > histogram

Average is near 16uS but there are some outside
values near 40000, as

000009 000000    000000    000000    000000
000010 000001    000000    000002    000000
000011 000002    000000    000000    000000
000012 000023    000006    000008    000004
000013 001565    001504    002010    001367
000014 000425    001959    000649    000700
000015 001447    001917    001129    001415
000016 034084    026118    040328    032334
000017 040537    015000    033773    041092  <-----
000018 005771    009092    007999    007512
000019 002709    023378    001790    003117
000020 000167    006238    000109    000136
000021 000135    002369    000099    000093
000022 000039    000622    000025    000041
000023 000153    000123    000026    000023
000024 000986    000178    000564    000500
000025 001872    000292    001291    001515
000026 000049    000269    000112    000081
000027 000010    000561    000011    000014
000028 000003    000296    000016    000009
000029 000005    000035    000014    000002
000030 000001    000008    000006    000000
000031 000001    000008    000006    000001
000032 000011    000002    000004    000000


Rest of the histogram is mostly 00000 values.

As far as you may know, is there something i am
missing for this cpu ?

Thanks a lot,

Regards,
angelo

