From: Sebastian Andrzej Siewior <sebastian@linutronix.de>
Subject: Re: Kdump not working with rt patch, tested under
 4.4.32/4.4.79/4.9.40
Date: Fri, 18 Aug 2017 14:16:37 +0200
Message-ID: <20170818121637.k4s3htlfmv2363du@linutronix.de>
References: <CAF6bL9=e4Ah6iwmvj+PponVgYaSGKYJ1WW98sZgvAY9cK8_9Eg@mail.gmail.com>
 <20170809153524.GY8384@jcartwri.amer.corp.natinst.com>
 <CAF6bL9k1zzPR6Y7-LrSXSqBc2S-v+zspb+1JLvSamrF+Zcd3OA@mail.gmail.com>
 <CAF6bL9mRqHqf8tdGk53EHwRnHM_BSbpSWMechfHh4OJJz_XMRQ@mail.gmail.com>
 <5985de84-db52-05d9-5899-95b9bbecf91a@mvista.com>
 <CAF6bL9k+k-d+xvVpKm7eP2eVkWT+uWXtXfm6ubgR5xYkY6mZrw@mail.gmail.com>
 <CAF6bL9msL8moMG1FKtZXp5vf5pP60kxc33609j8zfOY1Pn5m8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Corey Minyard <cminyard@mvista.com>,
        Julia Cartwright <julia@ni.com>, linux-rt-users@vger.kernel.org
To: Journey Journey <journeywang123@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41845 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbdHRMQk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Aug 2017 08:16:40 -0400
Content-Disposition: inline
In-Reply-To: <CAF6bL9msL8moMG1FKtZXp5vf5pP60kxc33609j8zfOY1Pn5m8Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-08-18 14:51:09 [+0800], Journey Journey wrote:
> Hi all
> 
> Any updates ? If anyone can show me an example to trigger softlockup
> detector under rt kernel, I'll be very glad.

a thread that recevies no wake ups and does this:

	set_current_state(TASK_UNINTERRUPTIBLE);
	schedule();

should trigger the printk warning after 120secs.

> Thanks all

Sebastian
