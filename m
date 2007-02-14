From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Kernel halted after patching RT_PREEMPT patch with NO DEBUG
	MESSEGE
Date: Wed, 14 Feb 2007 11:32:43 -0500
Message-ID: <1171470763.9379.6.camel@localhost.localdomain>
References: <C5065F118AFB3D478B052FC1E9810D9C2A0EE2@tec-mail.ttec.soc-soft.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de
To: Alim Akhtar <alim.akhtar@ttec.soc-soft.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:37841 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373AbXBNQdQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Feb 2007 11:33:16 -0500
In-Reply-To: <C5065F118AFB3D478B052FC1E9810D9C2A0EE2@tec-mail.ttec.soc-soft.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[Content-Type: multipart/mixed; boundary="----=neXtPaRt_1171455051"]
Please do not post to LKML (or to any Linux related site) in any other
format than plain text.  That alone will get you ignored most of the
time.

On Wed, 2007-02-14 at 18:11 +0530, Alim Akhtar wrote:
> hI all
> 
>  
> 
> I have applied patch-2.6.18-rt7 to linux-2.6.18, patching no issues,
> compilation no issues but when I tried to boot the same its hanged
> without giving and kernel oops or any bug. Absolutely no clue on this.
> Please suggest me what went wrong. I am totally stuck up with this.

Have you tried the 2.6.19-rt or 2.6.20-rt series?

[...]

> Freeing init memory: 72K
> 
> Opened Initial Console successful.
> 
>  
> 
> <After this line its halted>

What happened to the BUG_ON that you were experiencing before? Did you
change that code?

-- Steve

> 
