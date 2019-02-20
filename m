From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v15 15/15] tracing: Add hist trigger action 'expected
 fail' test case
Date: Wed, 20 Feb 2019 13:54:12 -0500
Message-ID: <20190220135412.52a244e7@gandalf.local.home>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
        <1790bf93e01dbdfa1b4af945f42147d92bd565aa.1550100284.git.tom.zanussi@linux.intel.com>
        <20190220121748.7aa83459@gandalf.local.home>
        <1550684302.2027.6.camel@kernel.org>
        <20190220125625.77802cac@gandalf.local.home>
        <1550686231.2027.14.camel@kernel.org>
        <20190220133316.587f3941@gandalf.local.home>
        <1550688315.2027.20.camel@kernel.org>
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
In-Reply-To: <1550688315.2027.20.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 20 Feb 2019 12:45:15 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> > OK, so this has nothing to do with your patch set. I've tested
> > everything else, and I'm ready to finally push my tree to linux-next.
> > 
> > I'm thinking that we should get rid of xfail, as it's really
> > confusing,
> > and I don't understand its purpose. But that shouldn't stop pushing
> > your patches.
> >   
> 
> OK, I'm fine with removing it, if it's too confusing.  IIRC Masami
> suggested it to highlight that not all actions and handlers can be used
> together, so I guess I'll hold off on a patch removing it until he can
> chime in...

Yeah, its a different issue. At the very least, we should change the
color of XFAIL to green.

-- Steve
