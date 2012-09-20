From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] tty: cleanup duplicate functions in tty_buffer
Date: Thu, 20 Sep 2012 17:17:17 +0100
Message-ID: <20120920171717.04ee9098@bob.linux.org.uk>
References: <1348149223-4281-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24697 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752797Ab2ITP7M (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Sep 2012 11:59:12 -0400
In-Reply-To: <1348149223-4281-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Therefor the the tty_scedule_flip() function and replaced it
> everywhere with the tty_flip_buffer_push() beause that function is
> used the most by serial drivers and implements the work queue bypass
> mechanism.

So now when the user sets tty->low_latency on these devices the machine
crashes ?

This is the wrong direction - in fact we have a pile we need to move
the other way !

If they resolve to the same thing in hard RT patches fine, that's a
different question.

Alan
