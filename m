From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: 2.6.26.5-rt9 without PREEMPT RT gives undefined reference to `kernel_sem'
Date: Mon, 22 Sep 2008 01:24:55 +0200
Message-ID: <c384c5ea0809211624h5680ac73sf3385eee16192669@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Linux-RT Kernel List" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:45724 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbYIUXY5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 21 Sep 2008 19:24:57 -0400
Received: by gxk9 with SMTP id 9so2432109gxk.13
        for <linux-rt-users@vger.kernel.org>; Sun, 21 Sep 2008 16:24:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Minor issue while I was disabling PREEMPT RT and re-compiling:

When compiling 2.6.26.5-rt9 for ARCH=powerpc with Desktop preemption I get this:

| kernel/built-in.o: In function `rt_mutex_slowlock':
| rtmutex.c:(.sched.text+0x1eca): undefined reference to `kernel_sem'

Not an issue I suppose. Most people applying -rt would build with
PREEMPT RT. :-)

Regards,
-- 
Leon
