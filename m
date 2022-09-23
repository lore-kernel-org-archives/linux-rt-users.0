Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1875C04A95
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Sep 2022 20:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiIWUDd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 16:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiIWUDc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Sep 2022 16:03:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD02121E57;
        Fri, 23 Sep 2022 13:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F657B83453;
        Fri, 23 Sep 2022 20:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDEDC433C1;
        Fri, 23 Sep 2022 20:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663963406;
        bh=qcGwU2kosIEkmm/G0/KPzLz7kUajGco16TdGpvtp2WE=;
        h=Date:From:To:Subject:From;
        b=qwe5nlIJy6gMcxjTSGCUQ2FoynPopJQT7I1lbTx2DKrctNdUZw4gSQVVrTu3XCwDC
         Fzbzx6pSk1OYek3nPPHOhwkSuDLDBGUraLc/wKKSecSo3/k5AMdPlDxjwtN1PrtRjK
         GCVDmpwZNALe3QBbbbcpS3jfWQsu2b9LSXiynSA5KlT9aYcZ0YCaIBnIvPvgh2z5AR
         TEKbi0Syq3aK09jU9eh4GVlwWJX5Ti3yiOWm0y6qIcc8GRvjcGRSC1TUDWtBgJXSZz
         mOQV2kLcbDvrEwSRVBfKg6ww1c1f0OoP/RyrpGw3vLI3bo5u6RA/NRh+eLGwZao8Vu
         dakwiD0dlkSsg==
Date:   Fri, 23 Sep 2022 13:03:24 -0700
From:   Mark Gross <markgross@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Danie l Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Junxiao Chang <junxiao.chang@intel.com>
Subject: [ANNOUNCE] 4.9.327-rt197
Message-ID: <165222469651.210737.17409564443317121708@T470>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org
Message-ID: <20220923200324.qfIr5LGyYCptMfCpL9PVdhjOJUpYctjXO6N3TnWRz3s@z>

Hello RT-list!

I'm pleased to announce the 4.9.327-rt197 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt-next
  Head SHA1: d47e3fd2615dbd0aa6eac3745cd209fdd93a868a


This rebase was a tricky one.  Sebastian provided some patches and I was too
dense to figure out where and how to apply them.  My colleague Junxiao did the
following and I replicated the steps.
1) convert the v4.9-rt-rebase branch into a quilt series.
2) applied the series to v4.9.327 skipping patches where changes to the random
number logic has conflicts.
3) apply the patches Sebastian provided.
4) git quiltimport and pushed it to the above branch.

It seems to compile and it passes the RT BAT testing Junxiao does.

As this was a tricky one I request people to give a good look over.


Enjoy!
Mark Gross

