From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Test Scenario for Realtime latency benchmark in the worstcase
 environment.
Date: Thu, 09 Jul 2009 20:25:43 -0700
Message-ID: <1247196343.5398.22.camel@sven.thebigcorporation.com>
References: <1245368556.2153.10.camel@centos51>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>
To: leemgs1@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:50665 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbZGJD0B (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Jul 2009 23:26:01 -0400
Received: by qw-out-2122.google.com with SMTP id 9so241787qwb.37
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Jul 2009 20:26:00 -0700 (PDT)
In-Reply-To: <1245368556.2153.10.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-06-19 at 08:42 +0900, GeunSik Lim wrote:
> Hi all,
> 
> This is Realtime Latency Test Scenario during 24hours.
> In this experiment, 
> I adjusted CPU Affinity Policy to reduce Latency overheads in the Multicore.
> 
> Prepare cyclictest(rt-tests), taskset, chrt, ltp-full-20090531.tar.gz , 
> hackbench , ping, dd, tar, netperf commands.
> 
> I want to listen some advices and opinions about below test scenario 
> to measure a latency guarantee

There are no guarantees.

Only extensive testing can validate the application.

IMO 24 hours is not nearly enough.

I know of stress tests that have been run for multiple weeks.

Regards,

Sven


