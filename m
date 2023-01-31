Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC61C54EAA
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Jan 2023 00:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjAaATX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Jan 2023 19:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjAaATE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Jan 2023 19:19:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA9C659
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Jan 2023 16:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675124300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=39hxHqbfr6Ee10w1IwoFvohjZhArDKGOQzbMUZIMMyg=;
        b=PNRYcDq0Ifc5i+6BFR4kTbqlHeo6C9Msqa/Q/iduuHUK4pmuzuST11ezJSV5IQ6lvFf5qL
        Co94VusoK30wzGJGkq+jZ5C4CotYIB2+Oc3zjglq09ZvLe8MsSl3oNp+tYsvNJJ9a4/74y
        MfaX+6SmJGX7RL/vkP36bLfPaleywco=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-wnYBeXxsPdWtxRzFqF5AYA-1; Mon, 30 Jan 2023 19:18:15 -0500
X-MC-Unique: wnYBeXxsPdWtxRzFqF5AYA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99D40855304;
        Tue, 31 Jan 2023 00:18:14 +0000 (UTC)
Received: from localhost (unknown [10.22.34.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C415B492B05;
        Tue, 31 Jan 2023 00:18:13 +0000 (UTC)
Date:   Mon, 30 Jan 2023 21:18:12 -0300
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
        Mark Rutland <mark.rutland@arm.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.165-rt81
Message-ID: <Y9heROlmtFkLFUIi@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.165-rt81 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 9831945c5ac7aafa7ed18026b149fe119b72c38a

Or to build 5.10.165-rt81 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.165.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.165-rt81.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

