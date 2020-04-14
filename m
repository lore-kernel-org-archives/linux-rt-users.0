Return-Path: <SRS0=tgTk=56=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D85C2BA19
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Apr 2020 15:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B5320768
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Apr 2020 15:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsUuqHFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437193AbgDNPKs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:10:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48896 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440294AbgDNPIi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Apr 2020 11:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586876918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=KqvdvPMVZP9GhLam1e8X/uCXyRLGbaBc4BNhj+P59mw=;
        b=JsUuqHFonqqiTxwvd9kwJFTus9/HCqBtXcaW9mcX2FfpKxLNj4UeKt3EvyQyngUxbspvIx
        UuW0hfs/mGTnxKx7rMb5USEO99swfdGMyDXOT97fQfKTXH4UTWp5hjtOPOAcs4rXqBXLjg
        foCUvH32EzIAbOHbqhRLAuFuPHws2us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-XZ3qLv-yOUejSdncIk2Eiw-1; Tue, 14 Apr 2020 11:08:34 -0400
X-MC-Unique: XZ3qLv-yOUejSdncIk2Eiw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EA1810CE780;
        Tue, 14 Apr 2020 15:08:32 +0000 (UTC)
Received: from localhost (ovpn-116-111.rdu2.redhat.com [10.10.116.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07F9627098;
        Tue, 14 Apr 2020 15:08:31 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.9.219-rt142
Date:   Tue, 14 Apr 2020 15:06:33 -0000
Message-ID: <158687679390.397792.8613444289630927615@tagon>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.219-rt142 stable release.

Note that 4.9-rt is in maintenance mode, so this is merely a merge of the
upstream stable updates, with no changes to the PREEMPT_RT patches.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: a3ddf39c50c383f479faafde2e4e2167568724cb

Or to build 4.9.219-rt142 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.219.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.219-rt142.patch.xz


You can also build from 4.9.218-rt141 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.218-rt141-rt142.patch.xz

Enjoy!
Clark

