From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 28/40] tracing: Add support for 'field variables'
Date: Thu, 7 Sep 2017 19:43:52 -0400
Message-ID: <20170907194352.7c003f7f@gandalf.local.home>
References: <cover.1504642143.git.tom.zanussi@linux.intel.com>
        <af32f8a5f2cfc345dc2b3d34d38400a9d81bd1e4.1504642143.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <af32f8a5f2cfc345dc2b3d34d38400a9d81bd1e4.1504642143.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue,  5 Sep 2017 16:57:40 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Users should be able to directly specify event fields in hist trigger
> 'actions' rather than being forced to explicitly create a variable for
> that purpose.
> 
> Add support allowing fields to be used directly in actions, which
> essentially does just that - creates 'invisible' variables for each
> bare field specified in an action.  If a bare field refers to a field
> on another (matching) event, it even creates a special histogram for
> the purpose (since variables can't be defined on an existing histogram
> after histogram creation).

Can you show some examples here to describe what you mean better?

-- Steve

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 452 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 451 insertions(+), 1 deletion(-)
> 
>
