Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFF6C433EF
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 Jul 2022 00:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiGPAjK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Jul 2022 20:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiGPAjJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Jul 2022 20:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 374993DBF7
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jul 2022 17:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657931945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=oxMsgHgkOs0K1Xf4snqsrkPHTjlyIKqMwEhVdQleeuM=;
        b=aHBLpFAAdcJV/Wr4m01CcewJmEy3folTFDIozVeQsrPkuQzHgfehHITQON/umXFoXc3KFK
        bRmSgACCChkJI/CUH3yFgy+G/SvLRSaX3VmxyiM9eMsRbBUQQQ96DDdDtHGcwvXbPWuh35
        sFStUwqC4KA6NlYBQSEoA0ESNBgeRbw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-T9rEP0h4O9q6fqMoIf1kBg-1; Fri, 15 Jul 2022 20:38:55 -0400
X-MC-Unique: T9rEP0h4O9q6fqMoIf1kBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE8CF80418F;
        Sat, 16 Jul 2022 00:38:54 +0000 (UTC)
Received: from localhost (unknown [10.22.32.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0509040E80E0;
        Sat, 16 Jul 2022 00:38:53 +0000 (UTC)
Date:   Fri, 15 Jul 2022 21:38:53 -0300
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
Subject: [ANNOUNCE] 5.10.131-rt72
Message-ID: <YtIIneq0NCXILs8T@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.131-rt72 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 708e7c0b39cf6f804901396f0bb1e620fe7c429b

Or to build 5.10.131-rt72 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.131.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.131-rt72.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

