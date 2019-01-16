From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v12 01/16] tracing: Use str_has_prefix() in
 synth_event_create()
Date: Wed, 16 Jan 2019 09:50:49 -0600
Message-ID: <cf937c481afc125e52cd44e0cfe8a54c89d3407f.camel@linux.intel.com>
References: <cover.1547589128.git.tom.zanussi@linux.intel.com>
         <aa6e33335e1ff99c7ac3d00fa5e27faaad04f981.1547589128.git.tom.zanussi@linux.intel.com>
         <7c07519607d08c0afe448a03fb2010bce13cd77f.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Joe Perches <joe@perches.com>, Tom Zanussi <zanussi@kernel.org>,
        rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7c07519607d08c0afe448a03fb2010bce13cd77f.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Joe,

On Tue, 2019-01-15 at 20:59 -0800, Joe Perches wrote:
> On Tue, 2019-01-15 at 16:05 -0600, Tom Zanussi wrote:
> > Since we now have a str_has_prefix() that returns the length, we
> > can
> > use that instead of explicitly calculating it.
> 
> []
> > diff --git a/kernel/trace/trace_events_hist.c
> > b/kernel/trace/trace_events_hist.c
> 
> []
> > @@ -1200,8 +1200,7 @@ static int synth_event_create(int argc, const
> > char **argv)
> >  
> >  	/* This interface accepts group name prefix */
> >  	if (strchr(name, '/')) {
> > -		len = sizeof(SYNTH_SYSTEM "/") - 1;
> > -		if (strncmp(name, SYNTH_SYSTEM "/", len))
> > +		if ((len = str_has_prefix(name, SYNTH_SYSTEM "/")) ==
> > 0)
> 
> Since this is a single test, and not multiple if/else if
> blocks, I believe this would read better on two lines
> 
> 		len = str_has_prefix(name, SYNTH_SYSTEM "/");
> 		if (len == 0)
> 
> >  			return -EINVAL;
> >  		name += len;
> >  	}
> 

And I was so happy to have finally found a legitimate reason to put an
assignment inside an if statement, sigh.  OK, I'll change it.  ;-)

Thanks,

Tom
