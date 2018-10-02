From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v5 7/8] tracing: Add hist trigger onchange() handler
Date: Tue, 02 Oct 2018 10:35:47 -0500
Message-ID: <1538494547.16568.1.camel@kernel.org>
References: <cover.1538403550.git.tom.zanussi@linux.intel.com>
         <0a17743dc24db781ebe72dcae1306ea5d9a0f7ef.1538403550.git.tom.zanussi@linux.intel.com>
         <20181002165309.da3d63365ca774cf6b47b80c@kernel.org>
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
In-Reply-To: <20181002165309.da3d63365ca774cf6b47b80c@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Tue, 2018-10-02 at 16:53 +0900, Masami Hiramatsu wrote:
> On Mon,  1 Oct 2018 11:18:07 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add support for a hist:onchange($var) handler, similar to the
> > onmax()
> > handler but triggering whenever there's any change in $var, not
> > just a
> > max.
> > 
> > Also, add a testcase for it.
> 
> Could you separate the testcase and document update from this patch,
> since those are maintained in different trees?
> 

OK, will do.

> And also, could you update <tracefs>/README so that the testcase can
> ensure the kernel supports this feature? Since the testcase
> (kselftest)
> will be used for stable kernels, it should check the kernel carefully
> and exit with "unsupported" instead of failure.
> 

Yeah, makes sense, will add that check.

Thanks,

Tom
