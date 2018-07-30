Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34931 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbeG3U70 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Jul 2018 16:59:26 -0400
Received: by mail-oi0-f44.google.com with SMTP id i12-v6so23418968oik.2
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Jul 2018 12:22:59 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Doyle <wpdster@gmail.com>
Date: Mon, 30 Jul 2018 15:22:32 -0400
Message-ID: <CAF_dkJC2UqpDVGzF4K575_hZYii_-OL6H1h=nNO8mTQm4QK2SQ@mail.gmail.com>
Subject: How to apply RT patches to a kernel not listed in http://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

I have a choice of 4.9.87 or 4.9.109 in my vendor supplied kernel to
which I would like to apply an RT patch set.  Unfortunately, neither
kernel is listed as a target kernel for the patches archived at
http://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/.  Also
unfortunately, patch sets from nearby versioned kernels (such as
patch-4.9.84 and patch-4.9.98) do not apply cleanly.

What would you (the ever helpful experts that live in the internet,
always willing to offer advice) suggest that I do to address my
dilemma?  Should I take the most recent (probably 4.9.98/rt76) branch,
rebase it on 4.9.109, clean it up as best as I can (basically, get a
kernel that compiles, and hopefully even runs) and submit the rebased
patch set here for your review?

(That's what I'm going to do, unless I hear a better idea).

--wpd
