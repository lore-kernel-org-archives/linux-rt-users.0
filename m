Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6A3C43334
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jun 2022 17:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiF3RVY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiF3RVX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Jun 2022 13:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 711621C13C
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2022 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656609681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A5OgPBniuWt/Ivj7mlDLsvU3Ai/7R90RcZ3oxlYDH8I=;
        b=WwGs+UJ0uvD5noz/o3gl87YyEWay7DUltMdvI6kygGU1sei7vNRXCfzzoJSNXnpLft5F3m
        n+au0x9MHLi5NCrhvf45Wyt6adMUesfvrgjp8mBHa2lXFZzlPqn2Osg5IvXNWm/NBK6y8A
        qGzgGO9W83UjK1cggzcQl8icULT60zc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-pf0sS1ZOOiSK8jEHaUGHLQ-1; Thu, 30 Jun 2022 13:21:14 -0400
X-MC-Unique: pf0sS1ZOOiSK8jEHaUGHLQ-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so1802383wmj.0
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jun 2022 10:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5OgPBniuWt/Ivj7mlDLsvU3Ai/7R90RcZ3oxlYDH8I=;
        b=gVL33/v9Fnr4v86B5u48E64QBTH74v1ouqurbn/U++XYdzv6MojfaF9K+0vgULFS2h
         qanfTHO1Qy/n+23kVNW5rvcSPfbzUJH8DkU7Rxcd+423BqxkLoaul65d581JPuEVbGnM
         Fg1+lhTD5cpTGSMxj02SQyHBiMJF1JNcrUmEVl1aonoBZVJDYHy2x9TY31LpIlW8hXZQ
         Xj6Fk8ahuVCN3nxNS5APBuNeFmKeW6GAOpwmO472fajXiErUD7sYyRheuV6xvrPA0EIt
         1IG71lVdKrWWmvFqKDjkLFOuIZcFGwUk9mRdeK9Ro+ieUXVVCRbjCksEZV02tsUn5/Hj
         PsWA==
X-Gm-Message-State: AJIora+aRgBZAm7gkEGecVFGYqY5Y67OH/L3zY6mPtiq1m0EoXAonJ8y
        J3QenpxQqxITfRHB0/axMQLuWmRYycdB6a/VbggbAWgOL0X/SCnc/yrid7TRbrPkiCJeaDe54in
        VQnT2xUwIQc9HnyW+T/ITNR9Rpoc=
X-Received: by 2002:a5d:448e:0:b0:21b:887f:23f with SMTP id j14-20020a5d448e000000b0021b887f023fmr9598762wrq.240.1656609673084;
        Thu, 30 Jun 2022 10:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tLSw0n9SwkwRiHg02raa2UNgWCjcHEkLR9YfRZg33No2Yv3dNxwDSETN5lNlfJhNYkN9rmTg==
X-Received: by 2002:a5d:448e:0:b0:21b:887f:23f with SMTP id j14-20020a5d448e000000b0021b887f023fmr9598740wrq.240.1656609672838;
        Thu, 30 Jun 2022 10:21:12 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0039c41686421sm4065122wmg.17.2022.06.30.10.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:21:11 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     kexec@lists.infradead.org, linux-rt-users@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v3 0/2] kexec, panic: Making crash_kexec() NMI safe
Date:   Thu, 30 Jun 2022 18:20:39 +0100
Message-Id: <20220630172041.4100123-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi folks,

Here's v3 where we now completely get rid of kexec_mutex.

o Patch 1 makes sure all kexec_mutex acquisitions are trylocks. This prevents
  having to add any while(atomic_cmpxchg()) loops which I'd really hate to see
  here. If that can't be done then I think we're better off with the combined
  mutex+atomic var approach.
o Patch 2 does the mutex -> atomic var switch.

Revisions
=========

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

