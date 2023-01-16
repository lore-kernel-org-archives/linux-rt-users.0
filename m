Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8F8C54EBE
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Jan 2023 14:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjAPOUP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 09:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjAPOTh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Jan 2023 09:19:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A8D33450
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Jan 2023 06:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673877989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=qbzYSnwSva8DrB/+maCHZeYDyUJi3+5s8pET+IPrxa0=;
        b=fGiPzbtwmQhlsuL7gAp2vZTCViP/bpt7xM3rbtUm22Um3zP4ahe5SrCJTl16UAnsq0eNIi
        djlPyN1n+O5Ya9ThHmWfNG20S4a0fvpw7eyZB5+HfMNBAWaIzkf+kIyllYIYwFxNrwIGYG
        NO/XlbbPl1/JeyzegRLSMPrcSgUKPVI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-Nn_H03gZNy2FwKR2fs7Gog-1; Mon, 16 Jan 2023 09:06:25 -0500
X-MC-Unique: Nn_H03gZNy2FwKR2fs7Gog-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 005F81C0040C;
        Mon, 16 Jan 2023 14:06:25 +0000 (UTC)
Received: from localhost (unknown [10.22.32.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 731F9492B10;
        Mon, 16 Jan 2023 14:06:24 +0000 (UTC)
Date:   Mon, 16 Jan 2023 11:06:23 -0300
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
Subject: [ANNOUNCE] 4.14.302-rt142
Message-ID: <Y8VZ37C0V0iDiFGD@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.302-rt142 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 41e77dc931ef0d488a402edadc59ce311b528dd5

Or to build 4.14.302-rt142 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.302.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.302-rt142.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

