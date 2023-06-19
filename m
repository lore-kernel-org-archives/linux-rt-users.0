Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAF7EB64DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jun 2023 14:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjFSOQi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Jun 2023 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFSOQg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Jun 2023 10:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6093B8
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Jun 2023 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687184150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=szFwNVj7FocmAbg+wX1oALpVqaDR+gblq+HEqVQ9CGM=;
        b=aBrKV3LAzTwzhjuuuf+JgMAxDNRGAZA/PNFMqo31NoWp285Gn6v40TDWUPR4cRA5QXhJlY
        oSpnBxtP+w/C9xiZ16HqavYZArEHp4512eYHJN8lOW7HnbvHxah6xv5TvbueQ/sjm7mo1y
        FJwdl971UyEIsnlp8KCWnB0wb10Bhis=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-1eLVCzz8MI2daKr5f13JwQ-1; Mon, 19 Jun 2023 10:15:49 -0400
X-MC-Unique: 1eLVCzz8MI2daKr5f13JwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B395C3C108E6;
        Mon, 19 Jun 2023 14:15:48 +0000 (UTC)
Received: from localhost (unknown [10.22.8.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7F4D10CE7;
        Mon, 19 Jun 2023 14:15:47 +0000 (UTC)
Date:   Mon, 19 Jun 2023 11:15:46 -0300
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
Subject: [ANNOUNCE] 5.10.184-rt90
Message-ID: <ZJBjEt+XxB9SmKLK@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.184-rt90 stable release.

This release is just an update to the new stable 5.10.184
version and no RT specific changes have been made.

This release has been tested under the tag v5.10.184-rt90-rc1 at:

  https://linux.kernelci.org/test/job/rt-stable/branch/v5.10-rt-next/kernel/v5.10.184-rt90-rc1/

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 4c0096468c71420c3ee30681322ef6c086e629fc

Or to build 5.10.184-rt90 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.184.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.184-rt90.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

