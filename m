From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v8 03/22] tracing: Add hist trigger handler.action
 documentation to README
Date: Fri, 14 Dec 2018 11:16:21 -0600
Message-ID: <1544807781.10497.7.camel@kernel.org>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
         <aed0a478f683ac4a7669c62d72e8a01d975e525b.1544483272.git.tom.zanussi@linux.intel.com>
         <20181214221121.6e3d56b7ada3b5fed6124d28@kernel.org>
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
In-Reply-To: <20181214221121.6e3d56b7ada3b5fed6124d28@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Masami,

On Fri, 2018-12-14 at 22:11 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Mon, 10 Dec 2018 18:01:17 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add abbreviated documentation for handlers and actions to README.
> 
> This change itself is good to me, and I would rather like to see this
> in the patch which does actual change, since user (or test code) may
> check this to decide whether the kernel supports this feature or not.
> 
> If we separate this from the change, the test code may fail when
> bisecting.
> 

OK, I'll merge it into '[PATCH v8 01/22] tracing: Refactor hist trigger
action code'.

Thanks,

Tom
