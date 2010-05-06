From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Changing real time priority of interrupt handler thread
Date: Thu, 06 May 2010 13:54:47 -0400
Message-ID: <1273168487.22438.44.camel@gandalf.stny.rr.com>
References: <20100505130845.GA9118@rivendell>  <4BE1BADA.3040902@us.ibm.com>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Raphael Hertzog <raphael@ouaza.com>, linux-rt-users@vger.kernel.org
To: Nivedita Singhvi <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:33248 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab0EFRyu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 May 2010 13:54:50 -0400
In-Reply-To: <4BE1BADA.3040902@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-05-05 at 11:37 -0700, Nivedita Singhvi wrote:
> Raphael Hertzog wrote:
> 
> > In case it was not clear, I want to run the IRQ handler of the serial
> > ports at a higher priority than the other ones (like network, disk,
> > etc.) to avoid buffer overruns.
> 
> Have you tried using the rtctl utility and the /etc/rtgroups file?

Also try out tuna. If you have fedora:

 yum install tuna

-- Steve


