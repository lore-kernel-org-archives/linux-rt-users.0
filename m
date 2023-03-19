Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B41C6FD1F
	for <linux-rt-users@archiver.kernel.org>; Sun, 19 Mar 2023 23:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCSXkU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 19 Mar 2023 19:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCSXkR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 19 Mar 2023 19:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9589ED507
        for <linux-rt-users@vger.kernel.org>; Sun, 19 Mar 2023 16:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679269170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=kzVjkgShYRymTWICVbKBF3/OVB1io04N68cLL010wmw=;
        b=Aq7Bhtbug0ysJwAqvpTNX7yOT529WhwXLrNny/k63pmeDMeEw89bRirJFrISZBnZdBRizs
        eGg9ZJIlbrZoWG9TbNFfTqV5c1OnQoYBAdYGjC2N+CevHes9LJOzwWfj3w2X0+/UTE0R4P
        pnJ3UHwmGxKZReUXRiNVDKmp28rNN58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-49QM-TVlN7Gb6YvW5-LD1w-1; Sun, 19 Mar 2023 19:39:25 -0400
X-MC-Unique: 49QM-TVlN7Gb6YvW5-LD1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7907A800B23;
        Sun, 19 Mar 2023 23:39:24 +0000 (UTC)
Received: from localhost (unknown [10.22.16.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1271540C20FA;
        Sun, 19 Mar 2023 23:39:23 +0000 (UTC)
Date:   Sun, 19 Mar 2023 20:39:23 -0300
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
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.14.310-rt145
Message-ID: <ZBedK5cf26Hq8asW@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.310-rt145 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: ba340b0a1efff3cd4efdc5df2d3f469780e21c2e

Or to build 4.14.310-rt145 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.310.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.310-rt145.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

