From: Brian Wrenn <dcbrianw@gmail.com>
Subject: mmap paging problems
Date: Fri, 10 Feb 2017 19:48:26 -0500
Message-ID: <CAEYdEeTq+exUaXK7vifQbPCOoJ-mpnQcW89Mxow31BX3St=AgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:36904 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdBKAs1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Feb 2017 19:48:27 -0500
Received: by mail-it0-f43.google.com with SMTP id x75so5213741itb.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Feb 2017 16:48:27 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have a kernel module running within Linaro 4.4.9 with PREEMPT RT 17.
Within that module I attempt to transfer data from the kernel module
to user space.  The user space application does not run real-time,
just in plain Linux user space.  With each attempted run I get a
kernel dump that begins with the following:

Unable to handle kernel paging request at virtual address <some address>

I'm using mmap in a fairly straightforward way.  Basically, upon an
IOC command from the user space application to the kernel module, the
kernel module attempts to copy data into the memory mapped area.  I've
checked, double checked, and triple checked that I'm not writing to a
bad address or an address outside of the mmap'ed area.

Are there some special (special in the sense of in addition to or
instead of the way done for a non-PREEMPT-RT kernel) things one must
do to safely write mmap'ed data within a PREEMPT RT kernel?

Has anyone else encountered this problem?

Thanks for any help.

-Brian
