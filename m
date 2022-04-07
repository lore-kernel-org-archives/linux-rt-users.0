Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E5C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Apr 2022 03:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbiDGDpN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 6 Apr 2022 23:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240651AbiDGDpK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Apr 2022 23:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1928D17AB9
        for <linux-rt-users@vger.kernel.org>; Wed,  6 Apr 2022 20:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649302989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=cfKgZ6AY3LeIysTWwWJsXG6BzUaWm1TUgPVGovOOdVk=;
        b=DHB/w2Bqhpokr8BqpxtBKXr/VVLHKGroZYKLCNPSJhaFbYj+rAHflLwOE6QqzLwwKjCHTc
        hLMP+3Sv5NBlfRRXxMYasfht4tncKE28q2Emq2WqFb+D7ADrMqNSK+uK5TTusv+zvdRBbE
        4Wz1ge4blgQH7QN87GxrjrQCvhlcwt0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-9kpN9-JEMRaSq_AnWXKksw-1; Wed, 06 Apr 2022 23:43:04 -0400
X-MC-Unique: 9kpN9-JEMRaSq_AnWXKksw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B07471010364;
        Thu,  7 Apr 2022 03:43:03 +0000 (UTC)
Received: from localhost (unknown [10.22.17.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86C7F2026985;
        Thu,  7 Apr 2022 03:43:01 +0000 (UTC)
Date:   Thu, 7 Apr 2022 00:43:00 -0300
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
Subject: [ANNOUNCE] 4.14.275-rt132
Message-ID: <Yk5dxFR0UMVfSE4z@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.275-rt132 stable release.

This release is just an update to the new stable 4.14.275
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: cc59b40e43634e926044107ac129a67d55672ae8

Or to build 4.14.275-rt132 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.275.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.275-rt132.patch.xz


All keys used for the uploads can be found on the following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git


Enjoy!
Luis

