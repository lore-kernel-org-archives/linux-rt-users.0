From: Brian Wrenn <dcbrianw@gmail.com>
Subject: kernel 4.9.39
Date: Tue, 19 Sep 2017 23:13:56 -0400
Message-ID: <CAEYdEeRhQ+OTQcuM4a0pTQ4JkVNftp6Q8jwQDD4hMS9JFzHR+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:56909 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdITDN5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Sep 2017 23:13:57 -0400
Received: by mail-it0-f51.google.com with SMTP id g18so1606116itg.5
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Sep 2017 20:13:57 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

my project is currently running 4.4.9 with the PREEMPT-RT patch.  We
may need to upgrader our kernel.  We're constrained by the vendor of
our SOM in what kernels we can use, and at this time and the
foreseeable future, we only can use 4.9.34 or 4.9.39.  I looked on the
PREEMPT-RT site's list of patches, but I don't see one for either of
those versions.  Just for the sake of trying, I attempted to patch
4.9.39 with 4.9.40-rt30, but to no surprise that failed.

Do I have any other options?  Does a non-published PREEMPT-RT patch
that would successfully patch 4.9.39 exist somewhere I haven't looked?

Thank you for any help,
Brian
