Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF5FEB64DA
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jun 2023 13:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjFSNdS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Jun 2023 09:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjFSNdL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Jun 2023 09:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1576FCA
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Jun 2023 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687181544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=IUyPzN8rj0g+BGc2421cvQpeD4oh7TotkjT0PBc1A7M=;
        b=diYFXxj6tcUZfi9Cf4M7PQH1Jw49E6mQxqcv/IUDfRKKkiM+QThFjsLyBj87AsHpDTvBbx
        wAnsZmYGBpStLz/TQY14cNIka3r2K/NCR0tdPJ2LciQnPMEmtLp7GUdyZcDkcXeCs1V8pF
        VyYxSLFcZhsjxMDGP+ebgDpNRycgmvc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-G5ePdKLNNFyndmZ-rNQ-PQ-1; Mon, 19 Jun 2023 09:32:19 -0400
X-MC-Unique: G5ePdKLNNFyndmZ-rNQ-PQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E22A3C0ED4B;
        Mon, 19 Jun 2023 13:32:18 +0000 (UTC)
Received: from localhost (unknown [10.22.8.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5C17492C1B;
        Mon, 19 Jun 2023 13:32:17 +0000 (UTC)
Date:   Mon, 19 Jun 2023 10:32:16 -0300
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
Subject: [ANNOUNCE] 4.14.318-rt150
Message-ID: <ZJBY4M7OphS5TdaY@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.318-rt150 stable release.

This release is just an update to the new stable 4.14.318
version and no RT specific changes have been made.

This release has been tested under the tag v4.14.318-rt150-rc1 at:

  https://linux.kernelci.org/test/job/rt-stable/branch/v4.14-rt-next/kernel/v4.14.318-rt150-rc1/

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 2b72b2d92cb5341e82ca200af6dfef63252f6d43

Or to build 4.14.318-rt150 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.318.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.318-rt150.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

