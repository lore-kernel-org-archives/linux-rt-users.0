From: Vasiliy Gagin <vasiliy.gagin@gmail.com>
Subject: Building 4.9 RT kernel help
Date: Mon, 26 Dec 2016 15:01:01 -0500
Message-ID: <CAHS-zUEv6uBTR8yo9PPWvV8wEurG6ojaa9UjBT11yZ0abPEo6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34496 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbcLZUBD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Dec 2016 15:01:03 -0500
Received: by mail-qk0-f169.google.com with SMTP id h201so64543211qke.1
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Dec 2016 12:01:02 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I was able to build plain kernel v4.9.
It builds v4.9-rt1 fine too, but fails when I try to install it.

console message is
run-parts: executing /etc/kernel/postinst.d/dkms 4.9.0-rt1
/boot/vmlinuz-4.9.0-rt1
Error! Bad return status for module build on kernel: 4.9.0-rt1 (x86_64)

and there is following in make.log

KMS make.log for open-vm-tools-9.4.6 for kernel 4.9.0-rt1 (x86_64)
Mon Dec 26 14:09:03 EST 2016
/bin/sh: 1: test: -I./arch/x86/include: unexpected operator
Using standalone build system.
Makefile:167: Makefile.normal: No such file or directory
make[3]: *** No rule to make target 'Makefile.normal'.  Stop.
/bin/sh: 1: test: -I./arch/x86/include: unexpected operator
Using standalone build system.
Makefile:167: Makefile.normal: No such file or directory
make[3]: *** No rule to make target 'Makefile.normal'.  Stop.

I'm very new to the linux building process. Please Help
