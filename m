From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.10.20-rt17, BUG and Oops
Date: Mon, 16 Dec 2013 09:09:09 +0100
Message-ID: <52AEB525.4060907@linutronix.de>
References: <52999A44.7060103@localhost> <529A1511.5050801@osadl.org> <20131130203920.GB24080@linutronix.de> <529A6AFD.9020308@osadl.org> <20131215145325.GH31090@linutronix.de> <52AE402A.90105@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58021 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab3LPIJR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Dec 2013 03:09:17 -0500
In-Reply-To: <52AE402A.90105@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/16/2013 12:50 AM, Carsten Emde wrote:
> On 12/15/2013 03:53 PM, Sebastian Andrzej Siewior wrote:
>> * Carsten Emde | 2013-11-30 23:47:25 [+0100]:
>>> Will apply the fix and the warning - let's see.
>> I do not want to urge anyone but just gentle ping to satisfy my
>> curiosity about the patch.
> I have applied the patch to a number of systems including the one that
> regularly crashed after less than a week. No system crashed so far, and
> uptime of the one that I initially monitored for the crashes is now 15
> days. Please allow for another week of monitoring. If by next weekend
> all patched systems still are up and running, I will submit the patch
> along with a description and a short history when and how the race made
> it into the code.

Sounds great. Thanks.

> 
>     -Carsten.

Sebastian
