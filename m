Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7D4C433DB
	for <linux-rt-users@archiver.kernel.org>; Sat,  9 Jan 2021 17:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BEB2388E
	for <linux-rt-users@archiver.kernel.org>; Sat,  9 Jan 2021 17:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbhAIRaN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 9 Jan 2021 12:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbhAIRaM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 9 Jan 2021 12:30:12 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8928FC061786;
        Sat,  9 Jan 2021 09:29:32 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 22so11331169qkf.9;
        Sat, 09 Jan 2021 09:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:subject:message-id:mime-version
         :content-disposition;
        bh=1hfzwISWtXA71C7w2ZLBFmkhJ8BT32skHS1XPrhqOfc=;
        b=MtkHjhLm3bK4hOaF5pUl7dfK1l0HUIf5ygtnq+e1sdXmZde4tZljOR7Lc+177wbZFR
         zSDNdLO0AvXVhw+1ZslZTs+jH/tbg5h5ZGOgZ56L/N0u8eLiTeasAe+dBjclRaLihV1w
         vU0OdIoB4cTdCDus03CB7xH019YjqbgsUQt5WKrIa9AJE+HWuSOHaSotweuiXaBw7wCN
         IByvlDqqoJHqdJVznhnZqWey5dolDrKb5tWFBQQmbayYKcN5qoAfKx33MIUeFYobSC34
         af8Q5jfQYn3of/8l1RUaB3D1nD6pHQdvyem7fFgky5QkzRDR1IDwZJaJDTVJggRzamHG
         kzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:subject:message-id
         :mime-version:content-disposition;
        bh=1hfzwISWtXA71C7w2ZLBFmkhJ8BT32skHS1XPrhqOfc=;
        b=XTse8e8G3w7qm8n8CyiEs1yVgxlQWCi8PzOaBTggoDFbWh5zLAvQ7t6ZfJQaacUSMr
         hUodltpiyO5ql4BjdKMFzZCo7zOkwWJtkmoeamWP2kJ6+6/eHeULTOihRoPPuZgDufwZ
         eg0bxpV8wugeWNpJa/hR7/NksJosoBjOfjBxdi7Ckkmeo5Xea+ZobERCi8XQ42+QEN6X
         yhyVYkN+fT+1NeUCj1+Hx0DvX+n2ywTeWZO6JMP1AkPvSRhiFec5uQgG+1P74TSV67Uk
         w4d6B4npkbJs3vLmbN8Kl77Z8uczAQVNY1s5611calTXwa6lYaGgl3q1gZ3TcGJFQ2oS
         dbAQ==
X-Gm-Message-State: AOAM532Zi+S4gdkSCBEPyc9EiTtCF26AyBMncOA5FyKb6Xvue8zQWfYI
        JVRzUHe3HElDNWCMw74AmpNX8wP2AqE=
X-Google-Smtp-Source: ABdhPJz6KEb4ZQweOgg9yEZdEiQE9MN1z8a81PC22+8PTsRwIcHD5uq1PO5xGv0EIjZN+pIIWToKrA==
X-Received: by 2002:a37:b083:: with SMTP id z125mr9430346qke.246.1610213371771;
        Sat, 09 Jan 2021 09:29:31 -0800 (PST)
Received: from lclaudio.dyndns.org ([191.177.185.4])
        by smtp.gmail.com with ESMTPSA id o201sm3270749qke.60.2021.01.09.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 09:29:30 -0800 (PST)
Sender: "Luis Claudio R. Goncalves" <lclaudio00@gmail.com>
From:   "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
X-Google-Original-From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 77BF83C0048; Sat,  9 Jan 2021 14:29:27 -0300 (-03)
Date:   Sat, 9 Jan 2021 14:29:27 -0300
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.9.250-rt165
Message-ID: <20210109172927.GB387079@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.250-rt165 stable release.

This release is just an update to the new stable v4.9.250 version and
no RT specific changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: fddc3eaab668becf2d42af17db4d1f9ce3e719f1

Or to build 4.9.250-rt165 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.250.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.250-rt165.patch.xz

Enjoy!
Luis

