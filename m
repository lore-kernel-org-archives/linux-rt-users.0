Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856B8C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jun 2022 22:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiF3WdP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiF3WdO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Jun 2022 18:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF9742617
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2022 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656628390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XHy4PvEmAkmPOfd1mGpcH63ILnu1M8TgxJfIKYx6Bpo=;
        b=RE+WibXLssBmT7pYNbQsMeTvne7Ay8JDMnKFJD9//Mx0rGz8pX3CCvqW7g74UpBN1AiuSB
        eJxkqwV6xRWGjE/K0Ms9taExtF/sDSAkpKeTEYw3ZXNyhvOKaIDVaEGLOipDGzFc6NYA+d
        lTVlnRPzw4HuIbSXxToG8NwJ2zmLBwc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-hMXiN3__N0-kfnnxMHKBJQ-1; Thu, 30 Jun 2022 18:33:09 -0400
X-MC-Unique: hMXiN3__N0-kfnnxMHKBJQ-1
Received: by mail-wm1-f69.google.com with SMTP id t20-20020a1c7714000000b003a032360873so2084365wmi.0
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2022 15:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHy4PvEmAkmPOfd1mGpcH63ILnu1M8TgxJfIKYx6Bpo=;
        b=5xN3/iZr2YzVWJGgAr/FR2MPJi+/5JHVFw+vYn3Jbh7c0VfeZK8pTDGZz9HrO4reX/
         mW0Yn1M2cVuJ0iMjNdKPBoWOZURfvF9qWQJKmxJAPyHOTNl5w0ctd8qAsQCbT1Rywjs9
         1j2SYR29iWFaIe+m0uCTO+ioID9OK3+AT+0WBugpS9K5HMZYlO+e15FUDECQbzyaWjTB
         AB1HsYzewzZsZlObRMmKhDrehzkGu6FuMY/3VB3x0djND75UyCm+ys9RmT2nKLp2j8r2
         CmDRHA4NX7XLsSa0UunKk+s6QEPm69PYyw1EVFS94sAoIiiAiKIJXJ58+Lw+sQ2IzKWl
         tsBA==
X-Gm-Message-State: AJIora9A6NKNUkSzd11n7X/w9ZI/eKz17iglJ+rN2OuLA3IHu5tMCAvU
        DDUGDSziZ0klT/aBKDhYdcXtxeBTANFk48XiAqcycDbRjWS51x4qjhH0Ca4528BXEmDPKgx+Xth
        alhvIUh4QIxPgcSIlMhM9sinz09U=
X-Received: by 2002:a05:6000:1acf:b0:21d:1067:a1df with SMTP id i15-20020a0560001acf00b0021d1067a1dfmr10899659wry.198.1656628388145;
        Thu, 30 Jun 2022 15:33:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u3PqN+NRcFXDnGhZ2NA2TII+IW79iuDR0NwK+AO+7xudHAIrGuC9tQuCcswJWzhtr32IlB/A==
X-Received: by 2002:a05:6000:1acf:b0:21d:1067:a1df with SMTP id i15-20020a0560001acf00b0021d1067a1dfmr10899650wry.198.1656628387992;
        Thu, 30 Jun 2022 15:33:07 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b0020c5253d907sm4308387wrz.83.2022.06.30.15.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:33:07 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
Date:   Thu, 30 Jun 2022 23:32:56 +0100
Message-Id: <20220630223258.4144112-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi folks,

Here's ~v3~ v4 where we now completely get rid of kexec_mutex.

o Patch 1 makes sure all kexec_mutex acquisitions are trylocks. This prevents
  having to add any while(atomic_cmpxchg()) loops which I'd really hate to see
  here. If that can't be done then I think we're better off with the combined
  mutex+atomic var approach.
o Patch 2 does the mutex -> atomic var switch.

Revisions
=========

v3 -> v4
++++++++

o Someone forgot to Cc LKML on v3...

v2 -> v3
++++++++

o Dropped kexec_mutex entirely and made the atomic variable the one true lock
  for kexec (Eric)

v1 -> v2
++++++++

o Changed from Peterson-like synchronization to simpler atomic_cmpxchg
  (Petr)
o Slightly reworded changelog
o Added Fixes: tag. Technically should be up to since kexec can happen
  in an NMI, but that isn't such a clear target

Cheers,
Valentin

Valentin Schneider (2):
  kexec: Turn all kexec_mutex acquisitions into trylocks
  panic, kexec: Make __crash_kexec() NMI safe

 include/linux/kexec.h   |  2 +-
 kernel/kexec.c          | 11 ++++-------
 kernel/kexec_core.c     | 28 ++++++++++++++++------------
 kernel/kexec_file.c     |  4 ++--
 kernel/kexec_internal.h | 15 ++++++++++++++-
 kernel/ksysfs.c         |  7 ++++++-
 6 files changed, 43 insertions(+), 24 deletions(-)

--
2.31.1

