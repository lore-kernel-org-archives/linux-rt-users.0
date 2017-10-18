From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v3 29/33] tracing: Add inter-event hist trigger
 Documentation
Date: Wed, 18 Oct 2017 09:07:36 -0500
Message-ID: <1508335656.524.1.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1506105131.git.tom.zanussi@linux.intel.com>
         <4c06d6648839b387c4df09752329a09816e09f31.1506105131.git.tom.zanussi@linux.intel.com>
         <20171017213657.4b0b78f6@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4475 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbdJROHs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Oct 2017 10:07:48 -0400
In-Reply-To: <20171017213657.4b0b78f6@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2017-10-17 at 21:36 -0400, Steven Rostedt wrote:
> On Fri, 22 Sep 2017 15:00:09 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Add background and details on inter-event hist triggers, including
> > hist variables, synthetic events, and actions.
> 
> One more thing. Make this a separate document. Don't add it to the
> events.txt. Have a histogram.txt or something and just have events.txt
> reference that document.
> 

OK, will do.

Tom

> Thanks!
> 
> -- Steve
> 
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > Signed-off-by: Baohong Liu <baohong.liu@intel.com>
> > ---
> >


