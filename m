From: eg Engleder Gerhard <eg@keba.com>
Subject: AW: RCU simplification and RT needs
Date: Tue, 6 Jun 2017 06:15:43 +0000
Message-ID: <ee70c449982248668d998898a7b364e8@KEB10314.keba.co.at>
References: <20170605203550.GA7126@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx01.keba.com ([194.116.158.90]:12941 "EHLO mx01.keba.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbdFFGbg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Jun 2017 02:31:36 -0400
In-Reply-To: <20170605203550.GA7126@linux.vnet.ibm.com>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Hello!
Hello Paul,
> 
> At Linus's request, I am simplifying the Linux-kernel RCU implementation, which
> includes removing code that implements features and options that are no longer
> needed.  This is not a half-hearted effort.  In fact, I expect that my submission to
> the next merge window will be a net removal of more than 2500 lines of code.
> 
> But wait, there is more!  ;-)
> 
> Although the following two features are not being axed in v4.13, they will be in
> v4.14 unless someone makes a convincing case for them:
> 
> 1.	The ability to build a CONFIG_RCU_NOCB_CPUS=y kernel without
> 	also specifying CONFIG_NO_HZ_FULL.
> 
> 	Unless someone speaks for this configuration option,
> 	CONFIG_RCU_NOCB_CPUS will be slaved off of CONFIG_NO_HZ_FULL,
> 	and the rcu_nocbs= boot parameter will be dropped.  (RCU would
> 	instead use the nohz_full= boot parameter to determine which
> 	CPUs get their callbacks offloaded.)

We are using CONFIG_RCU_NOCB_CPUS=y without CONFIG_NO_HZ_FULL
with 4.9-rt in our products.
We are not using CONFIG_NO_HZ_FULL, because its use was not recommended for
real time. We set CONFIG_RCU_NOCB_CPUS=y and CONFIG_RCU_NOCB_CPU_ALL=y
to reduce the jitter. This configuration showed the minimal jitter with our application.

We are not relying on the configuration itself. Our goal is just a minimum jitter. Thus, if
CONFIG_NO_HZ_FULL can be used for real time with no negative impact on the
jitter, then we can enable this option.
@tglx: Is CONFIG_NO_HZ_FULL the preferred choice for real-time kernels?

Gerhard
