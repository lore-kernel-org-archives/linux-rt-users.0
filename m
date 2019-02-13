From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v14 06/15] tracing: Add hist trigger snapshot() action
Date: Wed, 13 Feb 2019 13:47:19 -0600
Message-ID: <1550087239.7529.1.camel@kernel.org>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
         <c191f511b3d29e1d4a7f36e49d7702a97950e113.1549403369.git.tom.zanussi@linux.intel.com>
         <20190213142551.0b89604e@gandalf.local.home>
         <20190213143523.1e387566@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213143523.1e387566@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On Wed, 2019-02-13 at 14:35 -0500, Steven Rostedt wrote:
> On Wed, 13 Feb 2019 14:25:51 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > I noticed this because we hardcode the size in memcpy. Should hard
> > code
> > it above, otherwise it looks like elt_data->comm may be something
> > other
> > than TASK_COMM_LEN.
> 
> 
> Hi Tom,
> 
> My comments on patch 5 and 6 are the only comments I have on the
> series. Could you address them and post a v15, and I'll pull them in
> and start testing them?
> 

Great, yeah I'll make all those changes and post a v15 shortly.

Thanks,

Tom

> Thanks!
> 
> -- Steve
