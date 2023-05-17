Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E232C7EE22
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 May 2023 22:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEQW76 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 May 2023 18:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEQW75 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 May 2023 18:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC14B5B9C
        for <linux-rt-users@vger.kernel.org>; Wed, 17 May 2023 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684364354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=SOwdRo7bGyis+T1dTZ83SVzvz6kq6SfQYfvWoU30evc=;
        b=Nu8O7Z7SOhTw3Ywyseh+GsRbRqDbJApa7CDvKRoRB/djHHa3ixciSz7mDvGeS7dh8rXAOh
        oLRotucw7nWj+xxrFmnUtnm8Mxw0gO65qeMqIizP/QMkV30J+vYqpGRk+z5pjRznl+Bfox
        WsSnWpFkR0mXIzNIwbUzFxSEPjgmJwU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-kTAM3XbDN7izXYEYpkV8dg-1; Wed, 17 May 2023 18:59:08 -0400
X-MC-Unique: kTAM3XbDN7izXYEYpkV8dg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 417643810B01;
        Wed, 17 May 2023 22:59:08 +0000 (UTC)
Received: from localhost (unknown [10.22.32.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD1B9C15BA0;
        Wed, 17 May 2023 22:59:07 +0000 (UTC)
Date:   Wed, 17 May 2023 19:59:06 -0300
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
Subject: [ANNOUNCE] 4.14.314-rt147
Message-ID: <ZGVcOnPxSaxGmWj2@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.314-rt147 stable release.

This release is just an update to the new stable 4.14.314
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 1e893daaffe2051b5b6e0b572fb37c4e5bfff31b

Or to build 4.14.314-rt147 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.314.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.314-rt147.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

