Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EBDC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Feb 2022 21:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiBGVHz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbiBGVHg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Feb 2022 16:07:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9C1C03FECD;
        Mon,  7 Feb 2022 13:07:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F9E36157D;
        Mon,  7 Feb 2022 21:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98786C004E1;
        Mon,  7 Feb 2022 21:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644268054;
        bh=0D9zl9T0nifOPllt3EEz7/ZkVSckvYyWEuQdhMovzaU=;
        h=Subject:From:To:Date:From;
        b=lYNf/BzI/LV+ySOf1HAX35zCBzv8SpZHGmnvHr09MM4BAFCpYOeP1PA0I0cbcULCn
         5JCyRi8URx4uXRzZLxfjGzSVqQF/QoEYjI6YWFuZrj81f2yrcTMFIHa45SsfK45E4j
         5jY6m5DLZz9e1oICam9xkAPvKsz+c9QSZixqeGrmndtRFgJjo93uPaQSun+S/f3uIU
         bvi6+K1iGI3h8G5RLJYDOEYVcu9ZxsHwgiWWzyOfbTq2zk3hCbi2+FN9E+utSA8pRZ
         ItZu2D+qA3PPg4Ha9qUMczqA2S5CYKfPh7ro6f60kNDF4l/1lG9Zj/6i0sHjbwiuX2
         r16JvpVOReEuA==
Message-ID: <c5418cb9f6a6a6b62427c2c764fa3977072b83f2.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.177-rt69
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
Date:   Mon, 07 Feb 2022 15:07:32 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.177-rt69 stable release.

This release is just an update to the new stable 5.4.177
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 89f917be5b200b307e0830d1b3f639da0e15d6a3

Or to build 5.4.177-rt69 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.177.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.177-rt69.patch.xz

Enjoy!

   Tom

