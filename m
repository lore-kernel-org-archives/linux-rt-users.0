From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Fri, 3 Mar 2017 17:51:37 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703031733570.4522@nanos>
References: <1486579285.29816.105.camel@intel.com> <20170210190708.gkx5pzxnd6uhfczn@linutronix.de> <1487011713.17279.27.camel@intel.com> <20170215165447.zr4k5rmenwvormdk@linutronix.de> <20170216020516.GB1733@jcartwri.amer.corp.natinst.com>
 <1487212458.10966.7.camel@intel.com> <1487727789.28401.17.camel@intel.com> <20170301152230.mjoi44so6t5qy3q2@linutronix.de> <472B70D9-E1AF-4D14-BE79-ABAAC74BA4DB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Patel, Vedang" <vedang.patel@intel.com>,
        "julia@ni.com" <julia@ni.com>,
        "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Hart, Darren" <darren.hart@intel.com>
To: Tracy Smith <tlsmith3777@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:51102 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbdCCRew (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Mar 2017 12:34:52 -0500
In-Reply-To: <472B70D9-E1AF-4D14-BE79-ABAAC74BA4DB@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 1 Mar 2017, Tracy Smith wrote:

First of all, please do not top post and trim your replies.

> Pleaee isolate the specific release where latency regression occurred if
> the community has not already done so.

Which regression are you talking about?

> Possibly backing out changes specific to timers and posix threads for
> that release to see what impacted latency.

The issue Vedang and Sebastian are discussing is a configuration
problem. Backing out changes should really solve that.

> This is crucial for NXP and others as they migrate to later releases of
> the kernel.

Thanks for the enlightment, we really were unaware about the crucial
importance.

       tglx
