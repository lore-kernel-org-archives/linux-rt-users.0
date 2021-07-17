Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788C1C636C9
	for <linux-rt-users@archiver.kernel.org>; Sat, 17 Jul 2021 14:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D13F613C0
	for <linux-rt-users@archiver.kernel.org>; Sat, 17 Jul 2021 14:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhGQOKQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 17 Jul 2021 10:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230003AbhGQOKQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 17 Jul 2021 10:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626530839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=bb5bUOTyVVN+A0OrmEfAJLEWvvoprG+HWPTbuM/uaps=;
        b=Nu0GBmSMQM/W/9Asnu7SCrHVW1TA2u9HTbBMDQqfuASzIKgj7loeSXhB0xRpKVhxS1f3B7
        nxcMtDVR68hDL4uwemal2TAvWuMazoaEwdV3/BS2Pna8IrQjOaFvLF95teudCbqEJywR8e
        JBjvVnS58P1xQVM4dgfPFmKNxMSI1zQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-uN2JNViGNJOI2qGnQ0IssQ-1; Sat, 17 Jul 2021 10:07:18 -0400
X-MC-Unique: uN2JNViGNJOI2qGnQ0IssQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36AD0100B3AC;
        Sat, 17 Jul 2021 14:07:16 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-119-14.rdu2.redhat.com [10.10.119.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C20F60C0F;
        Sat, 17 Jul 2021 14:07:14 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 13FCB3C0205; Sat, 17 Jul 2021 11:07:13 -0300 (-03)
Date:   Sat, 17 Jul 2021 11:07:13 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
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
Subject: [ANNOUNCE] 4.9.275-rt184
Message-ID: <YPLkEbAIoISgp4um@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.275-rt184 stable release.

This release is just an update to the new stable 4.9.275 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 91deb31e498354b6ca5225d031fa75a274db2da7

Or to build 4.9.275-rt184 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.275.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.275-rt184.patch.xz


Enjoy!
Luis

