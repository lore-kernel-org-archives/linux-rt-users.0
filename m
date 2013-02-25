From: Hartmut Behrens <hartmut.behrens@gmail.com>
Subject: cyclictest: Unable to set scheduling policy / join real-time group or
 run as root
Date: Mon, 25 Feb 2013 22:03:06 +0200
Message-ID: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:59345 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab3BYUDH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Feb 2013 15:03:07 -0500
Received: by mail-ve0-f182.google.com with SMTP id ox1so2586896veb.13
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Feb 2013 12:03:06 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT Folks,

After successfully patching a 3.2 kernel (gumstix platform) with
patch-3.2-rt10, I obtained the rt-tests suite from
git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git

I enabled CONFIG_PREEMPT_RT in menuconfig and disabled "CPU frequency scaling".

Compilation of rt-tests ("make all") on the platform is also successful.

When trying to execute cyclictest, the program reports: "Unable to
change scheduling policy! either run as root or join realtime group"

Looking in rt-utils.c, it appears that set_scheduler is unable to
select SCHED_FIFO scheduling policy.

Do you have any hints on how to fix this problem, or at least narrow
it down further? Could it

 Best Regards,
Hartmut Behrens
