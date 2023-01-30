Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB42C54EAA
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Jan 2023 19:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjA3Tch (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3Tcg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Jan 2023 14:32:36 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5FF2131
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Jan 2023 11:32:35 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so34972383ejc.4
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Jan 2023 11:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+M93Lmdz0j/a45pRb4dU9DSPNh23hcVmI/9LnS66OEI=;
        b=YuiKwxNIjyyWnZSzbIB7Ire2PgIf39JDawyaoD8VeZ/3v7VQycGmQ0ign3z8+D6a9A
         xHDEbZzr0KVd3g/XyR6CDdmk5JNB4SNj8JCsJOVozjEvH7YRq6Z5Jn6OWrzx/eHTTNke
         9eTGRpLr0hO9+CQz2abCCo78JpV/YtxEa1OyegAUC0vtXw1ODU/pmlz3rfvVXFgDqyFz
         zglZB513C8ga2eY+jDwvt1tbm1FhULn6zE61sifP3jXlHu7rVKllIaf30nPgO6mSGW6Q
         n5aXqoHoZzrgjfmxKjcQvhYbXU0nW4jtQMq8pY+ovQKIbN31REfjUW1JokQ1pwxqP2ve
         2/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+M93Lmdz0j/a45pRb4dU9DSPNh23hcVmI/9LnS66OEI=;
        b=pTjT6tIwQuSZOryJLvNOpGDfRqvaAzvA758hRqUlyJJQ6qGJXURpp29pS6xlcy4j1Y
         s8EDfE1C02ztcs+giSn1YX7Cjr+RwMWg9K6oriLLh1yKRe0FWWUirb489FSvSXpK5WK4
         MRZPU3CEnArM0XDJYMFcw9lHFIC7Ekh3OVjnbQH/XAvUKr4WNnbnNva/WQbPfuCIbsPq
         /C8Qxut1mMoZb9cVRlsbyCysAOG3uGVnJ0XAymZUhl3wg76qKtSMkoZvv8/i9MFj8UwN
         eD0Tr7jY1Old+jgt2Kre3TNdyVUzd5oo5PeDG5zZQoUKEaDVBroVq3lHnRfxllAyTkbe
         VDMQ==
X-Gm-Message-State: AO0yUKVaOQOaM8D8k/z+lLnzFrVLihtFRUoc5sfQTzjnqKbSi7DmfoMX
        gDL9SJwIle/hbmNnCpbPFE4GBv+To9S+TpSj0/TiucVVhLdH1/JG
X-Google-Smtp-Source: AK7set+LD7x4vYPWPr7v0ETu/01bF4vWLxKPpy94f23XgWAb388Yf7O25Vwaph9x60CUWe/T76WlsrJ9PuGehR0CZoY=
X-Received: by 2002:a17:906:6c4:b0:87b:a8bb:8114 with SMTP id
 v4-20020a17090606c400b0087ba8bb8114mr3347110ejb.80.1675107153575; Mon, 30 Jan
 2023 11:32:33 -0800 (PST)
MIME-Version: 1.0
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Mon, 30 Jan 2023 16:32:22 -0300
Message-ID: <CAKkbJ-wOuKFZzmHL8wwap7160HdeoqQwkppGFwCc3Ah5GP94oA@mail.gmail.com>
Subject: Out of Memory problem with kernel 5.16.2 and RT ptach
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,
I'm running Linux Mint with kernel version 5.15.0-41-generic. I have installed
the preempt RT kernel version 5.16.2 with patch-5.16.2-rt19 with the following
options in the .config file:

-Preemption model: Fully preemptive Kernel

-Default CPUFreq governor: Performance

-Kernel Frequency: 1000 HZ

-Disabled HARD LOCKUPS and HUNG TASKS detection.

(Until here it's my attempt to follow John Ogness steps to improve the
preempt RT linux performance, found at:
https://www.youtube.com/watch?v=NrjXEaTSyrw)

-flag CONFIG_X86_X32: n

-commented lines CONFIG_SYSTEM_REVOCATION_KEYS and   CONFIG_SYSTEM_TRUSTED_KEYS.

After I successfully installed the preempt RT kernel, I rebooted and
tried to boot
the RT Linux, but the system returned "Out of memory. Press any key to
continue..."

I've tried this solution:
https://bugs.launchpad.net/ubuntu/+source/initramfs-tools/+bug/1970402.
With the exception that I haven't changed the COMPRESS param.

Is there anything that I'm missing to set up? Also, can you recommend
a safe  kernel version  candidate to RT patch that is close to my
current generic kernel version (5.15.0-41-generic)?

Finally, how can I remove a preempt RT kernel installation?

--uname -a output--
Linux asturian-PC 5.15.0-41-generic #44-Ubuntu SMP Wed Jun 22 14:20:53
UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

--Some processor info:--
Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         43 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  4
  On-line CPU(s) list:   0-3
Vendor ID:               AuthenticAMD
  Model name:            AMD Athlon 3000G with Radeon Vega Graphics
    CPU family:          23
    Model:               24
    Thread(s) per core:  2
    Core(s) per socket:  2
    Socket(s):           1
    Stepping:            1
    Frequency boost:     enabled
    CPU max MHz:         3500,0000
    CPU min MHz:         1600,0000
--Motherboard--
 Gigabyte A320M-S2H

--Memory--
 DDR4 8 GB
