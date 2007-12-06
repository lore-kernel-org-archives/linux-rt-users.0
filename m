From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH Latency Tracer] don't panic on failed bootmem alloc
Date: Thu, 6 Dec 2007 11:55:51 +0100
Message-ID: <20071206105551.GC30838@elte.hu>
References: <1196916093.1645.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:40890 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbXLFK4D (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Dec 2007 05:56:03 -0500
Content-Disposition: inline
In-Reply-To: <1196916093.1645.41.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> This patch prevents a panic on a failed bootmem alloc in the 
> initialization of the tracer buffers.

thanks, good catch!

	Ingo
