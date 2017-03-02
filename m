From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Problem with hrtimer_cancel() does not cancel timer
Date: Thu, 2 Mar 2017 09:19:33 +0100
Message-ID: <20170302081933.czgffbohgplwgdpl@linutronix.de>
References: <20170218011522.09d42119@brick.gerasiov.net>
 <20170301150103.4ttnvz72d4jsgui6@linutronix.de>
 <20170302024808.7f5f29d9@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, zlobin_d@redlab-i.ru
To: Alexander Gerasiov <gq@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42734 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754320AbdCBJGU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Mar 2017 04:06:20 -0500
Content-Disposition: inline
In-Reply-To: <20170302024808.7f5f29d9@brick.gerasiov.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-03-02 02:48:08 [+0300], Alexander Gerasiov wrote:
> Hello Sebastian,
Hi Alexander,

> Great! Looks like the problem is solved.

Thanks for the confirmation.

> When submitting patch to git, take a note, that not only 4.4 is
> affected. I'm quite sure, that 4.1 was affected too when I tested it and
> Dmitry comfirmed 4.9 is also broken.

I am going to push it to v4.9 and Steven will pull into v4.4 while doing
his regular stable updates. v4.8 is probably also affected but that one
is no longer maintained.

Sebastian
