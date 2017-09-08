From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 34/40] tracing: Add 'last error' error facility for
 hist triggers
Date: Fri, 08 Sep 2017 14:44:21 -0500
Message-ID: <1504899861.5276.16.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
         <89e851e663a2322cbe1d952d6e7695dacfed8a96.1504642143.git.tom.zanussi@linux.intel.com>
         <20170908152514.70d50052@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:19433 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756958AbdIHToY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Sep 2017 15:44:24 -0400
In-Reply-To: <20170908152514.70d50052@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2017-09-08 at 15:25 -0400, Steven Rostedt wrote:
> On Tue,  5 Sep 2017 16:57:46 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > +static char *hist_err_str;
> > +static char *last_hist_cmd;
> > +
> > +static int hist_err_alloc(void)
> > +{
> > +	int ret = 0;
> > +
> > +	last_hist_cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> > +	if (!last_hist_cmd)
> > +		return -ENOMEM;
> > +
> > +	hist_err_str = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> > +	if (!hist_err_str) {
> > +		kfree(last_hist_cmd);
> > +		ret = -ENOMEM;
> > +	}
> 
> This gets allocated during boot up. Why have it be allocated in the
> first place? Just have it be strings:
> 
> static char hist_err_str[MAX_FILTER_STR_VAL];
> static char last_hist_cmd[MAX_FILTER_STR_VAL];
> 
> You are not saving any space by doing it this way. In fact, you waste
> it because now you need to add the pointers to the strings.
> 

Good point.  I'll change that along with the other suggestions below.

Thanks,

Tom


