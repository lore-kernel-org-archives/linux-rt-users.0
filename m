Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B74BC433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Mar 2021 02:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DAED61939
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Mar 2021 02:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCVCu2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 21 Mar 2021 22:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhCVCuR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 21 Mar 2021 22:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616381416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=VjX07ZbhlhI+8MjhLml7rCwP/VgEHcwbPYVTLJX166Q=;
        b=WuaoG+1Rn6rv9D0MS8y0iDnCcOBKd+RKzivMW85U7Kr2bziPWYnvZTqy6cfkdbJn5UJi3S
        MIRRQntUrxKYHEspvf3csb1Ad9wKroFXHjEGRITXFcH8uAOZo7HVvxw/2gW5dh9Kah8Nic
        7YoIZDiz0iw41mNY0QvTJleMUlSGBm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-df3rL3VLOwSLtoNmAXisFQ-1; Sun, 21 Mar 2021 22:50:13 -0400
X-MC-Unique: df3rL3VLOwSLtoNmAXisFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0B271007476;
        Mon, 22 Mar 2021 02:50:11 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-117-44.rdu2.redhat.com [10.10.117.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DF166C353;
        Mon, 22 Mar 2021 02:50:11 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 61AB43C1752; Sun, 21 Mar 2021 23:50:09 -0300 (-03)
Date:   Sun, 21 Mar 2021 23:50:09 -0300
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
Subject: [ANNOUNCE] 4.9.258-rt172
Message-ID: <161637899106.442154.4932837797391662221@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.258-rt172 stable release.

Note that there was a futex/mutex code collision during the merge of v4.9-257
and another one with the merge of v4.9.258. Even though I believe that it's
fixed correctly, anyone with suspicions about futex/rtmutex behavior in these
releases should consider starting investigating there.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 417c1df254de98957caae5f4e31337cdd6ae063e

Or to build 4.9.258-rt172 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.258.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.258-rt172.patch.xz

Enjoy!
Luis

