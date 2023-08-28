Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D1C83F12
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Aug 2023 22:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjH1WhZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjH1WhY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Aug 2023 18:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412D9D2
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Aug 2023 15:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693262197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=x0WrWIrJdKQexUzOSkzL5xgVm52oMggI5IfEY5JG+IQ=;
        b=X0uyMKqXla4X48apsfdphgb6erWWb1cICr9iUCFYPOJTWtIM+Fzh29J7PiXd18Awn+lASn
        IWLY/a+gA8AcGRsmNBmawMTiDm25gvBASIuxIj3VNy0ky/qc35XFn37dWgfpFwPaGzAtEZ
        mLIpXtUFqXrdEuAU98sB6IidXbqk7EA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-jvzyGiVsOgmjHXX69O6m_A-1; Mon, 28 Aug 2023 18:36:35 -0400
X-MC-Unique: jvzyGiVsOgmjHXX69O6m_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E96733801BD0;
        Mon, 28 Aug 2023 22:36:34 +0000 (UTC)
Received: from localhost (unknown [10.22.32.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10D24140E962;
        Mon, 28 Aug 2023 22:36:33 +0000 (UTC)
Date:   Mon, 28 Aug 2023 19:36:33 -0300
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
Subject: [ANNOUNCE] 5.10.192-rt92
Message-ID: <ZO0hcedb0m3Ey0Dy@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.192-rt92 stable release.

This release is just an update to the new stable 5.10.192
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: a7fe2ad8ced572fc9fe4fc75168b9857e2d7e1ae

Or to build 5.10.192-rt92 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.192.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.192-rt92.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

