Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0C4C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 Oct 2021 15:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41ACC61371
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 Oct 2021 15:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhJTPaN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 11:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhJTPaM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 20 Oct 2021 11:30:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D2FD6135F;
        Wed, 20 Oct 2021 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634743678;
        bh=DGupJCcngY6gud3AWyQVz0kudq1TLRwF5ZjDrAjKqYI=;
        h=Subject:From:To:Date:From;
        b=kH9CvPH0ebyVGNRD89vDi//W6Qi/08qTuMofP2qNpmLiix2xYJ0HUWlWHypRzDPD6
         4cLwlOukYxMxfq/TSJlEsZL73/LGEsshF4vi0Xm+kM7dkYd/sTvOh/VN3QqbSJ++M5
         wmo68d6dBgyR20nPtWGUR+wxGfZAaLVz/rPr/ahFtFhPRBOAEYCtF+fPTN/ngiC/I3
         9UotsNpj7ZynWYvjYbe7il3d+pp0Brzha9dzAzqWRkELJIoXufq3aBlZxlcC46AWFl
         8SBjhNrgdvbYNdN4I4aG7FZQjMtv9muxVghdVvxs+WG4Z/2uN2L8pn0FQCvegYe7dw
         mitXhYKPuBBMQ==
Message-ID: <1a2d8ac4f940ea8f6ac82cca384a17244062d7da.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.154-rt65
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
Date:   Wed, 20 Oct 2021 10:27:56 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.154-rt65 stable release.

This release is just an update to the new stable 5.4.154
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 2121f1ec675d1b776ad8595a64815cac975a5c26

Or to build 5.4.154-rt65 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.154.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.154-rt65.patch.xz

Enjoy!

   Tom

