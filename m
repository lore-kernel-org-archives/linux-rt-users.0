Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B6CC38A02
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 Oct 2022 00:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJaASX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 30 Oct 2022 20:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaASW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 30 Oct 2022 20:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493B6958A
        for <linux-rt-users@vger.kernel.org>; Sun, 30 Oct 2022 17:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667175445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=cno3VevIhcVUGIxiIeJg7OckKn+/Jx75RoNoh7/5qmc=;
        b=A75suH00SmoWSagCbDfrVg81mC3IqZLe2R57iGwZdSXrCSUrWxF3gn1Z47Xie/ptBTHosn
        1V6E8dTLPkZakUDw7C7YLqmo3CVyQ7UsndKYOtHr3xWINjW3fABl+XQhjrENkEl76iHk2Q
        XgWpCiEMmFnRtzWNVddEuuoEyvmn744=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-qRKIuXkLObuLp5BA-h26UA-1; Sun, 30 Oct 2022 20:17:22 -0400
X-MC-Unique: qRKIuXkLObuLp5BA-h26UA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 577F53C025A0;
        Mon, 31 Oct 2022 00:17:21 +0000 (UTC)
Received: from localhost (unknown [10.22.18.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A3611759E;
        Mon, 31 Oct 2022 00:17:20 +0000 (UTC)
Date:   Sun, 30 Oct 2022 21:17:19 -0300
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
Subject: [ANNOUNCE] 5.10.152-rt75
Message-ID: <Y18UDwitPIcEjPFg@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.152-rt75 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: b9458c61e205c0d72dd95e768fd790787425f9e8

Or to build 5.10.152-rt75 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.152.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.152-rt75.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

