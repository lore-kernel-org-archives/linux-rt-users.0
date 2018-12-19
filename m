From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
Date: Wed, 19 Dec 2018 15:28:18 -0500
Message-ID: <20181219152818.29068982@gandalf.local.home>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
        <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
        <20181219144047.49fabfa6@gandalf.local.home>
        <1545248809.2396.2.camel@kernel.org>
        <1545250591.4161.2.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545250591.4161.2.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 19 Dec 2018 14:16:31 -0600
Tom Zanussi <zanussi@kernel.org> wrote:


> > Yeah, I had considered it but wasn't sure it was worth it.  Since
> > you're suggesting it is, I can send another patch on top of these, or
> > feel free if you want to too.  ;-)
> >   
> 
> How's this?
> 
> [PATCH] tracing: Introduce and use strcmp_const() for hist triggers
> 
> Provide a new strcmp_const() macro and make use of it instead of the
> longer and more error-prone strncmp(str, "str", sizeof("str") - 1).
> 
> Idea-and-macro-by: Steve Rostedt <rostedt@goodmis.org>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

And I just sent you my version :-) (cross emails).

Note, I changed it to strncmp_const() because it should note that it's
a strncmp() and not an strcmp().

Pretty much identical patches too ;-)

-- Steve
