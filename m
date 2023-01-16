Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D53C54EBE
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Jan 2023 13:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjAPNg7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 08:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjAPNgn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Jan 2023 08:36:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDC572AC
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Jan 2023 05:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673876155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=9Ys57xffdNMMFn26UewX3tN0RcyW+Hjhp62oLJJcKEA=;
        b=gAtLG2UXoxwaoyTHxEEGVH8lhQBUpS0bbrElsqmv0k2ey7XYML7sovwuaYjcpDrIWtzGRe
        kU3LWcUvWwYjGGrXkdK2d1hA9R8rTjCbRqGrBkKdSv15OklYEswzDxNyS5sjLtItS4r4dn
        1CKwyr1GWPtYfg9cJ81IzfA8vY7cwnE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-beejkRYJPCeK1y-9P9plCQ-1; Mon, 16 Jan 2023 08:35:49 -0500
X-MC-Unique: beejkRYJPCeK1y-9P9plCQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEA4F857F47;
        Mon, 16 Jan 2023 13:35:48 +0000 (UTC)
Received: from localhost (unknown [10.22.32.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BE26492B10;
        Mon, 16 Jan 2023 13:35:47 +0000 (UTC)
Date:   Mon, 16 Jan 2023 10:35:46 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.162-rt78
Message-ID: <Y8VSslRJZpFbo1/u@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.162-rt78 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 143ef105f40a65f3ddd57121d4b4bc36eb10cc06

Or to build 5.10.162-rt78 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.162.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.162-rt78.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

