From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Enabling function trace on call during module init
Date: Fri, 11 Oct 2013 15:02:58 +0200
Message-ID: <5257F702.4010201@linutronix.de>
References: <CA+P49ArN2Nki5oy5MdwKGdcCUYv4i7oEJkypkKWB618T9nHvug@mail.gmail.com> <20130907204811.5d52a6b1@gandalf.local.home> <20131011101531.GD6983@linutronix.de> <20131011083553.3557f104@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Venkat Subbiah <venkat.mlist@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33282 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab3JKNDB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Oct 2013 09:03:01 -0400
In-Reply-To: <20131011083553.3557f104@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/11/2013 02:35 PM, Steven Rostedt wrote:
>> Is this even required / wanted? Usually the module just hooks itself
>> into subsystem like pci_register_driver() and is usually not
>> interresting. The interresting part starts from ->probe() (I think) and
>> this is captured, right?
> 
> Only if the ->probe() is not marked __init

Yes, and this shouldn't be the case due to hotplug which is the
default. So unless you want trace pci_register_driver() & friends we
are good I think :)

> -- Steve
> 

Sebastian
