Return-Path: <SRS0=8Jkw=6K=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2860DC55186
	for <linux-rt-users@archiver.kernel.org>; Sun, 26 Apr 2020 02:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 099562071E
	for <linux-rt-users@archiver.kernel.org>; Sun, 26 Apr 2020 02:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6IGecxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDZCo1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 25 Apr 2020 22:44:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48238 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726092AbgDZCo1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 25 Apr 2020 22:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587869066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=1Ub4TaEIWvv6mJMAJ2ByKOCxG8YxO9jAjPb0FtOrhMs=;
        b=g6IGecxCYpkXIHZAg8BFD1iQnpvD0IOoFUGcyq/m4uNcVKV8DWOvDHOFij85d61rnF5MiJ
        DhwpHTzG3TELwtq7WAnieTOT1W1EcA6kLFogklsqW6KUe1CEtkAP5A5dSO4eemORdrULHC
        ffhLJIBDXAuzC+mRPXvJUG4j74mTnkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-JmJPCGJcPJ6S6CMuOoqBaA-1; Sat, 25 Apr 2020 22:44:21 -0400
X-MC-Unique: JmJPCGJcPJ6S6CMuOoqBaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E3EB80058E;
        Sun, 26 Apr 2020 02:44:19 +0000 (UTC)
Received: from localhost (ovpn-112-86.rdu2.redhat.com [10.10.112.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B01460CD3;
        Sun, 26 Apr 2020 02:44:17 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.9.220-rt143
Date:   Sun, 26 Apr 2020 01:32:28 -0000
Message-ID: <158786474898.68412.14269797135440024836@theseus.lan>
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
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.220-rt143 stable release.

Note that 4.9 is in maintenance mode and so has only had the stable update
applied. No bugfixes or changes to the actual RT patchset.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: fa4709dd0976bb6d19337941f9b0a087bc454fc6

Or to build 4.9.220-rt143 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.220.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.220-rt143.patch.xz


You can also build from 4.9.219-rt142 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.219-rt142-rt143.patch.xz

Enjoy!
Clark

