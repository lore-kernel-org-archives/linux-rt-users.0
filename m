From: Brian Silverman <brian@peloton-tech.com>
Subject: problems with chained IRQ handlers
Date: Mon, 17 Aug 2015 18:41:55 -0700
Message-ID: <CAGt3f4k=-TW2qVhqMFk7U22NGZToZ5bxi1qVuUqcVRKqjhBbMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35016 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbHRBmZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Aug 2015 21:42:25 -0400
Received: by igbjg10 with SMTP id jg10so69657315igb.0
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Aug 2015 18:42:24 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Chained IRQ handlers are always marked IRQ_NOTHREAD, which means
forced threading doesn't apply to them. I think this means they can't
safely use non-raw spinlocks under CONFIG_PREEMPT_RT_FULL. Is this
correct?

I have an ARM system with a CONFIG_PREEMPT_RT_FULL kernel which prints
lockdep warnings from many places because of this. It also locks up
under moderate load, which I think is related to this issue. Any
suggestions?

Thanks,
Brian Silverman
