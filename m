From: Micha Nelissen <micha@neli.hopto.org>
Subject: Re: [MPC52xx]Latency issue with DMA on FEC
Date: Wed, 01 Dec 2010 21:34:25 +0100
Message-ID: <4CF6B151.9020503@neli.hopto.org>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8ABDB@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Jean-Michel Hautbois <jhautbois@gmail.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	linux-rt-users@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from edu-smtp-02.edutel.nl ([88.159.1.176]:53409 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756804Ab0LAUnl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Dec 2010 15:43:41 -0500
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ABDB@saturn3.aculab.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

David Laight wrote:
> The in_le32() not only contains the unwanted 'sync', but also
> a 'twi' (trap immediate - NFI exactly what this does) and 'isync'.
> The 'isync' is particularly horrid and unnecessary (aborts
> the instruction queue and refeches the opcode bytes).

I've also wondered why some time ago, and this is what I could find: 
it's a special sequence that is detected by the bus error handler 
(machine check exception happens on I/O error i.e. aborted pci 
transaction or some such), so that it can 'recover' by continuing at the 
next instruction (and setting an error variable).

Perhaps there is no other way to recover reliably from bus errors?

Micha
