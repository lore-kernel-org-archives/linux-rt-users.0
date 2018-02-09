From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Linux stable vs RT stable and RT dev
Date: Fri, 9 Feb 2018 20:30:16 +0100
Message-ID: <20180209193015.wms4o7wxsi3t535g@linutronix.de>
References: <8155aea247374c058bd7c797124c3d28@ti.com>
 <20180202214611.GD868@jcartwri.amer.corp.natinst.com>
 <1c47b7e6-86d0-cbb0-9b72-7b7d63e46ddc@ti.com>
 <6eecb69a-e60f-f837-bc2c-a627e2660027@ti.com>
 <20180206143426.fdzs6hnvmakqdwiu@linutronix.de>
 <8e201971-d626-7ef6-addd-bbbc32f63770@ti.com>
 <20180209173921.mtz55hgs5idj4vhk@linutronix.de>
 <a1c7a58e-2d67-f6fd-6e91-9cbd03678e7d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Mills <wmills@ti.com>, Julia Cartwright <julia@ni.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>, rostedt@goodmis.org,
        "Hernandez, Carlos" <ceh@ti.com>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>
To: Dan Murphy <dmurphy@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35007 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbeBITaT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Feb 2018 14:30:19 -0500
Content-Disposition: inline
In-Reply-To: <a1c7a58e-2d67-f6fd-6e91-9cbd03678e7d@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2018-02-09 12:59:43 [-0600], Dan Murphy wrote:
> Sebastian
HI Dan,

> Hmmm I wonder why the compiler does not complain about this warning then.
> 
> I will look into it.  This warning has been around for a while (4.9-rt as well).

probably once the local_irq_save() was removed.

> We also noticed that there are 2 merge conflicts when going to 4.14.18.
> Any comments about providing a merge conflict email to the list?

I am not sure about how helpful this actually is. Usually I do a RT
release a week while I have stuff in my pipe. Currently Greg is
releasing a lot. On the other hand it is almost two weeks since my last
release.

> Attached is the merge conflicts we are seeing 4.14.15-> 4.14.18

In meantime I already uploaded the patch queue for v4.14.18-rt14.
I plan to sync with Steven's tracing then release -rt15 probably later
today.

> Dan

Sebastian
