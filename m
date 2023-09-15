Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758E1EDE9B8
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Sep 2023 01:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjIOB6z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Sep 2023 21:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjIOB6x (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Sep 2023 21:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95E0D270F
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Sep 2023 18:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694743082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=k1Q/Fh/fdqx3vdLHA7F/mb5DjxeO42XcGIJeeeZs/TM=;
        b=IKE14XlDX2B7Y2jnzN1RW+yDHx44WOflt7UoSdupqQdLrRoPN0zT8co+MGzxlDewT9J8tK
        LbT8h5EFaQikYbUhHdQARLTY74L/ffZJEyN9qCaCwHqBAHow7cAATW6/+xhJzy4dsD/HdA
        ExUqMpuCwu3GcChCA8pHmHudHKH6lYY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-DCliJKjrNpyEYoFMVC6BPQ-1; Thu, 14 Sep 2023 21:57:59 -0400
X-MC-Unique: DCliJKjrNpyEYoFMVC6BPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE3F6800045;
        Fri, 15 Sep 2023 01:57:58 +0000 (UTC)
Received: from localhost (unknown [10.22.17.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E186B40C2070;
        Fri, 15 Sep 2023 01:57:57 +0000 (UTC)
Date:   Thu, 14 Sep 2023 22:57:56 -0300
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
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.194-rt94
Message-ID: <ZQO6JMUwo1SaCaV+@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.194-rt94 stable release.

This release is just an update to the new stable 5.10.194
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 7d2f06611db33d0957999cc9354e5ac92a8db387

Or to build 5.10.194-rt94 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.194.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.194-rt94.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

