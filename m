Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDB2C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Nov 2021 09:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhKWKCq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:02:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhKWKCp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Nov 2021 05:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637661577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z4SVdriUsPLrl4wZFTKmXBFzP4Q4i5HhaOV+C11ofG8=;
        b=jP/wH9jBdpY7WRHI4tgYJPXodoTJ9NpR2cxKz6bfwuxFtjyueMOnSM02kQBkqOGemxrHBD
        PEYkKz9ggYU2ig9ZLEiQRDsoGFX6jNlkuKIOB07uBBRMZSvBB8JATr4YseHLihZrzhW5BM
        l0puqDiYT5mNS+yzOosVa5hb9XhOFLs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-DKGoMYe-PpmBii9Ck5QYPg-1; Tue, 23 Nov 2021 04:59:36 -0500
X-MC-Unique: DKGoMYe-PpmBii9Ck5QYPg-1
Received: by mail-wr1-f72.google.com with SMTP id q15-20020adfbb8f000000b00191d3d89d09so3605217wrg.3
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Nov 2021 01:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z4SVdriUsPLrl4wZFTKmXBFzP4Q4i5HhaOV+C11ofG8=;
        b=QG6iXXs+9FL3JrS9iOH+FS90xm9fuJYx2Ti2C7YTZoCLlKDNTN1jvUmRrEuoKHVV5F
         4oglstxfWKrBbU7bd3vjVl2uVzmZzBEmtHxG9ZZ8THNofhpnJBGpdTxfryCYp4rQLqv+
         FkP0w+bziP5wB1PA3A+B0NEfyImY9Prj5JdwzWYzAeXZH0ss+7AUSqS2gztFDKMLwA7M
         /soZrrnnDRgU8aYz5h6QG4xRhcWcTPIUCKvo8OrhrWoJWazmG4UzZxaXwpvzSHjMMR64
         3ocVPZNkDmEAHwmZtISahPKpwUbkLkslVCmIPDPJ1lKicrqg1QaywqsF1euFUVcEaZb9
         UgVg==
X-Gm-Message-State: AOAM533MyBRJoV7gwiBMWZi3yJdlot+X5Ed+ppXyspjONXzWee7bcAbv
        TLaJvA9KvXDHZTLSg6TGg0rr0D+UmlY8ovKu6YsGj4eG/zNTPwTer4LOyNIj0VWMzlyZxjf9mv6
        fhaHG5kS1LJW93TRPZ4w9eH8nUAY=
X-Received: by 2002:a5d:59af:: with SMTP id p15mr5500299wrr.314.1637661575002;
        Tue, 23 Nov 2021 01:59:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWOu0SWv8Jr5Pwq4WJKrbjdn4sATqjzvbSSS5Cj48IhMI88GC2pqQ7BCmzHUQyaOhiFVTe5g==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr5500274wrr.314.1637661574780;
        Tue, 23 Nov 2021 01:59:34 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id bd18sm538888wmb.43.2021.11.23.01.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 01:59:34 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mtosatti@redhat.com, juri.lelli@redhat.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH RT] arm64: Allow selecting KVM and PREEMPT_RT
Date:   Tue, 23 Nov 2021 10:59:28 +0100
Message-Id: <20211123095928.21525-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

With 6caa5812e2d1 ("KVM: arm64: Use generic KVM xfer to guest work
function") all arm64 exit paths are properly equipped to handle the
POSIX timers' task work.

And with a68773bd32d9 ("arm64: Select POSIX_CPU_TIMERS_TASK_WORK") we
now handle the timers in thread context.

This allows for KVM and PREEMPT_RT to coexist, so update Kconfig to
reflect that.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---

I guess this could be squashed into 19614b91cc83 ("ARM64: Allow to
enable RT")

Note: I did test this on an Ampere Mt. Jade based machine.

 arch/arm64/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6bd4acc2be02..260866cf53c9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -89,7 +89,7 @@ config ARM64
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_NUMA_BALANCING
-	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	select ARCH_SUPPORTS_RT
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
@@ -216,7 +216,6 @@ config ARM64
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_ECAM if (ACPI && PCI)
 	select PCI_SYSCALL if PCI
-	select HAVE_POSIX_CPU_TIMERS_TASK_WORK if !KVM
 	select POWER_RESET
 	select POWER_SUPPLY
 	select SPARSE_IRQ
-- 
2.33.1

