From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v15 15/15] tracing: Add hist trigger action 'expected
 fail' test case
Date: Fri, 15 Feb 2019 10:36:26 -0500
Message-ID: <20190215103626.61e7d466@gandalf.local.home>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
        <1790bf93e01dbdfa1b4af945f42147d92bd565aa.1550100284.git.tom.zanussi@linux.intel.com>
        <20190216000814.c76e09f4b7597e6892326524@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190216000814.c76e09f4b7597e6892326524@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 16 Feb 2019 00:08:14 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Tom,
> 
> On Wed, 13 Feb 2019 17:42:55 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add a test case verifying that basic action combinations fail as
> > expected.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>  
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Thanks Tom and Masami,

I'm currently in the process of testing these patches (I already
reviewed them, they look good), and will post to linux-next when the
tests are complete (if there's no issues found).

-- Steve
