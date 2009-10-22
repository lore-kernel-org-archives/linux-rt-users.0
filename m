From: fabio <fabio7774@gmail.com>
Subject: MIPS port
Date: Thu, 22 Oct 2009 11:23:45 +0200
Message-ID: <2cc9eb1b0910220223k6f04baemdf342e0182e48226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:42374 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbZJVJXl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 05:23:41 -0400
Received: by fxm18 with SMTP id 18so8920512fxm.37
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 02:23:45 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello ,

Can someone tell me how to gather this patch ?

Thanks a lot.



> RT_PREEMPT for mips/loongson2e is cleaned up and updated to
> patch-2.6.29.2-rt10.bz2, and a git branch
> linux-2.6.29-stable-mips-RT_PREEMPT is created for it.

> $ git clone git://dev.lemote.com/rt4ls.git
> $ git checkout -b linux-2.6.29-stable-mips-RT_PREEMPT --track
> origin/linux-2.6.29-stable-mips-RT_PREEMP
