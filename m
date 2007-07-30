From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 0/2] VFCIPI support v2
Date: Mon, 30 Jul 2007 14:34:25 -0700
Message-ID: <1185831265.2636.90.camel@imap.mvista.com>
References: <20070730211350.5162.99143.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:43649 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbXG3Vp2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 17:45:28 -0400
In-Reply-To: <20070730211350.5162.99143.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-07-30 at 17:15 -0400, Gregory Haskins wrote:
> The following series Virtual Function-Call IPI support.  Changes from v1:
> 
> 1) Support for platforms other than x86_64
> 2) Support for priority-inheritance.
> 
> Built/tested on x86_64 four-way SMP machine.  Other platforms untested.

Do you have any information regard the amount that IPI's contribute to
overall system latency? My experience is that most IPIs are relatively
short. I wonder if the effect of a threaded IPI might be worse for
latency than non-threaded ..

Daniel
