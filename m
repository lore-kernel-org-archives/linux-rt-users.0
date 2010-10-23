From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: print user stack
Date: Sat, 23 Oct 2010 11:26:29 -0200
Message-ID: <20101023132629.GC3163@uudg.org>
References: <AANLkTim5r_GoCDp0oKmEjWbf+64UL1r35_3GmCow1ETD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: ratheesh k <ratheesh.ksz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46111 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756766Ab0JWN0h (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Oct 2010 09:26:37 -0400
Received: by yxn35 with SMTP id 35so1278576yxn.19
        for <linux-rt-users@vger.kernel.org>; Sat, 23 Oct 2010 06:26:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim5r_GoCDp0oKmEjWbf+64UL1r35_3GmCow1ETD@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Oct 23, 2010 at 05:46:35PM +0530, ratheesh k wrote:
| I had a strange problem of core file getting truncated. I could not
| find any stack trace.
| 
| 
| So, i wrote a kernel module. Which will find a  task_struct using pid.
|  find_task_jby_pid.
| then i used show_stack for the same task struct to list out the stack
| trace. But it is printing the kernel stack not user stack. Any idea
| how to print user stack .

Sorry if that sounds silly, but have you verified your core file size limit
(ulimit -c)?

About printing the user stack from whithin the kernel, I understand the
utrace folks were working on that.

Cheers,
Luis


-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

