From: Emmanuel Grumbach <egrumbach@gmail.com>
Subject: Re: [RFC 00/10] make iwlwifi RT friendly
Date: Sun, 15 Dec 2013 19:50:23 +0200
Message-ID: <52ADEBDF.5060406@gmail.com>
References: <1386750826-25219-1-git-send-email-emmanuel.grumbach@intel.com> <20131215154843.GL31090@linutronix.de> <52ADEAAF.3080107@gmail.com> <52ADEB0D.3080306@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-rt-users@vger.kernel.org, linux-wireless@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:59430 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3LORu1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 12:50:27 -0500
In-Reply-To: <52ADEB0D.3080306@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 12/15/2013 07:46 PM, Sebastian Andrzej Siewior wrote:
> On 12/15/2013 06:45 PM, Emmanuel Grumbach wrote:
>> No we don't. The primary interrupt just tells the hardware to stop
>> firing interrupts and wakes up the thread as written above.
> 
> Sounds great then.
> 

Ok - I guess I'll submit then internally then before we send them upstream.
