Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4224AC4332F
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Dec 2022 23:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLHXrd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Dec 2022 18:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLHXrb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Dec 2022 18:47:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F762DEB
        for <linux-rt-users@vger.kernel.org>; Thu,  8 Dec 2022 15:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670543197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=YUuVX5pGBpzQB+Sajapk9rjd/SXMnXyRzbwbKwzwmfc=;
        b=gxEkpbRi309DByyHTQkKubVzP+PXoE//bQ+nCSVHpMMaR5HNo3dTmSdy+tuQ66HtzdS0h7
        9Dl/5yGuaqkN+oAKhlcgLa/ingGE8V0QsiH7L20zY1A2mtvHzS1UvSKwDpbLfl6UERAC28
        14EvdW2dTs6ViaD2A3GjQOou4cBZCFk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-6YB2OAPZMoiFXzMPrlLqUw-1; Thu, 08 Dec 2022 18:46:34 -0500
X-MC-Unique: 6YB2OAPZMoiFXzMPrlLqUw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C19685A588;
        Thu,  8 Dec 2022 23:46:33 +0000 (UTC)
Received: from localhost (unknown [10.22.8.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71E3C492B04;
        Thu,  8 Dec 2022 23:46:32 +0000 (UTC)
Date:   Thu, 8 Dec 2022 20:46:29 -0300
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
Subject: [ANNOUNCE] 5.10.158-rt77
Message-ID: <Y5J3VWL85OkcQnrE@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.158-rt77 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 4338e86981d5e484d3ab085bc4a1715acced7096

Or to build 5.10.158-rt77 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.158.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.158-rt77.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

