From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RT-linux on MIPS..
Date: Tue, 9 Jun 2009 23:15:46 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906092313230.3351@localhost.localdomain>
References: <74848fb40906090018m267594f7u6225cf77388f8b4c@mail.gmail.com>  <9f1ddb481cf54eb91d48d76457d8f134@walsimou.com> <fae6a9700906090505m4386dc0clde443ec8f1f857ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: walsimou@walsimou.com, Tom Desouza <desouza.tom@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Vivek Satpute <vivek@linsyssoft.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51633 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbZFIVPw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Jun 2009 17:15:52 -0400
In-Reply-To: <fae6a9700906090505m4386dc0clde443ec8f1f857ec@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Vivek,

please do _NOT_ toppost. Thanks.

On Tue, 9 Jun 2009, Vivek Satpute wrote:
> Could I know the current state of rt-support on MIPS arch ? When will
> it be released with full MIPS support ?

There have been patches posted on this Mailinglist. I did not come
around yet to go through them and there are pending review issues from
the MIPS maintainter IIRC. If you need MIPS -RT support please grab
the patches and help to get them in shape.

Thanks,

	tglx
