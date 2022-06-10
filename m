Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5DCC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jun 2022 17:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346502AbiFJR4G (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jun 2022 13:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350226AbiFJR4F (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jun 2022 13:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B67766213B
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jun 2022 10:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654883762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=LjOxEXCNnEpBGxwK7AJ1zjh6I68BRDvkLmj759bnQFw=;
        b=YsGzBbqFJr2WKES2X8IlNDbqHqm5XvTGQUsxTrZCXf3EKe8Ulrq9WgauoayRGNUVoU6SZB
        3YqA71TAsfvLmFPfMhHIxNDaBxN7EoAVrHW8ffuEqc1ooEXFUVvnxKQmgUpjmG1NjsOh3I
        dqH58rjnEiTIO/2H2KfSnNSRLd0d4+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-IrE3hS3VN_-H3Wt6_1iFPQ-1; Fri, 10 Jun 2022 13:55:58 -0400
X-MC-Unique: IrE3hS3VN_-H3Wt6_1iFPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F41F185A79C;
        Fri, 10 Jun 2022 17:55:58 +0000 (UTC)
Received: from localhost (unknown [10.22.8.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D561D40CFD0A;
        Fri, 10 Jun 2022 17:55:57 +0000 (UTC)
Date:   Fri, 10 Jun 2022 14:55:57 -0300
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
Subject: [ANNOUNCE] 4.14.282-rt135
Message-ID: <YqOFrc3UjP+nVxAA@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.282-rt135 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 9b4c91040ecbf75bb8768593b3cdad7a08b071a1

Or to build 4.14.282-rt135 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.282.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.282-rt135.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

