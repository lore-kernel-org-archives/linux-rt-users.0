From: "Joachim Deguara" <joachim.deguara@amd.com>
Subject: Re: [PATCH] Display -rt related stats in /proc/schedstat
Date: Mon, 23 Jul 2007 14:24:34 +0200
Message-ID: <200707231424.35306.joachim.deguara@amd.com>
References: <20070723125925.GE8055@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users" <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Dinakar Guniguntala" <dino@in.ibm.com>
To: "Ankita Garg" <ankita@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:3270 "EHLO
	outbound9-blu-R.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756076AbXGWNRO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 09:17:14 -0400
In-Reply-To: <20070723125925.GE8055@in.ibm.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Monday 23 July 2007 14:59:25 Ankita Garg wrote:
> Hi,
>
> This patch adds support to display captured -rt stats under
> /proc/schedstat.

You need to +1 SCHEDSTAT_VERSION if you are going to do this.  I would also 
suggest the number of fields printed out it in schedstats is invariable of 
CONFIG_PREEMPT_RT rather whether the fields have meaning data or zeros 
depends on the define.  Finally an addition to Documentation/sched-stats.txt 
is always desirable with such a change.

-Joachim
