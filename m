From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
Date: Wed, 19 Dec 2018 15:30:02 -0500
Message-ID: <20181219153002.62ede7e9@gandalf.local.home>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
        <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
        <20181219144047.49fabfa6@gandalf.local.home>
        <1545248809.2396.2.camel@kernel.org>
        <baf7e7af61873fc8bb3833d6bb0501d684a92bf2.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        mhiramat@kernel.org, namhyung@kernel.org, vedang.patel@intel.com,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        mathieu.desnoyers@efficios.com, julia@ni.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Joe Perches <joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <baf7e7af61873fc8bb3833d6bb0501d684a92bf2.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 19 Dec 2018 12:20:19 -0800
Joe Perches <joe@perches.com> wrote:

> > Yeah, I had considered it but wasn't sure it was worth it.  Since
> > you're suggesting it is, I can send another patch on top of these, or
> > feel free if you want to too.  ;-)  
> 
> I believe the 'strlen("foo") -> sizeof("foo") - 1'
> conversions do not change objects at all.
> 
> strlen("constant") is already optimized by gcc to a
> constant value when fed a constant string.

If that's the case (and it probably is), then yeah, strlen is probably
better. As it can handle the "not a constant" that you stated in
another email.

-- Steve


> 
> the strcmp_const macro does seem to make sense as
> the copy/paste/typo possibility is real.
