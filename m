Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC441C432BE
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Aug 2021 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D6260F5E
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Aug 2021 20:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhH3Uf5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229923AbhH3Uf5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Aug 2021 16:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630355702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZLTTnf5uZ4KR+vVkQCJrgcN+AiWLXpcO7k3igJ1r1cc=;
        b=OzQxq9HyixD8FyQ2UH+QtO7crXt8CasKx+AyQtSPcgqeGsNyvm4pM8L2CZ3RTn6OgX7QOc
        127BoupFnE52gUD0+bDCr1F5YVii7Z647GpUZBOXGes3gtFNYUMlPcPZpl28zO4GddVuEH
        Vsit2SCXTyUCueM89cZeGLHRIROcwjY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-sKOWjgDgMSaEG2qdIsnSNQ-1; Mon, 30 Aug 2021 16:33:35 -0400
X-MC-Unique: sKOWjgDgMSaEG2qdIsnSNQ-1
Received: by mail-qt1-f200.google.com with SMTP id 98-20020aed316b000000b00298da0dd56bso3136726qtg.13
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Aug 2021 13:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ZLTTnf5uZ4KR+vVkQCJrgcN+AiWLXpcO7k3igJ1r1cc=;
        b=bDC24FeqIezWU1JgmJfI3CFkgZu7WqzrpI03EYQPmY7+VMvqCmBKx366FW7PR6gKCj
         dqC78zf/TDZmIV5XPQb8bXvuFlLuy3oY4YilRbUgOsF9gQQWkH8Ou8Umj1kX24q4ONZX
         jcRX1MB4i4uPzpR6wsbLIYli2wvGCOOPgYJCk8nSSA6Mt1PbbJsM18q6gi0NBUN08jCM
         KQk4Pxp7rmwBtAL6KqSrSyP3aPp1w+1/hCDU2AXLypMFbq5YCZeNNOU8CSWUfmB7lX4M
         1S6GBCf3ZiApt5LR1VwqWGsGWSAHGFOKVq6BzmF4k1JYVXqTS8CwfE4ujxrgQrGETPyg
         qALA==
X-Gm-Message-State: AOAM5320tN4TkyW8ATw46MNVSKm60v6TQ6+OpaYf0ewibdrVEcNLHICN
        zVZhwWsI3boH9l2mOIR2TJyceT+cp802wgwweXpZs3i986gGYiichCn8eG5ar9DTS/S0WGiU8y1
        JEUnv0C0DsZocWNVs1zVnsmVUMfM=
X-Received: by 2002:a0c:c285:: with SMTP id b5mr7876225qvi.33.1630355614584;
        Mon, 30 Aug 2021 13:33:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys7Hs9b8ToeqmALWQENDwL2JUUL3bLtJystvIeBAto7q3NLC6OoKf+w4vdKEPmfTInJDAX4A==
X-Received: by 2002:a0c:c285:: with SMTP id b5mr7876209qvi.33.1630355614347;
        Mon, 30 Aug 2021 13:33:34 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id b1sm9132743qtj.76.2021.08.30.13.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:33:33 -0700 (PDT)
Date:   Mon, 30 Aug 2021 16:33:32 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [rteval] Fails to work without numactl
In-Reply-To: <20210830195151.ym2svjnbekk7hvsg@linutronix.de>
Message-ID: <67ce47c9-1631-bf20-8477-f6de91775062@redhat.com>
References: <20210816115809.bb4jtb56zkagqmq6@linutronix.de> <20210830195151.ym2svjnbekk7hvsg@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463769598-306578173-1630355613=:4167"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463769598-306578173-1630355613=:4167
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 30 Aug 2021, Sebastian Andrzej Siewior wrote:

> On 2021-08-16 13:58:09 [+0200], To linux-rt-users@vger.kernel.org wrote:
> > rteval as of v3.2 (and the main branch) fails to work continue without
> > numactl around:
> …
> > | TypeError: 'NoneType' object is not subscriptable
> > 
> > It continues to wait for kcompile…
> > 
> > With numactl around it uses a different path and continues. However it
> > then finishes (the main binary) while the compile job and hackbench
> > continues (not sure if this is intended).
> 
> ping.
> 
> Sebastian
> 

What distro are you running on Sebastian?
In rpm based distros numactl is a Requires, so that path where it is not 
available is rarely tested - but that doesn't mean I won't take a patch or 
try to fix it myself. I did have a quick look at it.

kcompile.py compiles an allmodconfig kernel. (not sure this is the best 
thing to do still, but that's a different topic)

The requirements for that continues to grow. I have often seen rteval fail
when requirements for building the kernel aren't installed on a machine.

You can usually figure that out by looking at the debug logs in rteval, 
but another simple thing to do is simply try an allmodconfig kernel 
compile on your machine and when it fails figure out what 
software is needed. It wouldn't be a bad thing to have a list of Debian 
build requirements and Fedora build requirements, etc.

John
---1463769598-306578173-1630355613=:4167--

