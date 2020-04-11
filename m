Return-Path: <SRS0=f+xt=53=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1074DC2BA19
	for <linux-rt-users@archiver.kernel.org>; Sat, 11 Apr 2020 21:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C056320787
	for <linux-rt-users@archiver.kernel.org>; Sat, 11 Apr 2020 21:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDjwmzrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgDKV1B (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 11 Apr 2020 17:27:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42996 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbgDKV1B (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 11 Apr 2020 17:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586640420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=OQrsw5L6zYIgHHkl59IcfAMFT3R9AZwVHuHRpnA7cco=;
        b=iDjwmzrVC3cjXEgSa9deCfJ3QA09fbp3MllSDtnjQolG1aO2OlFBMqvmVC/mrJ12F4NlIw
        aLtCoI20wwTDM9rPGWyytYPbOgT8xAlBXE0y2Cf5d9IYmUai5h12x6eouddWL8XzM6cAX9
        6lnql1KwZUBPPglrOi+h2UIsANkYZQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-rI7tbsEBOkK_ebbFkhdebw-1; Sat, 11 Apr 2020 17:26:58 -0400
X-MC-Unique: rI7tbsEBOkK_ebbFkhdebw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D14613FC;
        Sat, 11 Apr 2020 21:26:56 +0000 (UTC)
Received: from localhost (ovpn-112-176.rdu2.redhat.com [10.10.112.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EA49CFDF6;
        Sat, 11 Apr 2020 21:26:55 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.9.218-rt141
Date:   Sat, 11 Apr 2020 21:23:09 -0000
Message-ID: <158664018976.267470.9190420949400202455@tagon>
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
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.218-rt141 stable release.

Note that this is a maintenance release only. It is just the application
of the 4.9.218 stable release and no updates to the RT patchset.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: ec9810c2b626cded51bb6fd0473f1e25f7ec60b8

Or to build 4.9.218-rt141 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.218.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.218-rt141.patch.xz


You can also build from 4.9.217-rt140 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.217-rt140-rt141.patch.xz

Enjoy!
Clark

