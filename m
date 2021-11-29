Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B07C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Nov 2021 22:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhK2W1D (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230029AbhK2W0m (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Nov 2021 17:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638224603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=zGLS20r6od8uIxQ3Yxo1UGys/tJAmQ4ql6Qw6nzKtRs=;
        b=GIYIpzFTS9xlIy5tQGLSZxatdQjIYVK082uj8i9kdgFlGEIuRlFIY6oi/GTqNlsCwEvNva
        T5LcnbFSOT/hVdLCo7JTp2hr7s19AyQ+m5wDFuIzGaX9pT4VRR/jNhuSAv53tMAdZG4PYf
        y4pccsFLyrMchrck2wgADOxN0ozKelU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-7ppv1JroOmSVP4HWSgMNMA-1; Mon, 29 Nov 2021 17:23:18 -0500
X-MC-Unique: 7ppv1JroOmSVP4HWSgMNMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3329B760C0;
        Mon, 29 Nov 2021 22:23:16 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.11.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DB8B45D93;
        Mon, 29 Nov 2021 22:23:14 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id B5F223C023B; Mon, 29 Nov 2021 19:23:12 -0300 (-03)
Date:   Mon, 29 Nov 2021 19:23:12 -0300
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
        Mark Gross <markgross@kernel.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.14.256-rt125
Message-ID: <YaVS0I2F3H/bUdKC@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.256-rt125 stable release.

This release is just an update to the new stable 4.14.256 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 54a94c77ba51f83c4a93beba57f3cb32c6dd694f

Or to build 4.14.256-rt125 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.256.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.256-rt125.patch.xz


Enjoy!
Luis

