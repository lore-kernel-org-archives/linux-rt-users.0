From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v8 12/22] tracing: Add hist trigger onchange() handler
 test case
Date: Fri, 14 Dec 2018 11:17:47 -0600
Message-ID: <1544807867.10497.8.camel@kernel.org>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
         <86f8570a993bd8b70e7d8a0260706736b59da2ea.1544483273.git.tom.zanussi@linux.intel.com>
         <20181215011810.61e1009d133fc1f999534d72@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181215011810.61e1009d133fc1f999534d72@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Sat, 2018-12-15 at 01:18 +0900, Masami Hiramatsu wrote:
> On Mon, 10 Dec 2018 18:01:26 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add a test case verifying the basic functionality of the
> > hist:onchange($var) handler.
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> BTW, could you sort these test patches at the end of this series?
> (or at least after 2 features? since both depends on new
> onchange(var) feature)
> 

Sure, I'll move them down.

Thanks,

Tom
