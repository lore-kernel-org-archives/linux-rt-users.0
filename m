From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2.6.21.5-rt17] IPV6: estalished connections are not
	shown with "cat /proc/net/tcp6"
Date: Sat, 23 Jun 2007 09:13:43 +0200
Message-ID: <1182582823.20203.161.camel@chaos>
References: <467C40D3.206@ncos.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, linux-rt-users@vger.kernel.org, dwalker@mvista.com,
	Steven Rostedt <rostedt@goodmis.org>
To: Masayuki Nakagawa <nakagawa.msy@ncos.nec.co.jp>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:35051 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751598AbXFWHNs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jun 2007 03:13:48 -0400
In-Reply-To: <467C40D3.206@ncos.nec.co.jp>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-06-22 at 14:36 -0700, Masayuki Nakagawa wrote:

> So, I suggest a following change.
> The change is to set the flag bit appropriately in __inet6_hash().
> 
> Signed-off-by: Masayuki Nakagawa <nakagawa.msy@ncos.nec.co.jp>

Thanks, applied.

	tglx
