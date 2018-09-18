From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 8/8] trace: Add alternative synthetic event trace
 action syntax
Date: Wed, 19 Sep 2018 03:54:46 +0900
Message-ID: <20180919035446.4fb6b856ab51229984eb2736@kernel.org>
References: <cover.1536605847.git.tom.zanussi@linux.intel.com>
        <95e91d682061a3a43ea293b20ff4beea755b945a.1536605847.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <95e91d682061a3a43ea293b20ff4beea755b945a.1536605847.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Mon, 10 Sep 2018 14:10:46 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add a 'trace(synthetic_event_name, params)' alternative to
> synthetic_event_name(params).
> 
> Currently, the syntax used for generating synthetic events is to
> invoke synthetic_event_name(params) i.e. use the synthetic event name
> as a function call.
> 
> Users requested a new form that more explicitly shows that the
> synthetic event is in effect being traced.  In this version, a new
> 'trace()' keyword is used, and the synthetic event name is passed in
> as the first argument.

Hmm, what is the advantage of adding this new form?

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
