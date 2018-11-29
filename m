From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v7 00/16] tracing: Hist trigger snapshot and onchange
 additions
Date: Thu, 29 Nov 2018 22:52:25 +0900
Message-ID: <20181129225225.00ab1709c79f63c8e08b49c7@kernel.org>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
        <20181126230928.17883eecfaefd6a29cbbd1c3@kernel.org>
        <1543267288.2529.25.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Shuah Khan <shuah@kernel.org>
To: Tom Zanussi <zanussi@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543267288.2529.25.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 26 Nov 2018 15:21:28 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Masami,
> 
> On Mon, 2018-11-26 at 23:09 +0900, Masami Hiramatsu wrote:
> > Hi Tom,
> > 
> > On Wed, 14 Nov 2018 14:17:57 -0600
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > 
> > > Hi,
> > > 
> > > This is v7 of the hist trigger snapshot and onchange additions
> > > patchset.  It does a bit of refactoring to address the suggestions
> > > made by Masami in v6.
> > 
> > Thank you for fixing it. 
> > 
> > > 
> > > It also adds an additional patch to update the trigger/inter-event
> > > testcases with SPDX license blurbs.
> > > 
> > > BTW, I noticed that with the recent kselftest changes, I now get
> > > mangled output when running the selftests, though I can still see
> > > well
> > > enough that the tests passed as expected.  This happens with any of
> > > the ftrace selftests and not just the trigger selftests.  In my
> > > case,
> > > this is using the stock Terminal in Ubuntu 17.10, in case that
> > > helps.
> > 
> > Hmm, it should be fixed by
> > 8096fbcf55c0 ("selftests/ftrace: Use colored output when available")
> > 
> > Could you check your kernel has this commit?
> > 
> 
> Yes, it does have this commit.
> 
> > BTW, what terminal and environment (especially echo command)
> > did you run your tests on? (It seems echo command didn't accept -e
> > option)
> > 
> 
> For that system, I'm using Gnome terminal 3.24.2 and GNU bash, version
> 4.4.12(1)-release (x86_64-pc-linux-gnu) (Ubuntu 17.10).
> 
> If I change 'echo' to '/bin/echo' in e.g. prlog() it works fine, so it
> must be the inbuilt bash echo that's not doing the right thing.  I
> thought it might be the xpg_echo option, but 'shopt -s xpg_echo'
> doesn't have any effect.
> 
> I also tried on a Fedora 28 system (GNOME terminal 3.28.2, GNU bash,
> version 4.4.23(1)-release (x86_64-redhat-linux-gnu), and it worked
> fine.
> 
> Also, tried a Ubuntu 18.04.1 system (GNOME Terminal 3.28.1, GNU bash,
> version 4.4.19(1)-release (x86_64-pc-linux-gnu) and in that case the
> colors worked fine, but still got the '-e -n' and newlines in the
> output:
> 
> -e -n [28] (instance)  event trigger - test histogram modifiers
> -e 	[PASS]
> -e -n [29] (instance)  event trigger - test histogram trigger
> -e 	[PASS]
> 
> Again, substituting '/bin/echo' in prlog() fixed things in this case
> too.   I guess the builtin bash 'echo' can't be relied on..

OK, then we should use /bin/echo for avoiding this issue.

Thank you!



-- 
Masami Hiramatsu <mhiramat@kernel.org>
