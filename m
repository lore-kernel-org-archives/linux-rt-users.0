From: tony@bakeyournoodle.com (Tony Breeds)
Subject: Re: [PATCH v2 2/4] Implement generic time of day clocksource for powerpc machines.
Date: Sat, 22 Sep 2007 07:35:15 +1000
Message-ID: <20070921213515.GC9814@bakeyournoodle.com>
References: <1190345162.620000.305760830507.qpush@thor> <20070921032603.07AF232C889@thor> <20070921145212.7e8a7b89.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pythia.bakeyournoodle.com ([203.82.209.197]:60391 "EHLO
	pythia.bakeyournoodle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761654AbXIUVfS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Sep 2007 17:35:18 -0400
Content-Disposition: inline
In-Reply-To: <20070921145212.7e8a7b89.sfr@canb.auug.org.au>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Sep 21, 2007 at 02:52:12PM +1000, Stephen Rothwell wrote:
> Small comments.

Thanks.

> I think this is redundant as if __USE_RTC() is true, you register
> clocksource_rtc below.

Yup you're right.

> The #ifdef is redundant since if CONFIG_ISERIES is not set,
> firmware_has_feature(FW_FEATURE_ISERIES) is constant 0.

Ahh okay.  I got too fancy for my own good.

patch comming.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
