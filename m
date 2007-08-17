From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] Fixes spurious system load spikes in /proc/loadavgrt
Date: Thu, 16 Aug 2007 20:58:37 -0700
Message-ID: <1187323117.23789.55.camel@imap.mvista.com>
References: <20070817003751.GN3954@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:9233 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbXHQD74 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Aug 2007 23:59:56 -0400
In-Reply-To: <20070817003751.GN3954@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-08-16 at 21:37 -0300, Luis Claudio R. Goncalves wrote:

> 
> Fixes spurious system load spikes observed in /proc/loadavgrt, as described in:
> 
>   Bug 253103: /proc/loadavgrt issues weird results
>   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=253103
> 


It would be nice if you explained better what the code defect was, and
how you fixed it .. One could extract that from the code, but it's nice
if it's backed up with a text description.. Also you should CC lkml next
time.

Daniel
