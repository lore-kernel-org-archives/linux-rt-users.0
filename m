Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97030C433ED
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 22:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D036135A
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 22:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhESWpk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 18:45:40 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:56898 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhESWph (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 18:45:37 -0400
Received: by mail-il1-f197.google.com with SMTP id u5-20020a92da850000b0290167339353beso14305816iln.23
        for <linux-rt-users@vger.kernel.org>; Wed, 19 May 2021 15:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=aePyp/1x6kTEMKAaAM3U6LF8uR5BPiL60qMu9bRPyzOA/iKzQw+3ryGyXqIT9EydBH
         rjxf38ra6eVCTDliHNdPPKsebfSp/O5SX6bV/1m3MuEiV+i82QJliXxFe/dnV9TPltMJ
         kDx7/G5naC9aSEBakiv6lWYfni4QiJfk/K7j05eeN2bwkMSieFR+nBxwdWxjyZ63dhjo
         v2Tg4RK3f41B5UQzxMDwkkmmKjj/KkTjyvfWyHG/nqc7cN8mxqz7qmQ3EUDycOKYj8TF
         XfpiQnPs/MeRb6AjAbLKwN8TFAz45gBA5nAQEspdalh2X00fQjdeB9bgGj6nMlu25Bzn
         GySg==
X-Gm-Message-State: AOAM530WnsKlkGzviF4gr83CA9nQJ1WgCfs6oYhx9a/AFoAth8dMLCFE
        CTYPvcTEzoKovq4Zj+caxlJxxGr0uZFLEf+selxghCVvY0Ai
X-Google-Smtp-Source: ABdhPJyy7WsmunMscRzGZVcZm0kcgfRUDFw5tRRNg+oc3UqRBjmZABfpUTcyQT1bOgD6k6kE4tP6yI+RwGd/mTsf9t7t7n0b8AVu
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:490:: with SMTP id b16mr1608186ils.213.1621464255133;
 Wed, 19 May 2021 15:44:15 -0700 (PDT)
Date:   Wed, 19 May 2021 15:44:15 -0700
In-Reply-To: <000000000000a62d9705a9b61a4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f17f5b05c2b69026@google.com>
Subject: Re: KCSAN: data-race in __mod_timer / expire_timers
From:   syzbot <syzbot+aa7c2385d46c5eba0b89@syzkaller.appspotmail.com>
To:     C.Emde@osadl.org, bigeasy@linutronix.de, jkacur@redhat.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        rostedt@goodmis.org, srivatsa@csail.mit.edu,
        stable-rt@vger.kernel.org,
        syzkaller-upstream-moderation@googlegroups.com, tglx@linutronix.de,
        wagi@monom.org, zanussi@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
