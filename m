Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C2BC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Apr 2022 20:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349900AbiDKUlw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Apr 2022 16:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbiDKUlv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Apr 2022 16:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47641CFF1;
        Mon, 11 Apr 2022 13:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A56B615EB;
        Mon, 11 Apr 2022 20:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314E0C385A4;
        Mon, 11 Apr 2022 20:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649709572;
        bh=XLIf4zoqUn/vAcbQLvEyIomVh9fJYy3IUmn8vUBhetA=;
        h=Subject:From:To:Date:From;
        b=J5E7YfYaR5U1J54qJE2g691tLqK48j3Ttas2G85bFEVC92rnVtengnTz5r0Y/ET1/
         YYT8v7XqE3h41GULEO35ERO/6JALdBSF/bwLmhgIsNNKP/q/mrN66KYkG2a+q2IQ+L
         5eGOMuA5oRgrjfbUkw7anik1zHgLTclg4gap4h6AHZjcnOrQmW6DHYNzIN5Za8vDgE
         +i3pDASqomMeA9q3fsHzryeKotAfRr8cou5ccrn5b3fJ8RE85M+crfhTVBrUs0oc6s
         KjnneLDMdW5dGG1J8Oh8kJC724iib2DEBBMroDVhyU57htz67TWeHM9n+DsSt4utOW
         mcjZFC9lMPlfA==
Message-ID: <eeb57bbe5f26a437260ff9032928c4d7edc83fbb.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.188-rt73
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Mon, 11 Apr 2022 15:39:29 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.188-rt73 stable release.

This release is just an update to the new stable 5.4.188
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: a643cd5066c215e4454b4b5d7d5707cbd778908b

Or to build 5.4.188-rt73 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.188.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.188-rt73.patch.xz

Enjoy!

   Tom

