From: Piotr Gregor <piotrgregor@rsyncme.org>
Subject: Ubuntu 16.04 with Intel i7-6700
Date: Thu, 10 Nov 2016 00:39:32 +0000
Message-ID: <CAK+oA4U8=YwZb5ewpZSDRO+FPv1EgvvbSgoumdooaunTXKsjCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yb0-f176.google.com ([209.85.213.176]:33834 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbcKJAjd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Nov 2016 19:39:33 -0500
Received: by mail-yb0-f176.google.com with SMTP id d59so46973133ybi.1
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Nov 2016 16:39:33 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT users,

I am working on a simulation system. This system uses
several simulation modules for generating of video, navigation, motion,
digital and analog signals.
The data must be generated deterministically to assert proper
synchronization
with peripherals. These external instruments are accessed via PCI HSD
interface.
This is outdated technology but it must be used, because this is what these
specialized instruments use and replacing the link is not the case, this
must be HSD. I have driver for PCIHSD but for 2.4 - 2.6 kernels, this must
be ported.

It is said that simulation software would ideally run on Ubuntu and
motherboard
with Intel Core i7-6700 is proposed (very likely with SSD and DDR 4 RAM).
I have patched recent version of Ubuntu - Ubuntu 16.04 LTS
with recent rt preempt patch patch-4.4.27-rt37 and I can boot to new kernel.
In the next step I will measure the worst case latency using cyclictest
utility
and I will check overall system's performance. Results will be reported.

What is your experience with Ubuntu (16.04)
and rt preempt.
What is your experience with rt preempt and Intel Core i7-6700?
Is there any definite "no" for Ubuntu as a real-time operating system?
Would it be better to start from Debian?
I would appreciate if you could share related information.

cheers,
Piotr
