From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [PATCH RESEND] cyclictest: Fixed incorrect wakeup reset interface
Date: Tue, 08 Mar 2011 22:17:08 +0100
Message-ID: <4D769CD4.6090806@osadl.org>
References: <1299287891-591-1-git-send-email-leemgs1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: williams@redhat.com, jkacur@redhat.com,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: Geunsik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:53343 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996Ab1CHWD4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Mar 2011 17:03:56 -0500
In-Reply-To: <1299287891-591-1-git-send-email-leemgs1@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/05/2011 02:18 AM, Geunsik Lim wrote:
> When we try to run ftrace with cyclictest command of rt-test,
> We view the error according to base kernel version.
> We need to modify this hard coded interface.
>
> Signed-off-by: Geunsik Lim<geunsik.lim@samsung.com>
> ---
>   src/cyclictest/cyclictest.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>[..]
> -		setkernvar("latency_hist/wakeup_latency/reset", "1");
> +		setkernvar("latency_hist/wakeup/reset", "1");
This is correct. It considers a directory name change made longtime ago.

> [..]
>   		setkernvar("trace_enabled", "1");
> +		setkernvar("latency_hist/wakeup_latency/reset", "1");
This is not correct - probably an unintended insertion of the line that 
was removed above.

Would you mind to resubmit the patch with the first part only?

	-Carsten.
