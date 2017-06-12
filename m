From: gregkh <gregkh@linuxfoundation.org>
Subject: Re: v3.18.55-rt61 build: 0 failures 5 warnings (v3.18.55-rt61)
Date: Mon, 12 Jun 2017 16:09:38 +0200
Message-ID: <20170612140938.GA1241@kroah.com>
References: <E1dJ3Pb-0000JK-4q@optimist>
 <CAK8P3a35VW9gPyyxT4o6ca51hKAD+TvBpjVuNjnHNTZR4kM1tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Build bot for Mark Brown <broonie@kernel.org>,
        Kernel Build Reports Mailman List
        <kernel-build-reports@lists.linaro.org>,
        linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wagner <wagi@monom.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbdFLOJp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2017 10:09:45 -0400
Content-Disposition: inline
In-Reply-To: <CAK8P3a35VW9gPyyxT4o6ca51hKAD+TvBpjVuNjnHNTZR4kM1tg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jun 12, 2017 at 04:01:21PM +0200, Arnd Bergmann wrote:
> On Thu, Jun 8, 2017 at 9:48 PM, Build bot for Mark Brown
> >         ../arch/arm/include/asm/kmap_types.h:7:0: warning: "KM_TYPE_NR" redefined
> >         ../arch/arm/include/asm/kmap_types.h:7:0: warning: "KM_TYPE_NR" redefined
> 
> We should backport
> adec640e0366 ("mlx5: stop including <asm-generic/kmap_types.h>")
> 
> In stable/linux-3.18.y, this is also wrong, but no warning shows up, since
> we don't include the right header there, only the wrong one. It's probably
> harmless, but I'm not completely sure about htis one.
> 
> Greg, maybe you can just add this to 3.18.y?

Ok, now queued up, thanks.

greg k-h
