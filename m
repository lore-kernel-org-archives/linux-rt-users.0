From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: unable to handle kernel NULL pointer dereference on
 3.18.13-rt10
Date: Fri, 24 Jul 2015 16:51:08 -0400
Message-ID: <20150724165108.51bd5031@gandalf.local.home>
References: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>
	<alpine.DEB.2.11.1507091605410.5134@nanos>
	<c7ec9b06a341497687b03c367196f534@FE-MBX1012.de.bosch.com>
	<20150710132318.GA27402@linutronix.de>
	<e1b9f04b95504df78cab1eb4e6946238@FE-MBX1012.de.bosch.com>
	<55A36EF0.7020404@linutronix.de>
	<15fcff88e0b4417aba7fd635a98b1ad0@FE-MBX1012.de.bosch.com>
	<55A37DC9.6050604@linutronix.de>
	<55A607CC.3030808@etas.com>
	<12C1B74BDFD05D40B2356A9B12DFA3396C276FDBA2@KEBMXSPMB01.keba.co.at>
	<20150720145648.GA9559@linutronix.de>
	<12C1B74BDFD05D40B2356A9B12DFA3396C27797F4A@KEBMXSPMB01.keba.co.at>
	<b4572ce5932444febd055f1403c58d9e@FE-MBX1012.de.bosch.com>
	<20150722092635.0766400e@gandalf.local.home>
	<alpine.DEB.2.11.1507242054570.18576@nanos>
	<20150724152159.79543722@gandalf.local.home>
	<55B29E3E.9060200@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>,
	eg Engleder Gerhard <eg@keba.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Gratian Crisan <gratian.crisan@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:36318 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754179AbbGXUvL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jul 2015 16:51:11 -0400
In-Reply-To: <55B29E3E.9060200@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 24 Jul 2015 15:21:18 -0500
Gratian Crisan <gratian.crisan@ni.com> wrote:

> 
> In case it saves you some work, we've had some success getting NO_HZ to
> work on 3.14 (x86_64) after back-porting the following commit:
> 
> 3010279f0fc36f0388872203e63ca49912f648fd x86: Tell irq work about self
> IPI support

Thanks, I marked this email so that I see it when I get back.

-- Steve
