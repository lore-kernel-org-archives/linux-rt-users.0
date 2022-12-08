Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E08C4332F
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Dec 2022 23:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLHXxH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Dec 2022 18:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiLHXxE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Dec 2022 18:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B0F7A190
        for <linux-rt-users@vger.kernel.org>; Thu,  8 Dec 2022 15:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670543529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=zD6+9DSN0fQYGK7Svi5vaF3C/B1oc2mZJL3F+NbTTeU=;
        b=DdqVqpjAkjHVEJrQu76Doqf5W5damAckW24Y3pJta7hC1ASEnw/veEPE9PB+4AjRegI74l
        G+gSRU2fpdJsmmug038R3UTaVO7p/CUeTsN5pCvMFRR50nLC/WG9VNXJnJ0y5T6tCmQUqQ
        N/wrjpEjLwrtFCrCa857c9u0dE8LSck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-uN5KheS5NiSaILDcqW0iMQ-1; Thu, 08 Dec 2022 18:52:04 -0500
X-MC-Unique: uN5KheS5NiSaILDcqW0iMQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BA71101A528;
        Thu,  8 Dec 2022 23:52:04 +0000 (UTC)
Received: from localhost (unknown [10.22.8.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB77B4B3FC6;
        Thu,  8 Dec 2022 23:52:03 +0000 (UTC)
Date:   Thu, 8 Dec 2022 20:52:00 -0300
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
Subject: [ANNOUNCE] 4.14.301-rt141
Message-ID: <Y5J4oEv28xn7P7TU@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.301-rt141 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 2768f0413cf3e2bbaa939b53ddf3550367882d7b

Or to build 4.14.301-rt141 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.301.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.301-rt141.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

