From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Disable tracing when current_tracer is set to "none"
Date: Tue, 10 Jun 2008 21:10:04 +0200
Message-ID: <20080610191004.GA5287@elte.hu>
References: <20080609084025.GC7796@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Ankita Garg <ankita@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:55149 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792AbYFJTKS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Jun 2008 15:10:18 -0400
Content-Disposition: inline
In-Reply-To: <20080609084025.GC7796@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Ankita Garg <ankita@in.ibm.com> wrote:

> Hi,
> 
> Found that inspite of setting the current_tracer to "none", trace from 
> the previous trace type continued to be collected. The patch below 
> fixes this and causes the trace to be disabled when the "none" type is 
> selected.
> 
> Compile and boot tested the patch for functionality.

applied to tip/tracing/ftrace - thanks Ankita.

	Ingo
