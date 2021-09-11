Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AE0C433EF
	for <linux-rt-users@archiver.kernel.org>; Sat, 11 Sep 2021 20:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B180360FDC
	for <linux-rt-users@archiver.kernel.org>; Sat, 11 Sep 2021 20:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhIKUx6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 11 Sep 2021 16:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhIKUx6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 11 Sep 2021 16:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631393564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=GXO6YsIAMbLq0VJ5Vdvx1z0f/QMqeuA6CKdPl6ykaVw=;
        b=aCRatXdcthkt0tFDWlzOvqW02dzspA2R9/7QQe02sTEgxqwIBcGdGNinK2THuu/3SZamYP
        L0SIb/iJ5BhnGQYOoV1ruV1hFaL+3/sr5ugVz87fwF4i9nH19Es+qVkZkaTVo/9JgkYJ55
        naGIWjpW42UGd6CvtNFhLnG3l7FMuQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-TFpHr7NTPiCdEcTU6NKW0g-1; Sat, 11 Sep 2021 16:52:43 -0400
X-MC-Unique: TFpHr7NTPiCdEcTU6NKW0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85B108015C7;
        Sat, 11 Sep 2021 20:52:41 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.32.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E4425D9D5;
        Sat, 11 Sep 2021 20:52:40 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 4ACF63C0205; Sat, 11 Sep 2021 17:52:39 -0300 (-03)
Date:   Sat, 11 Sep 2021 17:52:39 -0300
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
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.9.282-rt187
Message-ID: <YT0XF3yghXjRKISP@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.282-rt187 stable release.

This release is just an update to the new stable 4.9.282 version and
no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: e56d0ebcd94b189a63e6852d14fcc94f997854ce

Or to build 4.9.282-rt187 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.282.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.282-rt187.patch.xz


Enjoy!
Luis

