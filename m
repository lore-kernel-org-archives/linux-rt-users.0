Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C848C7618A
	for <linux-rt-users@archiver.kernel.org>; Sun, 19 Mar 2023 23:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCSXck (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 19 Mar 2023 19:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjCSXci (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 19 Mar 2023 19:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06431968A
        for <linux-rt-users@vger.kernel.org>; Sun, 19 Mar 2023 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679268712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=/0axrHMSXDjg2C1CC/vsX8eLd+F8Hj2Y/pL1QGxJv9E=;
        b=T7bFspMQ0vUhWdlylwyzePo6Be8Olel3psiws75iZTgK9LqEhSqKJjEI73MTZbQn/QTlkQ
        8IfzQAK6RjiF/3aKSiSFvWrWciDdYhpwXgg7avHfg1K+nntg93Kr+Nw1eHwgYQcsJ7pHR3
        UJ5dL/9+8v2u4Xj0dhaqUQyKzjlqfno=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-Ztbdl2HEMrCK4-6G4XBsLA-1; Sun, 19 Mar 2023 19:31:47 -0400
X-MC-Unique: Ztbdl2HEMrCK4-6G4XBsLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D36318533DC;
        Sun, 19 Mar 2023 23:31:46 +0000 (UTC)
Received: from localhost (unknown [10.22.16.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA1E735454;
        Sun, 19 Mar 2023 23:31:45 +0000 (UTC)
Date:   Sun, 19 Mar 2023 20:31:44 -0300
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
Subject: [ANNOUNCE] 5.10.175-rt84
Message-ID: <ZBebYGllb3f9sOOS@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.175-rt84 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 1c5659f2537a53385ff1504414f2535ae12f477b

Or to build 5.10.175-rt84 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.175.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.175-rt84.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

