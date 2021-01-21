Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F1C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Jan 2021 17:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D4023A51
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Jan 2021 17:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbhAUPtV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbhAUPs2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Jan 2021 10:48:28 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3F6C061786
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Jan 2021 07:47:47 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s11so3047200edd.5
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Jan 2021 07:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=Is1OZVE2D476+rxRymb8FFoMpd4LPFxuJ2EMz46a+Pk=;
        b=H6hV7wjQM6Wi8Ev7Zi85Aa+XFBsXlFX2kKEbjq330CrsND6dUMPgOnylnCOS+yhrsa
         LTQGosdb8ze0nPq5/gKFWO6jBmhYeNtxaxicNyZvzisJ78MrchUkQTXWf7SfkL1IcE2T
         F7h+aYa+mP5OKYIE6iYBC8KZomKwFDqmHO+/Ed9SnV7Pdc8f1HP6bALGcT+eUcj8I/h7
         oZjL+9XxCs7/ojP8mwlMnaryVCTR+DoLeMfBO7h1WcKyxT7S7NN6WC0wLaCP5oxqqID1
         uC9610EvUKPXtsLVpIcEyySnYs6xHK0O/cBKh9Trgsd9dqI0Esw/TT76kl7QNjsXmhW4
         UkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=Is1OZVE2D476+rxRymb8FFoMpd4LPFxuJ2EMz46a+Pk=;
        b=L3w7YHZ40ZiV+9fQUZ6ZdYANNDBk6IXBVc4hOUFn80tQixIt5iBVg7YjAVi/MXgC4L
         8+T0jcomZQH6XyCCVCB10K1GtQEys0ApzEynXE8cIgrVpLSNyt2+UR1MvL4THjpwmuIp
         B4AgAoq7JVRYjPHQ1suKySBQk1rx3vtskGh6K1kQEJofk4tiQkAb7YAvv5ABTPBLFtQ7
         lwCvBNI+IzaW1zD+difMgZQWyub+RuBpcVUXoYZiZtcRHcI/1eIIl6Cr/+2XhcJaIB5z
         oqBiR2ZK/xfHSRqcPWRx+wHaDv4WFA3UayJWA2cy0UZd3P4F5xlNfFb3ClRUToDz5yKk
         CscA==
X-Gm-Message-State: AOAM530+u4lHWVSj5B6Tc1ybse7Nxm++UNq03LQEU2Nusz07XxnC+riS
        1ODOcmpw1rL1/4YqjGvwmPcmYp9sb3A9SQ==
X-Google-Smtp-Source: ABdhPJwDrhHTb0kV+MDLB086bo7eea41TZhT37nRN34erGsl19Q4QaIY7bR7wsimwoDI4flMefpf3w==
X-Received: by 2002:a50:fe86:: with SMTP id d6mr11751622edt.80.1611244065879;
        Thu, 21 Jan 2021 07:47:45 -0800 (PST)
Received: from LAPTOP43OUQQN0 (dynamic-2a01-0c23-7034-1d00-35a9-97f8-ea49-d607.c23.pool.telefonica.de. [2a01:c23:7034:1d00:35a9:97f8:ea49:d607])
        by smtp.gmail.com with ESMTPSA id gt18sm2343970ejb.104.2021.01.21.07.47.44
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 07:47:45 -0800 (PST)
From:   <schwenderjonathan@gmail.com>
To:     <linux-rt-users@vger.kernel.org>
Subject: What are managed IRQs?
Date:   Thu, 21 Jan 2021 16:47:45 +0100
Message-ID: <013a01d6f00c$c345be90$49d13bb0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdbwB+cpfoDhOq4nSsmgV9tbUOb/tg==
Content-Language: de
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi everyone,

isolcpus has the option `managed_irq`, which supposedly assigns the IRQs to
housekeeping CPUs if possible. According to the description of isolcpus, the
affinity of managed IRQs can not be changed via /proc/irq.
I've searched the kernel documentation and the kernel source code for 
more information about managed IRQs / managed interrupts, but haven't found 
any documentation (aside from isolcpus).

Specifically, I'm interested in what makes managed IRQs different (as in 
why can't the affinity be changed via procfs), and
what kind of IRQs are "managed"? 

Also, I'd like to verify if the cmdline parameter `irqaffinity` 
affects managed IRQs, or if it only modifies the default affinity for IRQs
which can be changed via procfs.

Thanks

Jonathan

