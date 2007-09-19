From: tony@bakeyournoodle.com (Tony Breeds)
Subject: Re: [PATCH 1/5] Implement {read,update}_persistent_clock.
Date: Wed, 19 Sep 2007 16:53:29 +1000
Message-ID: <20070919065329.GU9814@bakeyournoodle.com>
References: <1190184586.867449.381310088392.qpush@thor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pythia.bakeyournoodle.com ([203.82.209.197]:51537 "EHLO
	pythia.bakeyournoodle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbXISGxb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Sep 2007 02:53:31 -0400
Content-Disposition: inline
In-Reply-To: <1190184586.867449.381310088392.qpush@thor>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Sep 19, 2007 at 04:49:46PM +1000, Tony Breeds wrote:
> With these functions implemented we cooperate better with the generic
> timekeeping code.  This obsoletes the need for the timer sysdev as a bonus.

I should have added that this patch series applies on top of Benh's 601
fixes.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
