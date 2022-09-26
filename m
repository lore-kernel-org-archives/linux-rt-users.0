Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C167C32771
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Sep 2022 18:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIZSBK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiIZSAn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Sep 2022 14:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE3685598
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Sep 2022 10:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664214067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=OsWXVF8QvwmUsRiz7nROQFkJK7eddKHY06/18D2mVdk=;
        b=Gwuj7VEK1hAQab56S4B8i/uXcLynC0Z48tst6bQp4QJs5w9y1CH0tq9BIKpuFgtbr3h4tm
        4tl5WS1hmv4Cno7tnkGaj3Tok2vBc2OC0FFsplH2XKS/5sjc/RrewAjCt2ZHeRw/3PxuNK
        vuGDw/YlqLx4xrMWfcPpXeEqqyYHwi0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-vovhZZFKMIWMPYMZDLT_eQ-1; Mon, 26 Sep 2022 13:41:06 -0400
X-MC-Unique: vovhZZFKMIWMPYMZDLT_eQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24E0B803520;
        Mon, 26 Sep 2022 17:41:05 +0000 (UTC)
Received: from localhost (unknown [10.22.11.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B350492B12;
        Mon, 26 Sep 2022 17:41:04 +0000 (UTC)
Date:   Mon, 26 Sep 2022 14:41:03 -0300
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
Subject: [ANNOUNCE] 5.10.145-rt74
Message-ID: <YzHkL3ArjCBaI2gI@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.145-rt74 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: b31b1066942c30514ffd9d653fc1232cd4570c3f

Or to build 5.10.145-rt74 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.145.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.145-rt74.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

