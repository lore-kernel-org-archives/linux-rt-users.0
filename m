From: Ed Tomlinson <edt@aei.ca>
Subject: Re: [ANNOUNCE] 3.0-rt1
Date: Fri, 22 Jul 2011 19:23:17 -0400
Message-ID: <201107221923.17455.edt@aei.ca>
References: <alpine.LFD.2.02.1107222203400.2702@ionos>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail001.aei.ca ([206.123.6.130]:49460 "EHLO mail001.aei.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322Ab1GVXXU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jul 2011 19:23:20 -0400
In-Reply-To: <alpine.LFD.2.02.1107222203400.2702@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Friday 22 July 2011 16:37:24 Thomas Gleixner wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.0-rt1 release.

Thomas,

It does not build here with CONFIG_RCU_TORTURE_TEST=m

Without that it build here on amd64.

Thanks,
Ed
