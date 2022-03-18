Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2010C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Mar 2022 00:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiCRAax (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiCRAaw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Mar 2022 20:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 117FA25EB7
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2022 17:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647563374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=ykdqpOUYM+1dT8BIx3Ik/4nigxiRO/zKs1PrUkdRvt4=;
        b=hHY/CC/GLzrhQWIojinJ0KgDxPwVCtjthT+5skk4ziyhTNrlRrsQ761XRkuw67V7YlF87u
        s9u8t0JQnoyZi6FQZT+dBwCrs3Xak1Hdg7+nsLTsDVG9O+5zN6qyX4M9he/pWAQ4QHEaQl
        kgcj23WdLWZ/Im6LGj5wSNU5QXIOP7o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-HvkYXXqfPYKnAuFXCBPrVQ-1; Thu, 17 Mar 2022 20:29:31 -0400
X-MC-Unique: HvkYXXqfPYKnAuFXCBPrVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DE1C1C05AA5;
        Fri, 18 Mar 2022 00:29:30 +0000 (UTC)
Received: from localhost (unknown [10.22.16.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABE6740CFD05;
        Fri, 18 Mar 2022 00:29:29 +0000 (UTC)
Date:   Thu, 17 Mar 2022 21:29:28 -0300
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
Subject: [ANNOUNCE] 4.14.272-rt131
Message-ID: <YjPSaM/vQZSIEevU@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.272-rt131 stable release.

This release is just an update to the new stable 4.14.272
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 3fa9dae3226ce68ffe22fb190e9039e47491b93f

Or to build 4.14.272-rt131 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.272.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.272-rt131.patch.xz


All keys used for the uploads can be found on the following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git


Enjoy!
Luis

