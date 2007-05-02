From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: pagefault_enable & pagefault_disable
Date: Wed, 02 May 2007 11:03:03 -0400
Message-ID: <1178118183.19619.20.camel@localhost.localdomain>
References: <1178099954.5300.13.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:50452 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993193AbXEBPDV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 May 2007 11:03:21 -0400
In-Reply-To: <1178099954.5300.13.camel@godzilla.tecnorama.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo,

Looks like setting pagefault_enable and pagefault_disable as export GPL
only has broken those evil video modules.  So I guess until we can make
the daemons of NVidia and ATI into angels, we probably want to keep
those exports non-GPL. :-(

-- Steve


On Wed, 2007-05-02 at 11:59 +0200, Alessio Igor Bogani wrote:
> Hi,
> 
> What is the reason for declare pagefault_enable and pagefault_disable
> as only GPL symbols in mm/memory.c (obviously with Ingo's
> realtime patch applied)? 
> 
> I violate license if i change those two EXPORT_SYMBOL_GPL in EXPORT_SYMBOL?
> 
> Thanks in advance!
