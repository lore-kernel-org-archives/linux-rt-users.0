From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: 4.4.23-rt33: High latencies when settings RCU_KTHREAD_PRIO equal
 or higher than rt application priority
Date: Wed, 19 Oct 2016 16:55:41 +0200
Message-ID: <CALqGcGqcr94=9_0bfovYhxiF+iNyKpP66Z5XXWQZ9xb-VowBHQ@mail.gmail.com>
References: <CALqGcGopV+Za7ahfBqneXbfBPPo8GdtqNt0VppsF-5aYpmmW-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:37641 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943376AbcJSOzn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Oct 2016 10:55:43 -0400
Received: by mail-it0-f50.google.com with SMTP id m138so30550326itm.0
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Oct 2016 07:55:42 -0700 (PDT)
In-Reply-To: <CALqGcGopV+Za7ahfBqneXbfBPPo8GdtqNt0VppsF-5aYpmmW-g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Using glmark2 helps greatly to reproduce this on my dual core system.

I tried out different kernel versions:
- 3.18.42-rt45 seems to be OK.
- 4.1.2-rt1 was bad.
- 4.8.2-rt2 is still bad.
