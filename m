Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:60216 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727240AbeIADkX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Aug 2018 23:40:23 -0400
Date: Fri, 31 Aug 2018 18:30:19 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: PREEMPT_RT_FULL breaks NO_HZ_FULL (full dynticks)
Message-ID: <20180831233019.GK8562@jcartwri.amer.corp.natinst.com>
References: <20180827033922.GA28188@intel.com>
 <20180830141856.tjvispfgqrnz727b@linutronix.de>
 <20180831081819.GB23052@intel.com>
 <20180831163152.vrrntdy7xsej2kwv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831163152.vrrntdy7xsej2kwv@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ramesh Thomas <ramesh.thomas@intel.com>, linux-rt-users@vger.kernel.org, fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org

On Fri, Aug 31, 2018 at 06:31:52PM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-08-31 01:18:20 [-0700], Ramesh Thomas wrote:
[..]
> > 2. Timer is armed even though only a single high priority task is running.
> 
> something must have armed that timer. The clock_nanosleep() API won't
> use those new threads but for instance timer_create() / timer_settime()
> will.

Did we actually ever solve the "ktimersoftd uselessly woken on every
tick" problem?

   Julia
