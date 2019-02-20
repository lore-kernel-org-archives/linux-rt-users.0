From: Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v15 15/15] tracing: Add hist trigger action 'expected
 fail' test case
Date: Wed, 20 Feb 2019 12:45:15 -0600
Message-ID: <1550688315.2027.20.camel@kernel.org>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
         <1790bf93e01dbdfa1b4af945f42147d92bd565aa.1550100284.git.tom.zanussi@linux.intel.com>
         <20190220121748.7aa83459@gandalf.local.home>
         <1550684302.2027.6.camel@kernel.org>
         <20190220125625.77802cac@gandalf.local.home>
         <1550686231.2027.14.camel@kernel.org>
         <20190220133316.587f3941@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220133316.587f3941@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2019-02-20 at 13:33 -0500, Steven Rostedt wrote:
> On Wed, 20 Feb 2019 12:10:31 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > 
> > As far as I understand it (there's no other case of an xfail test
> > in
> > the testsuite, so nothing similar to compare it to), the test
> > output is
> >  correct - here we get the expected fail, XFAIL, and not a FAIL as
> > any
> > test, xfail or normal, that failed would produce:
> 
> Yeah, I've been staring at the code, and commit:
> 
> 915de2adb584a ftracetest: Add POSIX.3 standard and XFAIL result codes
> 
> 
> > 
> > tools/testing/selftests/ftrace# ./ftracetest test.d/trigger/
> > === Ftrace unit tests ===
> > [1] event trigger - test inter-event histogram trigger expected
> > fail actions
> > [XFAIL]
> > [2] event trigger - test extended error support
> > [PASS]
> > 
> > And here the summary shows none failed, while we did have one
> > expected
> > xfail, but that's what was expected, and not a failure:
> > 
> > # of passed:  31
> > # of failed:  0
> > # of unresolved:  0
> > # of untested:  0
> > # of unsupported:  0
> > # of xfailed:  1
> 
> Yeah, but it's marked as RED, which is why I thought it was a
> failure.
> 
> > # of undefined(test bug):  0
> > 
> > If that's not correct, I'll fix it but at this point I'm not sure
> > what
> > the output should be if not that.
> 
> OK, so this has nothing to do with your patch set. I've tested
> everything else, and I'm ready to finally push my tree to linux-next.
> 
> I'm thinking that we should get rid of xfail, as it's really
> confusing,
> and I don't understand its purpose. But that shouldn't stop pushing
> your patches.
> 

OK, I'm fine with removing it, if it's too confusing.  IIRC Masami
suggested it to highlight that not all actions and handlers can be used
together, so I guess I'll hold off on a patch removing it until he can
chime in...

Thanks,

Tom 
 
> Thanks,
> 
> -- Steve
